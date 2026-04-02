import 'package:flutter/material.dart';

class ModelsPage extends StatelessWidget {
  const ModelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 HEADER (UPGRADED)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "01 — M PERFORMANCE LINE",
                  style: TextStyle(
                    color: Colors.white30,
                    letterSpacing: 8,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "THE POWER COLLECTION.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),

          /// 🔥 HORIZONTAL SCROLL
          SizedBox(
            height: 560,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 80),
              physics: const BouncingScrollPhysics(),
              children: const [
                PremiumModelCard(
                  title: "M3 SEDAN",
                  image: "assets/bmw/m3_1.jpeg",
                  specs: ["503 HP", "3.4S"],
                ),
                SizedBox(width: 50),
                PremiumModelCard(
                  title: "M4 COUPE",
                  image: "assets/bmw/m4.jpg",
                  specs: ["473 HP", "4.1S"],
                ),
                SizedBox(width: 50),
                PremiumModelCard(
                  title: "M5 CS",
                  image: "assets/bmw/m5.jpg",
                  specs: ["627 HP", "2.9S"],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumModelCard extends StatefulWidget {
  final String title;
  final String image;
  final List<String> specs;

  const PremiumModelCard({
    super.key,
    required this.title,
    required this.image,
    required this.specs,
  });

  @override
  State<PremiumModelCard> createState() => _PremiumModelCardState();
}

class _PremiumModelCardState extends State<PremiumModelCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        transform: Matrix4.identity()..translate(0.0, isHovered ? -10.0 : 0.0),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            width: 420,
            height: 540,
            color: const Color(0xFF0A0A0A),
            child: Stack(
              children: [
                /// 🔥 IMAGE (PARALLAX ZOOM)
                AnimatedScale(
                  scale: isHovered ? 1.12 : 1.0,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeOutCubic,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                /// 🔥 GRADIENT OVERLAY
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.95),
                      ],
                    ),
                  ),
                ),

                /// 🔥 CONTENT
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),

                      const Spacer(),

                      /// SPECS
                      Row(
                        children: [
                          _spec("POWER", widget.specs[0]),
                          const SizedBox(width: 40),
                          _spec("0-100", widget.specs[1]),
                        ],
                      ),

                      const SizedBox(height: 30),

                      /// 🔥 CTA (BMW STYLE HOVER)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isHovered ? Colors.white : Colors.transparent,
                          border: Border.all(color: Colors.white),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "EXPLORE MODEL",
                          style: TextStyle(
                            color: isHovered ? Colors.black : Colors.white,
                            letterSpacing: 2,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _spec(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 8,
            letterSpacing: 1,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
