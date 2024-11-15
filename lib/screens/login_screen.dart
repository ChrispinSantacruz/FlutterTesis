import 'package:flutter/material.dart';
import 'agregar_tesis.dart';
import 'lista_tesis.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListaTesisScreen(
                      role: 'docente',
                      username: _userController.text,
                    ),
                  ),
                );
              },
              child: const Text('Ingresar como Docente'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgregarTesisScreen(
                      onAgregarTesis: (nuevaTesis) {
                        debugPrint('Tesis agregada: ${nuevaTesis.titulo}');
                      },
                      username: _userController.text,
                    ),
                  ),
                );
              },
              child: const Text('Ingresar como Estudiante'),
            ),
          ],
        ),
      ),
    );
  }
}
