// ignore_for_file: use_super_parameters, prefer_const_constructors, library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proje1/mainpage.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: const LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print('User logged in: ${userCredential.user!.email}');

      // Kullanıcı başarıyla giriş yaptığında mainpage sayfasına yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const mainpage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'Kullanıcı bulunamadı.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Yanlış şifre.');
      } else {
        Fluttertoast.showToast(msg: 'Hata: ${e.message}');
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Try Again'),
            content: const Text('An error occurred. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            "assets/images/XOX.png",
            width: 200,
            height: 180,
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 25.0),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 25.0),
          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 77, 105, 196),
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size(150, 50),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}