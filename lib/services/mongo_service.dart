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
    _db = await mongo.Db.create(
        'mongodb+srv://alanpatlani65:DdAymr3xpBLleSMV@cluster0.j6dk5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
    await _db.open();
  }

  mongo.Db get db {
    if (!db.isConnected) {
      throw StateError(
          'Base de Datos no inicializada, llama a connet() primero');
    }
    return _db;
  }

  Future<List<PhoneModel>> getPhones() async {
    final collection = _db.collection('celulares');
    var phones = await collection.find().toList();
    return phones.map((phone) => PhoneModel.fromJson(phone)).toList();
  }
}
