import 'package:flutter/material.dart';
import '/models/location_data.dart';

class RideData {
  String? driverId;
  DateTime? rideDate;
  TimeOfDay? rideTime;
  int? numberOfSeat;
  bool published;
  List<Location> stopovers;
  List<String> preferences;

  RideData({
    this.driverId,
    this.rideDate,
    this.rideTime,
    this.numberOfSeat,
    this.published = false,
    List<Location>? stopovers,
    List<String>? preferences,
  })  : stopovers = stopovers ?? [],
        preferences = preferences ?? [];

  // No-argument constructor with default values
  RideData.empty()
      : driverId = null,
        rideDate = null,
        rideTime = null,
        numberOfSeat = null,
        published = false,
        stopovers = [],
        preferences = [];

  factory RideData.fromJson(Map<String, dynamic> json) => RideData(
    driverId: json['driverId'],
    rideDate: DateTime.tryParse(json['rideDate'] ?? ''),
    rideTime: json['rideTime'] != null
        ? TimeOfDay(
      hour: int.parse(json['rideTime'].split(':')[0]),
      minute: int.parse(json['rideTime'].split(':')[1]),
    )
        : null,
    numberOfSeat: json['numberOfSeat'],
    published: json['published'] ?? false,
    stopovers: (json['stopovers'] as List<dynamic>?)
        ?.map((item) => Location.fromJson(item))
        .toList() ??
        [],
    preferences: (json['preferences'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList() ??
        [],
  );

  Map<String, dynamic> toJson() => {
    'driverId': driverId,
    'rideDate': rideDate != null
        ? '${rideDate!.year}-${rideDate!.month.toString().padLeft(2, '0')}-${rideDate!.day.toString().padLeft(2, '0')}'
        : null,
    'rideTime': rideTime != null
        ? '${rideTime!.hour}:${rideTime!.minute}'
        : null,
    'numberOfSeat': numberOfSeat,
    'published': published,
    'stopovers': stopovers.map((e) => e.toJson()).toList(),
    'preferences': preferences,
  };
}
