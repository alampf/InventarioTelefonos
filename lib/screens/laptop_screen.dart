import 'package:flutter/material.dart';
import 'package:mongo_aplication/models/laptop_model.dart';
import 'package:mongo_aplication/screens/insert_laptop_screen.dart';
import 'package:mongo_aplication/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class LaptopScreen extends StatefulWidget {
  const LaptopScreen({super.key});

  @override
  State<LaptopScreen> createState() => _LaptopScreenState();
}

class _LaptopScreenState extends State<LaptopScreen> {
  List<LaptopModel> laptops = [];
  late TextEditingController _marcaController;
  late TextEditingController _modeloController;
  late TextEditingController _existenciaController;
  late TextEditingController _precioController;

  @override
  void initState() {
    super.initState();
    _marcaController = TextEditingController();
    _modeloController = TextEditingController();
    _existenciaController = TextEditingController();
    _precioController = TextEditingController();
    _fetchLaptops();
  }

  @override
  void dispose() {
    // Destruir esta Screen cuando saga de esta ventana
    super.dispose();
    _marcaController.dispose();
    _modeloController.dispose();
    _existenciaController.dispose();
    _precioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Laptops'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const insertLaptopScreen(),
                  ),
                );
                _fetchLaptops();
              },
              child: const Icon(
                Icons.add,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: laptops.length,
        itemBuilder: (context, index) {
          var laptop = laptops[index];
          return oneTile(laptop);
        },
      ),
    );
  }

  void _fetchLaptops() async {
    laptops = await MongoService().getLaptops();
    print('En fetch: $laptops');
    setState(() {});
  }

  // Borrar Laptop
  void _deleteLaptop(mongo.ObjectId id) async {
    await MongoService().deleteLaptop(id);
    _fetchLaptops();
  }

  // Actualizar Laptop
  void _updateLaptop(LaptopModel laptop) async {
    await MongoService().updateLaptop(laptop);
    _fetchLaptops();
  }

  void _showEditDialog(LaptopModel laptop) {
    _marcaController.text = laptop.marca;
    _modeloController.text = laptop.modelo;
    _existenciaController.text = laptop.existencia.toString();
    _precioController.text = laptop.precio.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Laptop'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
              TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
              TextField(
                controller: _existenciaController,
                decoration: const InputDecoration(labelText: 'Existencia'),
              ),
              TextField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Recuperar los nuevos valores
                laptop.marca = _marcaController.text;
                laptop.modelo = _modeloController.text;
                laptop.existencia = int.parse(_existenciaController.text);
                laptop.precio = double.parse(_precioController.text);
                _updateLaptop(laptop);
                Navigator.of(context).pop();
              },
              child: const Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  ListTile oneTile(LaptopModel laptop) {
    return ListTile(
      leading: const Icon(Icons.laptop),
      title: Text(laptop.marca),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            laptop.modelo,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'Existencias: ${laptop.existencia}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            'Precio: \$${laptop.precio}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _showEditDialog(laptop),
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _deleteLaptop(laptop.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
