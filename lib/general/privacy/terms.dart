import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(minWidth: double.infinity),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.orange),
            child: const Center(
              child: Text(
                'Syarat & Ketentuan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ]),
    );
    ;
  }
}
