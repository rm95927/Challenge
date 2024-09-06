

import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String driverName;
  final String passengerName;
  final String pickupLocation;
  final String time;
  final DateTime date;
  final String destination;

  ConfirmationPage({
    required this.driverName,
    required this.passengerName,
    required this.pickupLocation,
    required this.time,
    required this.date,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirmação de Viagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Motorista: $driverName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Passageiro: $passengerName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Local de Embarque: $pickupLocation', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Destino: $destination', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Data: ${date.toLocal()}'.split(' ')[0], style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Horário: $time', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home')); // Retorna para a página inicial
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
