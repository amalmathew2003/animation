import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final double progress; // 🔥 new

  const LoadingScreen({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 140,
              child: LinearProgressIndicator(
                value: progress, // 🔥 dynamic progress
                color: Colors.blueAccent,
                backgroundColor: Colors.white12,
                minHeight: 3,
              ),
            ),
            const SizedBox(height: 20),

            Text(
              "${(progress * 100).toInt()}%", // 🔥 percentage
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "LOADING M POWER",
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                letterSpacing: 4,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}