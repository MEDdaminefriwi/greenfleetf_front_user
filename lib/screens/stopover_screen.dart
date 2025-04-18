import 'package:flutter/material.dart';
import 'places_screen.dart';

class StopoverScreen extends StatefulWidget {
  @override
  _StopoverScreenState createState() => _StopoverScreenState();
}

class _StopoverScreenState extends State<StopoverScreen> {
  final List<String> cities = [
    'Tunis', 'Sfax', 'Sousse', 'Gabes', 'Nabeul', 'Bizerte', 'Kairouan', 'Autre'
  ];

  List<String> selectedCities = [];

  final Color primaryColor = const Color(0xFF1B4242);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stopover'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Select cities where you plan to stop:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: cities.map((city) {
                  return CheckboxListTile(
                    title: Text(city),
                    activeColor: primaryColor,
                    value: selectedCities.contains(city),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedCities.add(city);
                        } else {
                          selectedCities.remove(city);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlacesScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
