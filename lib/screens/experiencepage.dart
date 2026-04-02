import 'package:flutter/material.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,

      child: Stack(
        children: [
          /// 🔥 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset("assets/bmw/m3bg.jpeg", fit: BoxFit.cover),
          ),

          /// 🔥 GRADIENT OVERLAY (STRONGER CINEMATIC)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ),

          /// 🔥 CONTENT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔥 NEW BMW STYLE TITLE
                const Text(
                  "/// PERFORMANCE EXPERIENCE",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Engineered for Adrenaline.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 64,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                  ),
                ),

                const SizedBox(height: 60),

                /// 🔥 FEATURE ROW
                Row(
                  children: const [
                    Expanded(
                      child: ExperienceCard(
                        title: "M Drive Modes",
                        desc:
                            "Fine-tune performance with adaptive suspension, steering, and throttle response.",
                        icon: Icons.speed,
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: ExperienceCard(
                        title: "Track Precision",
                        desc:
                            "Built for high-speed stability and precision cornering on any circuit.",
                        icon: Icons.track_changes,
                      ),
                    ),
                    SizedBox(width: 30),
                    Expanded(
                      child: ExperienceCard(
                        title: "M xDrive System",
                        desc:
                            "Switch seamlessly between AWD and RWD for ultimate control.",
                        icon: Icons.settings,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                /// 🔥 CTA BUTTON (NEW)
                _ExploreButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔥 BUTTON (BMW STYLE)
class _ExploreButton extends StatefulWidget {
  @override
  State<_ExploreButton> createState() => _ExploreButtonState();
}

class _ExploreButtonState extends State<_ExploreButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        decoration: BoxDecoration(
          color: hover ? Colors.white : Colors.transparent,
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          "EXPLORE M PERFORMANCE",
          style: TextStyle(
            color: hover ? Colors.black : Colors.white,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// 🔥 CARD (UPGRADED)
class ExperienceCard extends StatefulWidget {
  final String title;
  final String desc;
  final IconData icon;

  const ExperienceCard({
    super.key,
    required this.title,
    required this.desc,
    required this.icon,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(30),
        transform: Matrix4.identity()..scale(hover ? 1.08 : 1.0),

        decoration: BoxDecoration(
          color: hover
              ? Colors.white.withOpacity(0.15)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
          boxShadow: hover
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 30,
                    spreadRadius: 3,
                  ),
                ]
              : [],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.icon, color: Colors.white, size: 34),

            const SizedBox(height: 20),

            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.desc,
              style: const TextStyle(color: Colors.white70, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}
