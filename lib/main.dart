import 'package:flutter/material.dart';
import 'package:mongo_aplication/screens/main_screen.dart';
import 'package:mongo_aplication/services/mongo_service.dart';
import 'package:mongo_aplication/widgets/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoService().connect();
  print('Conexion a MOngoDB establecida');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: tema1(),
      home: const MainScreen(),
    );
  }
}
