// ride_request.dart

import 'package:flutter/material.dart';

class RideRequest {
  String destination;
  String pickupLocation;
  DateTime date;
  TimeOfDay time;
  String passengerName; // Nome do passageiro

  RideRequest({
    required this.destination,
    required this.pickupLocation,
    required this.date,
    required this.time,
    required this.passengerName,
  });
}
