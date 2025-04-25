import 'dart:convert';

import 'package:flutter/material.dart';
import '/models/ride_data.dart';

class ConfirmationScreen extends StatefulWidget {
  final RideData rideData;

  const ConfirmationScreen({Key? key, required this.rideData}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool _showPhone = true;
  final String _driverPhone = "23423423";

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(widget.rideData.toJson()));
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        title: const Text("Confirmation", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B4242),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _sectionTitle("Ride Info"),
            _buildEditableTile(
              context,
              title: "Driver Name",
              value: "AHWA E DRIVER NAME",
              onEdit: () {
                // TODO: Navigate to edit driver name
              },
            ),
            _buildPhoneTile(context),

            _buildEditableTile(
              context,
              title: "Date",
              value: widget.rideData.rideDate != null
                  ? "${widget.rideData.rideDate!.toLocal()}".split(' ')[0]
                  : "N/A",
              onEdit: () {
                // TODO: Navigate to edit date
              },
            ),
            _buildEditableTile(
              context,
              title: "Time",
              value: widget.rideData.rideTime != null
                  ? "${widget.rideData.rideTime!.hour.toString().padLeft(2, '0')}:${widget.rideData.rideTime!.minute.toString().padLeft(2, '0')}"
                  : "N/A",
              onEdit: () {
                // TODO: Navigate to edit time
              },
            ),
            _buildEditableTile(
              context,
              title: "Seats Available",
              value: widget.rideData.numberOfSeat?.toString() ?? "N/A",
              onEdit: () {
                // TODO: Navigate to edit seats
              },
            ),

            const SizedBox(height: 24),
            _sectionTitle("Stopovers"),
            widget.rideData.stopovers.isNotEmpty
                ? Column(
              children: widget.rideData.stopovers.map((location) {
                return ListTile(
                  title: Text(location.nameLocation),
                  leading: const Icon(Icons.location_on_outlined),
                );
              }).toList(),
            )
                : const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("No stopovers added."),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Navigate to edit stopovers
                },
                child: const Text("Edit", style: TextStyle(color: Color(0xFF1B4242))),
              ),
            ),

            const SizedBox(height: 24),
            _sectionTitle("Preferences"),
            widget.rideData.preferences.isNotEmpty
                ? Column(
              children: widget.rideData.preferences.map((pref) {
                return ListTile(
                  title: Text(pref),
                  leading: const Icon(Icons.check_circle_outline),
                );
              }).toList(),
            )
                : const Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text("No preferences selected."),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Navigate to edit preferences
                },
                child: const Text("Edit", style: TextStyle(color: Color(0xFF1B4242))),
              ),
            ),

            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF1B4242)),
                    ),
                    child: const Text("Back", style: TextStyle(color: Color(0xFF1B4242))),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Ride confirmed!")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B4242),
                    ),
                    child: const Text("Confirm Ride"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneTile(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: const Text("Driver Phone", style: TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Opacity(
          opacity: _showPhone ? 1.0 : 0.2,
          child: Text(_driverPhone),
        ),
        trailing: IconButton(
          icon: Icon(
            _showPhone ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF1B4242),
          ),
          onPressed: () {
            setState(() {
              _showPhone = !_showPhone;
            });
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1B4242)),
      ),
    );
  }

  Widget _buildEditableTile(BuildContext context, {
    required String title,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(value),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Color(0xFF1B4242)),
          onPressed: onEdit,
        ),
      ),
    );
  }
}
