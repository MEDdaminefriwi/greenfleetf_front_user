import 'package:flutter/material.dart';
import 'publish/publish_screen.dart';
import 'publish/stopover_screen.dart';
import 'publish/places_screen.dart';
import 'publish/preferences_screen.dart';
import 'publish/confirmation_screen.dart';
import '/models/ride_data.dart';
import '/models/location_data.dart';
import '/models/stopover_data.dart';

class PublishRideFlow extends StatefulWidget {
  @override
  _PublishRideFlowState createState() => _PublishRideFlowState();
}

class _PublishRideFlowState extends State<PublishRideFlow> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final Color primaryColor = const Color(0xFF1B4242);

  final RideData rideData = RideData.empty();

  void nextPage() {
    if (currentPage < 4) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => currentPage++);
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => currentPage--);
    }
  }

  void submitRide() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(rideData: rideData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Publish Ride",
          style: TextStyle(
            color: Color(0xFF1B4242),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: LinearProgressIndicator(
              value: (currentPage + 1) / 5,
              backgroundColor: primaryColor.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
              minHeight: 5,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                PublishScreen(
                  onNext: ({
                    required Location address,
                    required DateTime date,
                    required TimeOfDay time,
                    required int driverId,
                    required int carId,
                  }) {
                    rideData.driverId = driverId;
                    rideData.rideDate = date;
                    rideData.rideTime = time;
                    rideData.carId = carId;

                    rideData.stopovers.add(
                      Stopovers(
                        location: address,
                        stopoverStatus: 'PENDING',
                      ),
                    );

                    nextPage();
                  },
                ),
                StopoverScreen(
                  startAddress: rideData.stopovers.isNotEmpty
                      ? rideData.stopovers.first.location ??
                      Location(
                        latitude: 0.0,
                        longitude: 0.0,
                        nameLocation: 'Unknown location',
                      )
                      : Location(
                    latitude: 0.0,
                    longitude: 0.0,
                    nameLocation: 'Unknown location',
                  ),
                  onNext: (List<Location> newStopovers) {
                    rideData.stopovers.addAll(
                      newStopovers.map(
                            (loc) => Stopovers(
                          location: loc,
                          stopoverStatus: 'PENDING',
                        ),
                      ),
                    );
                    nextPage();
                  },
                  onBack: () => Navigator.pop(context),
                ),
                PlacesScreen(
                  onNext: (seats, womenOnly) {
                    rideData.numberOfSeat = seats;
                    if (womenOnly) {
                      rideData.preferences ??= [];
                      if (!rideData.preferences!.contains("Women Only")) {
                        rideData.preferences!.add("Women Only");
                      }
                    }
                    nextPage();
                  },
                  onBack: previousPage,
                ),
                PreferencesScreen(
                  onSubmit: (List<String> preferences) {
                    rideData.preferences.addAll(preferences);
                    submitRide();
                  },
                  onBack: previousPage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
