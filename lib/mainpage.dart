import 'package:flutter/material.dart';
import 'package:proje1/gamepage.dart';
import 'package:proje1/gamepage2.dart';
import 'package:proje1/homepage.dart';

void main() {
  runApp(const mainpage());
}

// ignore: camel_case_types
class mainpage extends StatelessWidget {
  // ignore: use_super_parameters
  const mainpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XOX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const mainpageScreen(),
    );
  }
}

// ignore: camel_case_types
class mainpageScreen extends StatelessWidget {
  // ignore: use_super_parameters
  const mainpageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XOX'),
        backgroundColor: const Color.fromARGB(255, 177, 173, 173),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            color: const Color.fromARGB(255, 0, 0, 0),
            onPressed: () {
              // Çıkış
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 167, 162, 162),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 0), // Sol kenardan boşluk
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), // Köşeleri yuvarla
              border: Border.all(
                color: Colors.black,
                width: 4,
              ), // Çerçeve rengi ve kalınlığı
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                  4.0), // Çerçeve ile resim arasındaki boşluk
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Sağa hizala
                    children: [
                      Image.asset(
                        "assets/images/userprofil.jpg",
                        width: 110,
                        height: 110,
                      ),
                      const SizedBox(width: 5),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(width: 5),
                          Text(
                            '1000', // Buraya kullanıcının kazandığı puanları dinamik olarak ekleyebilirsiniz
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 150),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicTacToeApp(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(150, 50),
                  foregroundColor: Color.fromARGB(255, 0, 0, 0),
                  backgroundColor: Color.fromARGB(255, 234, 226, 226),
                ),
                child: const Text(
                  '1 Player',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TicTacToeApp2(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(150, 50),
                  foregroundColor: Color.fromARGB(255, 0, 0, 0),
                  backgroundColor: Color.fromARGB(255, 234, 226, 226),
                ),
                child: const Text(
                  '2 Player',
                  style: TextStyle(fontSize: 18.0),
                ),
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
              // Oyuna başlama butonuna tıklandığında yapılacak işlemler
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: const CircleBorder(),
              backgroundColor: Color.fromARGB(255, 234, 226, 226),
            ),
            child: const Icon(
              Icons.arrow_forward,
              size: 40,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/XOX.png",
                  width: 70,
                  height: 70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
