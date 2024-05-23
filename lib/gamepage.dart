import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:proje1/mainpage.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToeBoard(),
    );
  }
}

class TicTacToeBoard extends StatefulWidget {
  const TicTacToeBoard({Key? key}) : super(key: key);

  @override
  _TicTacToeBoardState createState() => _TicTacToeBoardState();
}

class _TicTacToeBoardState extends State<TicTacToeBoard> {
  late List<List<String>> _board;
  late bool _isXNext;
  int _teamXScore = 0;
  int _teamOScore = 0;
  int _boardSize = 3;
  late ConfettiController _confettiController;
  int _moveTimeInSeconds = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    _startTimer();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _timer.cancel(); // Timer'ı iptal et
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_moveTimeInSeconds > 0) {
          _moveTimeInSeconds--;
        } else {
          // Zaman dolduğunda otomatik olarak sırayı değiştir
          _isXNext = !_isXNext;
          _moveTimeInSeconds = 10; // Yeni bir zaman başlat
        }
      });
    });
  }

  void _initializeBoard() {
    _board = List.generate(_boardSize, (_) => List.filled(_boardSize, ''));
    _isXNext = true;
  }

  void _resetBoard() {
    setState(() {
      _board = List.generate(_boardSize, (_) => List.filled(_boardSize, ''));
      _isXNext = true;
    });
  }

  void _resetBoard2() {
    setState(() {
      if (_boardSize > 3) {
        _boardSize--;
      }
      _board = List.generate(_boardSize, (_) => List.filled(_boardSize, ''));
      _isXNext = true;
    });
  }

  void _resetScores() {
    setState(() {
      _teamXScore = 0;
      _teamOScore = 0;
    });
  }

  void _markCell(int row, int col) {
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = '❌'; // İnsan oyuncunun hamlesi
        _isXNext =
            false; // İnsan oyuncu oynamış oldu, sıra yapay zeka oyuncusunda
        _moveTimeInSeconds = 10; // Hamle yapıldığında zamanı sıfırla
      });
      _checkWinner();
    }
  }

  void _aiMove() {
    // Öncelikli olarak, yapay zeka kazanabileceği bir hamle yapmaya çalışır
    if (!_makeWinningMove()) {
      // Sonrasında, rakibin kazanmasını engelleyecek bir hamle yapmaya çalışır
      if (!_blockOpponentWin()) {
        // Eğer ne kazanabileceği ne de rakibin kazanmasını engelleyebileceği bir hamle yoksa,
        // stratejik bir hamle yapar
        _makeStrategicMove();
      }
    }
  }

  bool _makeWinningMove() {
    // Önce her satırı kontrol eder
    for (int i = 0; i < _boardSize; i++) {
      // Eğer iki aynı işaret ve bir boş hücre varsa, o boş hücreye kendi işaretini koyar
      if (_board[i].where((cell) => cell == '⭕').length == 2 &&
          _board[i].contains('')) {
        int columnIndex = _board[i].indexOf('');
        setState(() {
          _board[i][columnIndex] = '⭕';
          _isXNext = true;
          _moveTimeInSeconds = 10;
        });
        _checkWinner();
        return true;
      }
    }

    // Sonra her sütunu kontrol eder
    for (int j = 0; j < _boardSize; j++) {
      // Eğer iki aynı işaret ve bir boş hücre varsa, o boş hücreye kendi işaretini koyar
      if (_board.map((row) => row[j]).where((cell) => cell == '⭕').length ==
              2 &&
          _board.map((row) => row[j]).contains('')) {
        int rowIndex = _board.map((row) => row[j]).toList().indexOf('');
        setState(() {
          _board[rowIndex][j] = '⭕';
          _isXNext = true;
          _moveTimeInSeconds = 10;
        });
        _checkWinner();
        return true;
      }
    }

    // Diagonal kazanma durumunu kontrol eder
    if (_board[0][0] == '⭕' && _board[1][1] == '⭕' && _board[2][2] == '') {
      setState(() {
        _board[2][2] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][0] == '⭕' &&
        _board[1][1] == '' &&
        _board[2][2] == '⭕') {
      setState(() {
        _board[1][1] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][0] == '' &&
        _board[1][1] == '⭕' &&
        _board[2][2] == '⭕') {
      setState(() {
        _board[0][0] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][2] == '⭕' &&
        _board[1][1] == '⭕' &&
        _board[2][0] == '') {
      setState(() {
        _board[2][0] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][2] == '⭕' &&
        _board[1][1] == '' &&
        _board[2][0] == '⭕') {
      setState(() {
        _board[1][1] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][2] == '' &&
        _board[1][1] == '⭕' &&
        _board[2][0] == '⭕') {
      setState(() {
        _board[0][2] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    }

    return false;
  }

  bool _blockOpponentWin() {
    // Önce her satırı kontrol eder
    for (int i = 0; i < _boardSize; i++) {
      // Eğer iki aynı işaret ve bir boş hücre varsa, o boş hücreye kendi işaretini koyar
      if (_board[i].where((cell) => cell == '❌').length == 2 &&
          _board[i].contains('')) {
        int columnIndex = _board[i].indexOf('');
        setState(() {
          _board[i][columnIndex] = '⭕';
          _isXNext = true;
          _moveTimeInSeconds = 10;
        });
        _checkWinner();
        return true;
      }
    }

    // Sonra her sütunu kontrol eder
    for (int j = 0; j < _boardSize; j++) {
      // Eğer iki aynı işaret ve bir boş hücre varsa, o boş hücreye kendi işaretini koyar
      if (_board.map((row) => row[j]).where((cell) => cell == '❌').length ==
              2 &&
          _board.map((row) => row[j]).contains('')) {
        int rowIndex = _board.map((row) => row[j]).toList().indexOf('');
        setState(() {
          _board[rowIndex][j] = '⭕';
          _isXNext = true;
          _moveTimeInSeconds = 10;
        });
        _checkWinner();
        return true;
      }
    }

    // Diagonal kazanma durumunu kontrol eder
    if (_board[0][0] == '❌' && _board[1][1] == '❌' && _board[2][2] == '') {
      setState(() {
        _board[2][2] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][0] == '❌' &&
        _board[1][1] == '' &&
        _board[2][2] == '❌') {
      setState(() {
        _board[1][1] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][0] == '' &&
        _board[1][1] == '❌' &&
        _board[2][2] == '❌') {
      setState(() {
        _board[0][0] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][2] == '❌' &&
        _board[1][1] == '❌' &&
        _board[2][0] == '') {
      setState(() {
        _board[2][0] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][2] == '❌' &&
        _board[1][1] == '' &&
        _board[2][0] == '❌') {
      setState(() {
        _board[1][1] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    } else if (_board[0][2] == '' &&
        _board[1][1] == '❌' &&
        _board[2][0] == '❌') {
      setState(() {
        _board[0][2] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return true;
    }

    return false;
  }

  void _makeStrategicMove() {
    // Basit bir strateji: Orta hücreye işaret koyar, eğer müsaitse.
    if (_board[_boardSize ~/ 2][_boardSize ~/ 2] == '') {
      setState(() {
        _board[_boardSize ~/ 2][_boardSize ~/ 2] = '⭕';
        _isXNext = true;
        _moveTimeInSeconds = 10;
      });
      _checkWinner();
      return;
    }

    // Rastgele boş bir hücre seçer ve işaret koyar.
    Random random = Random();
    int row, col;
    do {
      row = random.nextInt(_boardSize);
      col = random.nextInt(_boardSize);
    } while (_board[row][col] != '');

    setState(() {
      _board[row][col] = '⭕';
      _isXNext = true;
      _moveTimeInSeconds = 10;
    });
    _checkWinner();
  }

  void _checkWinner() {
    if (_checkRow() || _checkColumn() || _checkDiagonal()) {
      String winner = _isXNext ? 'O' : 'X';
      _updateScore(winner);
      _confettiController.play(); // Konfeti başlat
      _resetBoard2();
    } else if (_checkDraw()) {
      _increaseBoardSize();
    } else if (!_isXNext) {
      _aiMove(); // Yapay zeka hamlesi
    }
  }

  void _increaseBoardSize() {
    setState(() {
      _boardSize++;
      _resetBoard();
    });
  }

  bool _checkRow() {
    for (int i = 0; i <= _boardSize - 3; i++) {
      for (int j = 0; j < _boardSize; j++) {
        if (_board[i][j] != '' &&
            _board[i][j] == _board[i + 1][j] &&
            _board[i + 1][j] == _board[i + 2][j]) {
          return true;
        }
      }
    }
    return false;
  }

  bool _checkColumn() {
    for (int i = 0; i < _boardSize; i++) {
      for (int j = 0; j <= _boardSize - 3; j++) {
        if (_board[i][j] != '' &&
            _board[i][j] == _board[i][j + 1] &&
            _board[i][j + 1] == _board[i][j + 2]) {
          return true;
        }
      }
    }
    return false;
  }

  bool _checkDiagonal() {
    for (int i = 0; i <= _boardSize - 3; i++) {
      for (int j = 0; j <= _boardSize - 3; j++) {
        if (_board[i][j] != '' &&
            _board[i][j] == _board[i + 1][j + 1] &&
            _board[i + 1][j + 1] == _board[i + 2][j + 2]) {
          return true;
        }
        if (_board[i][j + 2] != '' &&
            _board[i][j + 2] == _board[i + 1][j + 1] &&
            _board[i + 1][j + 1] == _board[i + 2][j]) {
          return true;
        }
      }
    }
    return false;
  }

  bool _checkDraw() {
    for (int i = 0; i < _boardSize; i++) {
      for (int j = 0; j < _boardSize; j++) {
        if (_board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  void _updateScore(String player) {
    if (player == 'X') {
      setState(() {
        _teamXScore++;
      });
    } else if (player == 'O') {
      setState(() {
        _teamOScore++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const mainpage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'X: $_teamXScore  O: $_teamOScore',
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                'Time left: $_moveTimeInSeconds seconds',
                style: const TextStyle(fontSize: 16),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _boardSize,
                ),
                itemCount: _boardSize * _boardSize,
                itemBuilder: (context, index) {
                  int row = index ~/ _boardSize;
                  int col = index % _boardSize;
                  return GestureDetector(
                    onTap: () => _markCell(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.yellow), // Kenarlık rengini sarı yap
                        borderRadius:
                            BorderRadius.circular(10), // Kareleri yuvarlak yap
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: const TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.05,
            ),
          ),
        ],
      ),
    );
  }
}
