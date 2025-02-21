import 'package:flutter/material.dart';
import 'package:mongo_aplication/models/phone_model.dart';
import 'package:mongo_aplication/services/mongo_service.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class insertPhoneScreen extends StatefulWidget {
  const insertPhoneScreen({super.key});

  @override
  State<insertPhoneScreen> createState() => _insertPhoneScreenState();
}

class _insertPhoneScreenState extends State<insertPhoneScreen> {
  late TextEditingController _marcaController;
  late TextEditingController _modeloController;
  late TextEditingController _existenciaController;
  late TextEditingController _precioController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marcaController = TextEditingController();
    _modeloController = TextEditingController();
    _existenciaController = TextEditingController();
    _precioController = TextEditingController();
  }

  void dispose() {
    _marcaController.dispose();
    _modeloController.dispose();
    _existenciaController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  void _insertPhone() async {
    var phone = PhoneModel(
      id: mongo.ObjectId(),
      marca: _marcaController.text,
      modelo: _modeloController.text,
      existencia: int.parse(_existenciaController.text),
      precio: double.parse(_precioController.text),
    );
    await MongoService().insertPhone(phone);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Nuevo Telefono'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _insertPhone,
              child: const Text('Insertar Telefono'),
            ),
          ],
        ),
      ),
    );
  }
}
