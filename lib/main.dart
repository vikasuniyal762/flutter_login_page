import 'package:flutter/material.dart';
import 'RegistrationLog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black12,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: '',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightGreen, Colors.deepPurple],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginPage(),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationLog(),
                      ),
                    );
                  },
                  child:  Text(
                    "Create your account",
                    style: TextStyle(
                      color: Colors.teal[900],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _doNotRememberPassword = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            const Text(
              "GRAB CREW",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Login To Your World",
              style: TextStyle(
                color: Colors.black,
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25.0),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Please enter your email address",
                prefixIcon: Icon(Icons.mail, color: Colors.black),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                }
                if (!isValidEmail(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                setState(() {
                  _isEmailValid = _formKey.currentState!.validate();
                });
                if (_isEmailValid) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              enabled: _isEmailValid,
              decoration: InputDecoration(
                hintText: "Please enter your password",
                prefixIcon: const Icon(Icons.lock, color: Colors.black),
                enabledBorder: _isEmailValid
                    ? null
                    : OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (_isEmailValid) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add additional password validation if needed
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              title: const Text(
                "Do Not Remember Password",
                style: TextStyle(color: Colors.white60),
              ),
              value: _doNotRememberPassword,
              onChanged: (value) {
                setState(() {
                  _doNotRememberPassword = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 50.0),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: const Color(0xFF0069FE),
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, perform login operation
                    // You can access the email and password using _emailController.text and _passwordController.text respectively
                    await performLogin();
                  }
                },
                child: const Text(
                  "Login",
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
    );
  }

  Future<void> performLogin() async {
    // Your login logic goes here
    final email = _emailController.text;
    final password = _passwordController.text;

    // Perform the login operation using the email and password
  }
}

bool isValidEmail(String value) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]{2,}$',
  );
  return emailRegex.hasMatch(value);
}
