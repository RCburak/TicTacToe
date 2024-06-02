// ignore_for_file: use_super_parameters, camel_case_types

import 'package:flutter/material.dart';
import 'package:proje1/gamepage.dart';
import 'package:proje1/gamepage2.dart';
import 'package:proje1/homepage.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XOX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const mainpage(),
    );
  }
}

class mainpage extends StatefulWidget {
  // Convert to StatefulWidget to manage state
  const mainpage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            "assets/images/xoxo1.gif",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Color.fromARGB(255, 233, 244, 30),
            ),
            title: const Text('XOX',
                style: TextStyle(
                  color: Color.fromARGB(255, 233, 244, 30),
                )),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                color: const Color.fromARGB(255, 233, 244, 30),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    _buildGameButtons(context),
                    const Spacer(flex: 2),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Image.asset(
                        "assets/images/XOX.png",
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameButtons(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildGameButton(
              context,
              '1 Player',
              const TicTacToeApp(),
            ),
            const SizedBox(width: 20),
            _buildGameButton(
              context,
              '2 Player',
              const TicTacToeApp2(),
            ),
          ],
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TicTacToeApp()),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            shape: const CircleBorder(),
            backgroundColor: Colors.grey.shade200,
          ),
          child: const Icon(
            Icons.arrow_forward,
            size: 40,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ],
    );
  }

  Widget _buildGameButton(BuildContext context, String text, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        minimumSize: const Size(150, 50),
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey.shade200,
        textStyle: const TextStyle(fontSize: 18.0),
      ),
      child: Text(text),
    );
  }
}
