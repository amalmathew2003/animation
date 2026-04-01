import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:newscrollanimation/ironman.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: M3UltimateShowcase(),
    );
  }
}

class M3UltimateShowcase extends StatefulWidget {
  const M3UltimateShowcase({super.key});

  @override
  State<M3UltimateShowcase> createState() => _M3UltimateShowcaseState();
}

class _M3UltimateShowcaseState extends State<M3UltimateShowcase> {
  final ScrollController _scrollController = ScrollController();
  List<ui.Image> _frames = [];
  bool _isLoading = true;
  int _currentIndex = 0;

  final int myTotalFiles = 151;

  @override
  void initState() {
    super.initState();
    _loadFrames();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadFrames() async {
    List<ui.Image> loadedFrames = [];
    try {
      for (int i = 1; i <= myTotalFiles; i++) {
        String frameNumber = i.toString().padLeft(3, '0');
        // Path to your BMW M3 frames
        String path = 'assets/frames/ezgif-frame-$frameNumber.png';

        final data = await rootBundle.load(path);
        final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        loadedFrames.add(frame.image);
      }
      setState(() {
        _frames = loadedFrames;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _onScroll() {
    if (_frames.isEmpty) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    double percentage = (currentScroll / maxScroll).clamp(0.0, 1.0);
    int index = (percentage * (_frames.length - 1)).floor();

    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : Stack(
              children: [
                // --- THE ANIMATION LAYER (STAYS EXACTLY THE SAME) ---
                Positioned.fill(
                  child: CustomPaint(
                    painter: VideoFramePainter(_frames[_currentIndex]),
                  ),
                ),

                // --- THE ATTRACTIVE OVERLAY LAYER ---
                _buildInterfaceOverlay(),

                // --- THE SCROLLABLE TEXT CONTENT ---
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Section 1: Intro (Frames 0-30)
                      _buildSection(
                        title: "BORN ON THE TRACK.",
                        subtitle: "THE M3 COMPETITION SEDAN",
                        opacity: _getOpacity(0, 40),
                      ),
                      // Section 2: Engine (Frames 50-90)
                      _buildSection(
                        title: "503 HP.",
                        subtitle: "M TwinPower Turbo Inline 6-Cylinder",
                        opacity: _getOpacity(50, 90),
                      ),
                      // Section 3: Performance (Frames 100-140)
                      _buildSection(
                        title: "0-60 IN 3.4s.",
                        subtitle: "Unmatched M xDrive Precision.",
                        opacity: _getOpacity(100, 140),
                      ),

                      // Extra height to keep the animation "playable"
                      Container(height: MediaQuery.of(context).size.height * 2),

                      // Final Specs Table at the bottom
                      _buildFinalDetails(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  // Logic to show text only during specific frames
  double _getOpacity(int startFrame, int endFrame) {
    if (_currentIndex >= startFrame && _currentIndex <= endFrame) {
      return 1.0;
    }
    return 0.0;
  }

  Widget _buildInterfaceOverlay() {
    return IgnorePointer(
      // Allows clicks to pass through to the scroll view
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "///M3",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                  ),
                ),
                const Icon(Icons.menu, color: Colors.white),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "FRAME: ${_currentIndex.toString().padLeft(3, '0')}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 10,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required double opacity,
  }) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: opacity,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalDetails() {
    return Container(
      color: Colors.white, // Switch to white for a clean, modern "pro" look
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- SECTION HEADER ---
          const Text(
            "/// M PERFORMANCE",
            style: TextStyle(
              color: Color(0xFFE42211),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Engineering Perfection.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 42,
              fontWeight: FontWeight.w900,
              letterSpacing: -2,
            ),
          ),
          const SizedBox(height: 40),

          // --- BENTO GRID STYLE CARDS ---
          Row(
            children: [
              Expanded(
                child: _buildInfoCard("0-60 MPH", "3.4 SEC", Icons.speed),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildInfoCard("HORSEPOWER", "503 HP", Icons.bolt),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _buildLargeFeatureCard(
            "M xDrive System",
            "Adjustable 4WD, 4WD Sport, and 2WD modes for ultimate drift control.",
            Icons.settings_input_component,
          ),

          const SizedBox(height: 60),

          // --- TECHNICAL SPECS LIST ---
          const Text(
            "TECHNICAL DATA",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: Colors.black12, height: 40),
          _buildSpecRow(
            "Engine",
            "3.0-liter BMW M TwinPower Turbo inline 6-cylinder",
          ),
          _buildSpecRow("Transmission", "8-speed M Steptronic with Drivelogic"),
          _buildSpecRow("Top Speed", "180 MPH (with M Driver's Package)"),
          _buildSpecRow("Weight", "3,890 lbs"),

          const SizedBox(height: 100),

          // --- CALL TO ACTION ---
          Center(
            child: Column(
              children: [
                const Text(
                  "READY TO TAKE THE WHEEL?",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: const Text(
                    "EXPLORE INVENTORY",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS FOR THE DESIGN ---

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black45, size: 20),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeFeatureCard(String title, String desc, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1D2671), Color(0xFFC33764)],
        ), // M-Division Blue to Red vibe
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 15),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoFramePainter extends CustomPainter {
  final ui.Image image;
  VideoFramePainter(this.image);
  @override
  void paint(Canvas canvas, Size size) {
    paintImage(
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.width, size.height),
      image: image,
      fit: BoxFit.cover,
    );
  }

  @override
  bool shouldRepaint(VideoFramePainter oldDelegate) =>
      oldDelegate.image != image;
}
