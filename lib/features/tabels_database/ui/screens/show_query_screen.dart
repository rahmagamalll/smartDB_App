import 'package:flutter/material.dart';

class ShowQueryScreen extends StatelessWidget {
  const ShowQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Query Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Show Query Screen'),
          ],
        ),
      ),
    );
  }
}