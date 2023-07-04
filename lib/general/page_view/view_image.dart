import 'package:flutter/material.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({super.key, required this.imageUrl});

  final imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Image'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 41, 41, 41)),
        child: Image.network(
          '${imageUrl}',
          fit: BoxFit.contain,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
