import 'package:example/ready_inputs.dart';
import 'package:flutter/material.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Inputs", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 20),
              ReadyInput(
                title: 'Name',
                hint: 'Enter your name',
                controller: controller,
              ),
              const SizedBox(height: 20),
              ReadyInput(
                title: 'Disabled Input',
                hint: 'This input is disabled',
                enabled: false,
              ),
              const SizedBox(height: 20),
              ReadyInput(
                title: 'Read-Only Input',
                hint: 'This input is read-only',
                readOnly: true,
              ),
              const SizedBox(height: 20),
              ReadyInput(
                title: 'Suffix Icon Input',
                hint: 'This input has a suffix icon',
                suffixIcon: Icon(Icons.info_outline),
              ),
              const SizedBox(height: 20),
              ReadyInput(
                title: 'Prefix Icon Input',
                hint: 'This input has a prefix icon',
                prefixIcon: Icon(Icons.info_outline),
              ),
              const SizedBox(height: 20),
              ReadyInput(
                title: 'Obscure Input',
                hint: 'Enter password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility_off),
                isObscure: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
