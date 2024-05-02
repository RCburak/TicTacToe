import 'package:flutter/material.dart';
import 'package:proje1/loginpage.dart';
import 'package:proje1/signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomePageapp());
}

class HomePageapp extends StatelessWidget {
  const HomePageapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          minimumSize: const Size(150, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text('Login'),
      ),
      const SizedBox(width: 25.0),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          minimumSize: const Size(150, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
        child: const Text('Sign Up'),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: const Color.fromARGB(255, 167, 162, 162),
      ),
      backgroundColor: const Color.fromARGB(255, 167, 162, 162),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              "assets/images/XOX.png",
              width: 200,
              height: 200,
            ),
            const Text(
              'TicTacToe ',
              style: TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
