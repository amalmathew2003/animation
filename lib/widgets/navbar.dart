import 'package:flutter/material.dart';
import 'package:newscrollanimation/screens/experiencepage.dart';
import 'package:newscrollanimation/screens/gallerypage.dart';
import 'package:newscrollanimation/screens/modelpage.dart';

class BMWNavbar extends StatelessWidget {
  const BMWNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
        child: Row(
          children: [
            /// LEFT LOGO
            const Text(
              "BMW ///M3",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),

            const Spacer(), // ✅ THIS FIXES ALIGNMENT
            /// RIGHT MENU
            Row(
              children: [
                NavItem(
                  "Models",
                  onTap: () => _go(context, const ModelsPage()),
                ),
                const SizedBox(width: 30),
                NavItem(
                  "Experience",
                  onTap: () => _go(context, const ExperiencePage()),
                ),
                const SizedBox(width: 30),
                NavItem(
                  "Gallery",
                  onTap: () => _go(context, const GalleryPage()),
                ),
                const SizedBox(width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _go(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}

class NavItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const NavItem(this.text, {required this.onTap, super.key});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: hover ? Colors.white : Colors.white70,
            fontWeight: FontWeight.w600,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
