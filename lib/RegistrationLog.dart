import 'package:flutter/material.dart';

enum PasswordStrength {
  Weak,
  Good,
  Strong,
}

class RegistrationLog extends StatefulWidget {
  const RegistrationLog({Key? key}) : super(key: key);

  @override
  State<RegistrationLog> createState() => _RegistrationLogState();
}

class _RegistrationLogState extends State<RegistrationLog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  PasswordStrength passwordStrength = PasswordStrength.Weak;
  bool isPasswordVisible = false;
  bool isPasswordFieldEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black12,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.lightGreen, Colors.deepPurple],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              onChanged: () {
                setState(() {
                  passwordStrength = getPasswordStrength();
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        isPasswordFieldEnabled = value.isNotEmpty;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Please enter your email address",
                      prefixIcon: Icon(Icons.mail, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    onChanged: (value) {
                      setState(() {
                        passwordStrength = getPasswordStrength();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Please enter your password",
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    enabled: isPasswordFieldEnabled,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        passwordStrength = getPasswordStrength();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Please confirm your password",
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                    ),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    enabled: isPasswordFieldEnabled,
                  ),
                  SizedBox(height: 10),
                  Text(
                    getPasswordStrengthText(),
                    style: TextStyle(
                      color: getPasswordStrengthColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: const Color(0xFF0069FE),
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Passwords match, perform registration operation
                          final String email = emailController.text;
                          final String password = passwordController.text;
                          final String confirmPassword =
                              confirmPasswordController.text;
                          // Perform registration using email, password, and confirmPassword
                          // ...
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PasswordStrength getPasswordStrength() {
    final String password = passwordController.text;
    if (password.isEmpty) {
      return PasswordStrength.Weak;
    } else if (password.length < 6) {
      return PasswordStrength.Weak;
    } else if (password.length >= 6 && password.length < 10) {
      return PasswordStrength.Good;
    } else {
      return PasswordStrength.Strong;
    }
  }

  String getPasswordStrengthText() {
    switch (passwordStrength) {
      case PasswordStrength.Weak:
        return 'Weak Password';
      case PasswordStrength.Good:
        return 'Good Password';
      case PasswordStrength.Strong:
        return 'Strong Password';
    }
  }

  Color getPasswordStrengthColor() {
    switch (passwordStrength) {
      case PasswordStrength.Weak:
        return Colors.red;
      case PasswordStrength.Good:
        return Colors.orange;
      case PasswordStrength.Strong:
        return Colors.green;
    }
  }
}
