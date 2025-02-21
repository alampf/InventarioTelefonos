import 'package:flutter/material.dart';
import 'package:mongo_aplication/models/phone_model.dart';
import 'package:mongo_aplication/screens/insert_phone_screen.dart';
import 'package:mongo_aplication/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  List<PhoneModel> phones = [];
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
    _fetchPhones();
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
        title: const Text('Inventario de Telefonos'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const insertPhoneScreen(),
                  ),
                );
                _fetchPhones();
              },
              child: const Icon(
                Icons.add,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: phones.length,
          itemBuilder: (context, index) {
            var phone = phones[index];
            return oneTile(phone);
          }),
    );
  }

  void _fetchPhones() async {
    phones = await MongoService().getPhones();
    print('En fetch: $phones');
    setState(() {});
  }

  // Borrar Telefono
  void _deletePhone(mongo.ObjectId id) async {
    await MongoService().deletePhone(id);
    _fetchPhones();
  }

  // Actualizar Telefono
  void _updatePhone(PhoneModel phone) async {
    await MongoService().updatePhone(phone);
    _fetchPhones();
  }

  void _showEditDialog(PhoneModel phone) {
    _marcaController.text = phone.marca;
    _modeloController.text = phone.modelo;
    _existenciaController.text = phone.existencia.toString();
    _precioController.text = phone.precio.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Telefono'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Marca'),
                controller: _marcaController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Modelo'),
                controller: _modeloController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Existencia'),
                controller: _existenciaController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Precio'),
                controller: _precioController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Recuperar los nuevos valores
                phone.marca = _marcaController.text;
                phone.modelo = _modeloController.text;
                phone.existencia = int.parse(_existenciaController.text);
                phone.precio = double.parse(_precioController.text);
                _updatePhone(phone);
                Navigator.pop(context);
              },
              child: const Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  ListTile oneTile(PhoneModel phone) {
    return ListTile(
      title: Text(phone.marca),
      subtitle: Text(phone.modelo),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => _showEditDialog(phone),
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              _deletePhone(phone.id);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
