import 'package:flutter/material.dart';
import 'package:mongo_aplication/screens/phones_screen.dart';
import 'package:mongo_aplication/services/mongo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoService().connect();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PhoneScreen(),
    );
  }
}
