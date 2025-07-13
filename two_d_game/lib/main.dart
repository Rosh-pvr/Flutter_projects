import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Collector',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const double playerSize = 50.0;
  static const double coinSize = 30.0;
  static const double obstacleSize = 40.0;
  
  double playerX = 0.0;
  double playerY = 0.0;
  List<Coin> coins = [];
  List<Obstacle> obstacles = [];
  int score = 0;
  bool isGameOver = false;
  Timer? gameTimer;
  Timer? obstacleTimer;
  Timer? coinTimer;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    setState(() {
      playerX = 0.0;
      playerY = 0.0;
      coins = [];
      obstacles = [];
      score = 0;
      isGameOver = false;
    });

    gameTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      updateGame();
    });

    obstacleTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      addObstacle();
    });

    coinTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addCoin();
    });
  }

  void updateGame() {
    if (isGameOver) return;

    setState(() {
      // Update coin positions
      for (var coin in coins) {
        coin.y += 2;
      }
      coins.removeWhere((coin) => coin.y > MediaQuery.of(context).size.height);

      // Update obstacle positions
      for (var obstacle in obstacles) {
        obstacle.y += 3;
      }
      obstacles.removeWhere((obstacle) => obstacle.y > MediaQuery.of(context).size.height);

      // Check collisions
      checkCollisions();
    });
  }

  void checkCollisions() {
    // Check coin collisions
    coins.removeWhere((coin) {
      if ((coin.x - playerX).abs() < (playerSize + coinSize) / 2 &&
          (coin.y - playerY).abs() < (playerSize + coinSize) / 2) {
        score += 10;
        return true;
      }
      return false;
    });

    // Check obstacle collisions
    for (var obstacle in obstacles) {
      if ((obstacle.x - playerX).abs() < (playerSize + obstacleSize) / 2 &&
          (obstacle.y - playerY).abs() < (playerSize + obstacleSize) / 2) {
        gameOver();
        return;
      }
    }
  }

  void gameOver() {
    setState(() {
      isGameOver = true;
    });
    gameTimer?.cancel();
    obstacleTimer?.cancel();
    coinTimer?.cancel();
  }

  void addCoin() {
    if (isGameOver) return;
    final random = Random();
    setState(() {
      coins.add(Coin(
        x: random.nextDouble() * (MediaQuery.of(context).size.width - coinSize),
        y: -coinSize,
      ));
    });
  }

  void addObstacle() {
    if (isGameOver) return;
    final random = Random();
    setState(() {
      obstacles.add(Obstacle(
        x: random.nextDouble() * (MediaQuery.of(context).size.width - obstacleSize),
        y: -obstacleSize,
      ));
    });
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    obstacleTimer?.cancel();
    coinTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (isGameOver) return;
          setState(() {
            playerX += details.delta.dx;
            playerY += details.delta.dy;
            
            // Keep player within screen bounds
            playerX = playerX.clamp(0.0, MediaQuery.of(context).size.width - playerSize);
            playerY = playerY.clamp(0.0, MediaQuery.of(context).size.height - playerSize);
          });
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[200]!, Colors.blue[400]!],
            ),
          ),
          child: Stack(
            children: [
              // Score display
              Positioned(
                top: 40,
                left: 20,
                child: Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Player
              Positioned(
                left: playerX,
                top: playerY,
                child: Container(
                  width: playerSize,
                  height: playerSize,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),

              // Coins
              ...coins.map((coin) => Positioned(
                left: coin.x,
                top: coin.y,
                child: Container(
                  width: coinSize,
                  height: coinSize,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              )),

              // Obstacles
              ...obstacles.map((obstacle) => Positioned(
                left: obstacle.x,
                top: obstacle.y,
                child: Container(
                  width: obstacleSize,
                  height: obstacleSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              )),

              // Game Over Screen
              if (isGameOver)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Game Over!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Final Score: $score',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: startGame,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            'Play Again',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class Coin {
  double x;
  double y;
  Coin({required this.x, required this.y});
}

class Obstacle {
  double x;
  double y;
  Obstacle({required this.x, required this.y});
}
