import 'package:flutter/material.dart';

class AddNewTableScreen extends StatelessWidget {
  const AddNewTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Table'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add New Table Screen'),
          ],
        ),
      ),
    );
  }
}