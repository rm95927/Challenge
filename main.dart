// lib/main.dart

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'offer_ride_page.dart';
import 'request_ride_page.dart';
import 'confirmation_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App de Caronas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/offerRide': (context) => OfferRidePage(),
        '/requestRide': (context) => RequestRidePage(),

      },
    );
  }
}
