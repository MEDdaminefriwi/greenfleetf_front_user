import 'package:flutter/material.dart';

class PasswordStep extends StatelessWidget {
  final Function(String password) onNext; // Pass password to the next step
  final VoidCallback onBack;

  PasswordStep({required this.onNext, required this.onBack});

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Create Password", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: onBack, child: const Text("Back")),
              ElevatedButton(
                onPressed: () {
                  if (_passwordController.text.isNotEmpty) {
                    onNext(_passwordController.text); // Pass password to the next step
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a password.")),
                    );
                  }
                },
                child: const Text("Next"),
              ),
            ],
          )
        ],
      ),
    );
  }
}