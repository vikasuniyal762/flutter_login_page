import 'package:flutter/material.dart';

class RegistrationLog extends StatefulWidget {
  const RegistrationLog({super.key});

  @override
  State<RegistrationLog> createState() => _RegistrationLogState();
}

class _RegistrationLogState extends State<RegistrationLog> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _confirmPassword;
  final bool _isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.teal, Colors.deepPurple],
        ),
      ),
    );
  }
}
