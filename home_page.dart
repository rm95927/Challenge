import 'package:flutter/material.dart';
import 'offer_ride_page.dart';
import 'request_ride_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Inicial'),
        actions: [
          // Adiciona o botão de sair no AppBar
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Redireciona o usuário para a tela de login
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OfferRidePage()),
                );
              },
              child: Text('Oferecer Carona'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestRidePage()),
                );
              },
              child: Text('Solicitar Carona'),
            ),
          ],
        ),
      ),
    );
  }
}
