 import 'package:flutter/material.dart';

class AddQueryScreen extends StatelessWidget {
  const AddQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Query Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add Query Screen'),
          ],
        ),
      ),
    );
  }
}