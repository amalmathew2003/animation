import 'package:flutter/material.dart';
import 'dart:math';

class LoadingScreen extends StatefulWidget {
  final double progress;

  const LoadingScreen({super.key, required this.progress});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get loadingDots {
    int count = (DateTime.now().millisecond ~/ 300) % 4;
    return '.' * count;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 🔥 Glowing Logo Text
                Text(
                  "LOADING",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.purple,
                          Colors.pink,
                        ],
                      ).createShader(
                        const Rect.fromLTWH(0, 0, 200, 70),
                      ),
                    shadows: [
                      Shadow(
                        blurRadius: 20 * sin(_controller.value * pi),
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🌈 Gradient Progress Bar
                Container(
                  width: 180,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white12,
                  ),
                  child: Stack(
                    children: [
                      FractionallySizedBox(
                        widthFactor: widget.progress,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.purple,
                                Colors.pink,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// 🔢 Percentage
                Text(
                  "${(widget.progress * 100).toInt()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 10),

                /// ⚡ Animated dots
                Text(
                  "Please wait${loadingDots}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}