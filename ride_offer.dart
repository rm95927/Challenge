// ride_offer.dart

import 'package:flutter/material.dart';

class RideOffer {
  String carModel;
  String plateNumber;
  DateTime date;
  TimeOfDay time;
  String destination;
  String driverName; // Nome do motorista

  RideOffer({
    required this.carModel,
    required this.plateNumber,
    required this.date,
    required this.time,
    required this.destination,
    required this.driverName,
  });
}
