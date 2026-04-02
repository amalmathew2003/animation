import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/bmw/m5.jpg"), // Subtle background
          fit: BoxFit.cover,
          opacity: 0.2,
        ),
      ),
      child: Center(
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(60),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "READY FOR THE NEXT LEVEL?",
                style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 2),
              ),
              const SizedBox(height: 40),
              _buildContactRow(Icons.email_outlined, "EMAIL", "bmw@m3.com"),
              const Divider(color: Colors.white10, height: 40),
              _buildContactRow(Icons.phone_outlined, "PHONE", "+91 9999999999"),
              const SizedBox(height: 50),
              
              // Action Button
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.blue, Colors.blueAccent]),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(
                  child: Text("LOCATE A DEALER", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 24),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, letterSpacing: 1)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }
}