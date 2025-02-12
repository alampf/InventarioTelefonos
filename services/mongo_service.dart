import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  // Servicio para conectar a MongoDB Atlas
  // Usando Singleton
  MongoService._privateConstructor();
  static final MongoService instance = MongoService._privateConstructor();
  Db? _db;
  Future<void> connect() async {
    _db = await Db.create('mongodb+srv://alanpatlani65:DdAymr3xpBLleSMV@cluster0.j6dk5.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
    await _db!.open();
  }

  Future<List<Map<String, dynamic>>> getPhones() async {
    final collection = _db!.collection('celulares');
    return await collection.find().toList();
  }
}
