import 'package:flutter/material.dart';

class VerificationStep extends StatelessWidget {
  final Function(String code) onSubmit; // Pass verification code to SignUpFlow
  final VoidCallback onBack;

  VerificationStep({required this.onSubmit, required this.onBack});

  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Verification", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 20),
          Text("Enter the verification code sent to your phone/email."),
          const SizedBox(height: 20),
          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Verification Code",
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
                  if (_codeController.text.isNotEmpty) {
                    onSubmit(_codeController.text); // Pass verification code
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter the verification code.")),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ],
          )
        ],
      ),
    );
  }
}