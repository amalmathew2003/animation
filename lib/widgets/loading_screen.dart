import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                color: Colors.blueAccent,
                backgroundColor: Colors.white12,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "LOADING VASUUU POWER",
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