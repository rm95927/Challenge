

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ride_offer.dart';
import '../ride_data.dart';

class OfferRidePage extends StatefulWidget {
  @override
  _OfferRidePageState createState() => _OfferRidePageState();
}

class _OfferRidePageState extends State<OfferRidePage> {
  final _carModelController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _destinationController = TextEditingController();
  final _driverNameController = TextEditingController(); // Adicionado para capturar o nome do motorista
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // Função para selecionar a data
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  // Função para selecionar o horário
  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  // Função para oferecer a carona
  void offerRide() {
    // Validação simples dos campos
    if (_carModelController.text.isEmpty ||
        _plateNumberController.text.isEmpty ||
        _destinationController.text.isEmpty ||
        _driverNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Por favor, preencha todos os campos.');
      return;
    }

    // Criação de uma nova oferta de carona
    RideOffer newOffer = RideOffer(
      carModel: _carModelController.text,
      plateNumber: _plateNumberController.text,
      date: selectedDate,
      time: selectedTime,
      destination: _destinationController.text,
      driverName: _driverNameController.text,
    );

    // Adiciona a oferta à lista de ofertas
    rideOffers.add(newOffer);

    Fluttertoast.showToast(msg: 'Carona oferecida com sucesso!');

    // Limpa os campos após a oferta
    _carModelController.clear();
    _plateNumberController.clear();
    _destinationController.clear();
    _driverNameController.clear();

    Navigator.pop(context); // Volta para a página inicial
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Oferecer Carona')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Para evitar overflow em telas menores
          child: Column(
            children: [
              TextField(
                controller: _driverNameController,
                decoration: InputDecoration(labelText: 'Nome do Motorista'),
              ),
              TextField(
                controller: _carModelController,
                decoration: InputDecoration(labelText: 'Modelo do Carro'),
              ),
              TextField(
                controller: _plateNumberController,
                decoration: InputDecoration(labelText: 'Placa do Carro'),
              ),
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Destino'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text('Selecionar Dia'),
              ),
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _selectTime(context),
                child: Text('Selecionar Horário'),
              ),
              Text("${selectedTime.format(context)}"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: offerRide,
                child: Text('Oferecer Carona'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
