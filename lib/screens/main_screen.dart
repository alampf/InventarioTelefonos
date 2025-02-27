import 'package:flutter/material.dart';
import 'package:mongo_aplication/screens/laptop_screen.dart';
import 'package:mongo_aplication/screens/phones_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de Productos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const PhoneScreen(),
                ),
              );
            },
            child: const Text('Inventario de Telefonos'),
          ),
          ElevatedButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LaptopScreen(),
                ),
              );
            },
            child: Text('Inventario de Laptops'),
          ),
        ],
      ),
    );
  }
}
