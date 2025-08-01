import 'package:flutter/material.dart';
import 'package:ready_widgets/inputs/custom_input.dart';

void main() {
  runApp(const MyExampleApp());
}

class MyExampleApp extends StatelessWidget {
  const MyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Ready Widgets Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomInput(
            title: 'Name',
            hint: 'Enter your name',
            controller: controller,
          ),
        ),
      ),
    );
  }
}
