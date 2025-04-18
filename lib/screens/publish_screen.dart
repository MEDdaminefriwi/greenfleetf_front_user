import 'package:flutter/material.dart';
import 'stopover_screen.dart';

class PublishScreen extends StatefulWidget {
  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  String? address;
  String? destination;
  String? dateTime;
  String? car;

  final Color primaryColor = const Color(0xFF1B4242);

  Future<void> _showInputDialog(String label) async {
    if (label == 'Car') {
      final cars = [
        'Hyundai Grand i10',
        'Kia Picanto',
        'Kia Rio',
        'Golf 5',
        'Golf 6',
        'Golf 7',
        'Golf 8',
        'x6',
        'clio bombé',
        'Autre',
      ];

      final selectedCar = await showDialog<String>(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Select a car'),
          children: cars
              .map((carName) => SimpleDialogOption(
            onPressed: () => Navigator.pop(context, carName),
            child: Text(carName),
          ))
              .toList(),
        ),
      );

      if (selectedCar != null) {
        setState(() {
          car = selectedCar;
        });
      }

      return;
    }

    if (label == 'Date & Time') {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (pickedTime != null) {
          final formattedDateTime =
              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} "
              "${pickedTime.format(context)}";
          setState(() {
            dateTime = formattedDateTime;
          });
        }
      }

      return;
    }

    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Enter $label'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Type your $label here'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Done'),
          ),
        ],
      ),
    );

    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        if (label == 'Address') address = result;
        if (label == 'Destination') destination = result;
      });
    }
  }

  Widget _buildField(String label, String? value) {
    return InkWell(
      onTap: () => _showInputDialog(label),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primaryColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(_getIcon(label), color: primaryColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value ?? 'Select $label',
                style: TextStyle(
                  fontSize: 16,
                  color: value != null ? Colors.black : Colors.grey,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String label) {
    switch (label) {
      case 'Address':
        return Icons.home;
      case 'Destination':
        return Icons.location_on;
      case 'Date & Time':
        return Icons.calendar_today;
      case 'Car':
        return Icons.directions_car;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Text("Publish Ride"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildField('Address', address),
            _buildField('Destination', destination),
            _buildField('Date & Time', dateTime),
            _buildField('Car', car),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => StopoverScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
