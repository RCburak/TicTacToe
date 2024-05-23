// ignore_for_file: camel_case_types, use_super_parameters

import 'package:flutter/material.dart';
import 'package:proje1/gamepage.dart';
import 'package:proje1/gamepage2.dart';
import 'package:proje1/homepage.dart';

void main() {
  runApp(const mainpage());
}

class mainpage extends StatelessWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XOX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainPageScreen(),
    );
  }
}

class MainPageScreen extends StatelessWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XOX', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.black,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildProfileSection(),
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
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "assets/images/userprofil.jpg",
              width: 80,
              height: 80,
            ),
          ),
          const SizedBox(width: 16),
          const Row(
            children: <Widget>[
              Icon(Icons.star, color: Colors.yellow),
              SizedBox(width: 8),
              Text(
                '1000',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
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
            color: Colors.black,
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
