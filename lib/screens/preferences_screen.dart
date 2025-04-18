import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _chatPreference;
  String? _smokingPreference;
  String? _musicPreference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Travel Preferences")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Plan Your Dream Trip',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                "Tell us what makes your wanderlust ignite and we’ll find the perfect adventure for you.",
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 20),

              _buildSectionTitle("Chattiness"),
              _buildRadio("I love to chat", _chatPreference, (val) => setState(() => _chatPreference = val)),
              _buildRadio("I’m chatty when I feel comfortable", _chatPreference, (val) => setState(() => _chatPreference = val)),
              _buildRadio("I’m the quiet type", _chatPreference, (val) => setState(() => _chatPreference = val)),

              SizedBox(height: 20),
              _buildSectionTitle("Smoking"),
              _buildRadio("I’m fine with smoking", _smokingPreference, (val) => setState(() => _smokingPreference = val)),
              _buildRadio("Cigarette breaks outside the car are ok", _smokingPreference, (val) => setState(() => _smokingPreference = val)),
              _buildRadio("No smoking, please", _smokingPreference, (val) => setState(() => _smokingPreference = val)),

              SizedBox(height: 20),
              _buildSectionTitle("Music"),
              _buildRadio("It’s all about the playlist!", _musicPreference, (val) => setState(() => _musicPreference = val)),
              _buildRadio("I’ll jam depending on the mood", _musicPreference, (val) => setState(() => _musicPreference = val)),
              _buildRadio("Silence is golden", _musicPreference, (val) => setState(() => _musicPreference = val)),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_chatPreference != null &&
                      _smokingPreference != null &&
                      _musicPreference != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Preferences saved!')),
                    );
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select all preferences')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }

  Widget _buildRadio(String title, String? groupValue, Function(String?) onChanged) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
