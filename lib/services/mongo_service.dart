import 'dart:io';

import 'package:mongo_aplication/models/phone_model.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class MongoService {
  // Servicio para conectar a MongoDB Atlas
  // Usando Singleton
  // MongoService._privateConstructor();
  static final MongoService _instance = MongoService._internal();
  late mongo.Db _db;

  MongoService._internal();
  factory MongoService() {
    return _instance;
  }

  Future<void> connect() async {
    try {
      _db = await mongo.Db.create(
          'mongodb+srv://alanpatlani65:DdAymr3xpBLleSMV@cluster0.j6dk5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
      await _db.open();
      _db.databaseName = 'productos';
      print('Conexion a MongoDB establecida');
    } on SocketException catch (e) {
      print('Error de Conexion: $e');
      rethrow;
    }
  }

  mongo.Db get db {
    if (!db.isConnected) {
      throw StateError(
          'Base de Datos no inicializada, llama a connet() primero');
    }
    return _db;
  }

  // Mandar a llamar los datos de base de datos
  Future<List<PhoneModel>> getPhones() async {
    final collection = _db.collection('celulares');
    print('Coleccion Obtenida: $collection');
    var phones = await collection.find().toList();
    print('En MongoService: $phones');
    if (phones.isEmpty) {
      print('No se encontraron datos en la coleccion');
    }
    return phones.map((phone) => PhoneModel.fromJson(phone)).toList();
  }

  // Insertar un nuevo telefono
  Future<void> insertPhone(PhoneModel phone) async {
    _db.databaseName = 'productos';
    final collection = _db.collection('celulares');
    await collection.insert(phone.toJson());
  }

  // Actualizar un telefono
  Future<void> updatePhone(PhoneModel phone) async {
    _db.databaseName = 'productos';
    final collection = _db.collection('celulares');
    await collection.updateOne(
        mongo.where.eq('_id', phone.id),
        mongo.modify
            .set('marca', phone.marca)
            .set('modelo', phone.modelo)
            .set('existencia', phone.existencia)
            .set('precio', phone.precio));
  }

  // Eliminar un telefono
  Future<void> deletePhone(mongo.ObjectId id) async {
    var collection = _db.collection('celulares');
    await collection.remove(mongo.where.eq('_id', id));
  }
}
