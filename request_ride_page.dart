

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ride_request.dart';
import '../ride_data.dart';
import 'confirmation_page.dart';
import '../ride_offer.dart';

class RequestRidePage extends StatefulWidget {
  @override
  _RequestRidePageState createState() => _RequestRidePageState();
}

class _RequestRidePageState extends State<RequestRidePage> {
  final _destinationController = TextEditingController();
  final _pickupLocationController = TextEditingController();
  final _passengerNameController = TextEditingController(); // Adicionado para capturar o nome do passageiro
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

  // Função para solicitar a carona e realizar o match
  void requestRide() {
    // Validação simples dos campos
    if (_destinationController.text.isEmpty ||
        _pickupLocationController.text.isEmpty ||
        _passengerNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Por favor, preencha todos os campos.');
      return;
    }

    // Criação de uma nova solicitação de carona
    RideRequest newRequest = RideRequest(
      destination: _destinationController.text,
      pickupLocation: _pickupLocationController.text,
      date: selectedDate,
      time: selectedTime,
      passengerName: _passengerNameController.text,
    );

    // Adiciona a solicitação à lista de solicitações
    rideRequests.add(newRequest);

    // Verifica se há uma oferta de carona que corresponda à solicitação
    RideOffer? matchedOffer = matchRides(newRequest);

    if (matchedOffer != null) {
      Fluttertoast.showToast(msg: 'Carona encontrada!');

      // Redireciona para a página de confirmação com os detalhes do match
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationPage(
            driverName: matchedOffer.driverName,
            passengerName: newRequest.passengerName,
            pickupLocation: newRequest.pickupLocation,
            time: "${newRequest.time.format(context)}",
            date: newRequest.date,
            destination: newRequest.destination,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Nenhuma carona disponível para os dados fornecidos.');
    }

    // Limpa os campos após a solicitação
    _destinationController.clear();
    _pickupLocationController.clear();
    _passengerNameController.clear();
  }

  // Função para realizar o match entre solicitação e oferta
  RideOffer? matchRides(RideRequest request) {
    for (var offer in rideOffers) {
      // Verifica se o destino, data e horário coincidem
      if (offer.destination.toLowerCase() == request.destination.toLowerCase() &&
          isSameDate(offer.date, request.date) &&
          isSameTime(offer.time, request.time)) {
        return offer; // Retorna a oferta correspondente
      }
    }
    return null; // Nenhuma correspondência encontrada
  }

  // Função para comparar datas (ignorando a hora)
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Função para comparar horários (permitindo uma margem de 30 minutos)
  bool isSameTime(TimeOfDay time1, TimeOfDay time2) {
    int totalMinutes1 = time1.hour * 60 + time1.minute;
    int totalMinutes2 = time2.hour * 60 + time2.minute;
    return (totalMinutes1 - totalMinutes2).abs() <= 30; // Margem de 30 minutos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Solicitar Carona')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Para evitar overflow em telas menores
          child: Column(
            children: [
              TextField(
                controller: _passengerNameController,
                decoration: InputDecoration(labelText: 'Nome do Passageiro'),
              ),
              TextField(
                controller: _pickupLocationController,
                decoration: InputDecoration(labelText: 'Local de Embarque'),
              ),
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(labelText: 'Endereço de Destino'),
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
                onPressed: requestRide,
                child: Text('Solicitar Carona'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
