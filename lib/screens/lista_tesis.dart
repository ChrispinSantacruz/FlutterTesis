import 'package:flutter/material.dart';

class ListaTesisScreen extends StatelessWidget {
  final String role;
  final String username;

  const ListaTesisScreen({
    required this.role,
    required this.username,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tesis'),
      ),
      body: Center(
        child: Text('Bienvenido $role: $username'),
      ),
    );
  }
}
