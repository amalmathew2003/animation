import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Loading
import 'package:newscrollanimation/widgets/loading_screen.dart';
import 'package:flutter/gestures.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      home: const M3UltimateShowcase(),
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

  double _progress = 0.0; // 🔥 move outside (class level)

  Future<void> _loadFrames() async {
    try {
      List<ui.Image> loadedFrames = [];

      for (int i = 1; i <= myTotalFiles; i++) {
        String frameNumber = i.toString().padLeft(3, '0');
        String path = 'assets/vasuu/ezgif-frame-$frameNumber.png';

        final image = await _loadSingleFrame(path);
        loadedFrames.add(image);

        // 🔥 update progress
        setState(() {
          _progress = i / myTotalFiles;
        });
      }

      // 🔥 ONLY after all loaded
      setState(() {
        _frames = loadedFrames;
        _isLoading = false; // 👉 switch screen here
      });
    } catch (e) {
      debugPrint("Frame loading error: $e");
    }
  }

  Future<void> _loadRemainingFrames() async {
    for (int i = 11; i <= myTotalFiles; i++) {
      String frameNumber = i.toString().padLeft(3, '0');
      String path = 'assets/it/ezgif-frame-$frameNumber.png';

      final image = await _loadSingleFrame(path);
      _frames.add(image);

      // 🔥 update progress
      if (i % 5 == 0) {
        setState(() {
          _progress = i / myTotalFiles;
        });
      }
    }
  }

  Future<ui.Image> _loadSingleFrame(String path) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  /// 🔥 FIXED: FRAME-BASED SCROLL
  void _onScroll() {
    if (_frames.isEmpty) return;

    final currentScroll = _scrollController.offset;

    /// ✅ FIXED: USE FIXED HEIGHT (NOT maxScroll)
    final animationHeight = MediaQuery.of(context).size.height * 4;

    double percentage = (currentScroll / animationHeight).clamp(0.0, 1.0);

    int index = (percentage * (_frames.length - 1)).floor();

    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
    }

    /// ✅ LAST FRAME DETECTION
    if (percentage >= 1.0) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),

        child: _isLoading
            ? LoadingScreen(progress: _progress)
            : _frames.isEmpty
            ? const Center(
                child: Text(
                  "Frames not loaded",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: VideoFramePainter(_frames[_currentIndex]),
                    ),
                  ),

                  _buildStaticUI(),

                  SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildFullPageSection("MY NAME IS VASU.", ""),
                        _buildFullPageSection("മനുഷ്യന് അല്ലെ പുള്ളേ", ""),
                        _buildFullPageSection("", ""),

                        _buildFullPageSection("", ""),

                        /// 🔥 PERFECT CONTROL SPACE (ANIMATION ONLY)
                        SizedBox(height: MediaQuery.of(context).size.height),

                        /// 🔥 ALWAYS PRESENT (NO SKIP)
                        // Container(
                        //   width: double.infinity,
                        //   color: Colors.black,
                        //   child: Column(
                        //     children: const [
                        //       ModelsPage(),
                        //       ExperiencePage(),
                        //       GalleryPage(),
                        //       ContactPage(),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildStaticUI() {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 40,
            child: Text(
              "M-DATA // FRAME: ${_currentIndex.toString().padLeft(3, '0')}",
              style: const TextStyle(
                color: Colors.white24,
                fontSize: 10,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullPageSection(String title, String subtitle) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.indigo,
                    Colors.purple,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds);
              },
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -3,
                  color: Colors.white, // required
                ),
              ),
            ),
          ],
        ),
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
