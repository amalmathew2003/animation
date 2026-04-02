import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔥 NEW TITLE (BMW STYLE)
          const Text(
            "/// M3 VISUAL EXPERIENCE",
            style: TextStyle(
              color: Colors.blueAccent,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          const Text(
            "Captured Motion.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
            ),
          ),

          const SizedBox(height: 60),

          /// 🔥 HERO IMAGE (BIG)
          _HeroImage(),

          const SizedBox(height: 40),

          /// 🔥 THUMBNAIL STRIP
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                String frameNum = (index + 1).toString().padLeft(3, '0');

                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GalleryItem(
                    imagePath: "assets/frames/ezgif-frame-$frameNum.png",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔥 BIG HERO IMAGE
class _HeroImage extends StatefulWidget {
  @override
  State<_HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<_HeroImage> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: () => _openFull(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 400,
          transform: Matrix4.identity()..scale(hover ? 1.02 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage("assets/frames/ezgif-frame-050.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openFull(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        child: Image.asset(
          "assets/frames/ezgif-frame-050.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

/// 🔥 SMALL ITEM
class GalleryItem extends StatefulWidget {
  final String imagePath;
  const GalleryItem({super.key, required this.imagePath});

  @override
  State<GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<GalleryItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: GestureDetector(
        onTap: () => _openFull(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 220,
          transform: Matrix4.identity()..scale(hover ? 1.05 : 1.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hover ? Colors.blueAccent : Colors.white12,
            ),
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void _openFull(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        child: Image.asset(widget.imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
