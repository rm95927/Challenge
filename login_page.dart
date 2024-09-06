import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Dados temporários de cadastro
  String? registeredEmail;
  String? registeredPassword;

  void login() {
    if (_emailController.text == registeredEmail && _passwordController.text == registeredPassword) {
      // Se as credenciais estiverem corretas, navegue para a HomePage
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Exibe mensagem de erro se as credenciais estiverem incorretas
      Fluttertoast.showToast(msg: 'E-mail ou senha incorretos');
    }
  }

  void navigateToSignup() async {
    // Navega para a tela de cadastro e espera o resultado
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );

    // Atualiza os dados de login com o que foi cadastrado
    if (result != null) {
      setState(() {
        registeredEmail = result['email'];
        registeredPassword = result['password'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Traveling Ride App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: navigateToSignup,
              child: Text('Não tem conta? Cadastre-se'),
            ),
          ],
        ),
      ),
    );
  }
}
