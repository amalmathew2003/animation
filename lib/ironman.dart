import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IronmanScrollPage extends StatefulWidget {
  const IronmanScrollPage({super.key});

  @override
  State<IronmanScrollPage> createState() => _IronmanScrollPageState();
}

class _IronmanScrollPageState extends State<IronmanScrollPage> {
  final ScrollController _scrollController = ScrollController();
  List<ui.Image> _frames = [];
  bool _isLoading = true;
  int _currentIndex = 0;

  // Set this to the total number of frames you have in your folder
  final int totalFrames = 30;

  @override
  void initState() {
    super.initState();
    _loadIronmanFrames();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadIronmanFrames() async {
    List<ui.Image> loadedFrames = [];
    const int myTotalFiles = 151;

    try {
      for (int i = 1; i <= myTotalFiles; i++) {
        String frameNumber = i.toString().padLeft(3, '0');
        String path = 'assets/frames/ezgif-frame-$frameNumber.png';

        final data = await rootBundle.load(path);
        final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
        final frame = await codec.getNextFrame();
        loadedFrames.add(frame.image);

        // Optional: Print progress to console to see if it's working
        debugPrint("Loaded frame $i of $myTotalFiles");
      }

      setState(() {
        _frames = loadedFrames;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Stopped loading at frame: ${loadedFrames.length}. Error: $e");
      // If it fails, we still show what we managed to load
      setState(() {
        _frames = loadedFrames;
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_frames.isEmpty) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    // Smoothly map scroll position to frame index
    double percentage = (currentScroll / maxScroll).clamp(0.0, 1.0);
    int index = (percentage * (_frames.length - 1)).floor();

    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.red))
          : Stack(
              children: [
                // Background Frame Renderer
                Positioned.fill(
                  child: CustomPaint(
                    painter: VideoFramePainter(_frames[_currentIndex]),
                  ),
                ),

                // Foreground Scroll Area
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Increase multiplier (e.g., * 10) to make the animation slower
                      Container(height: MediaQuery.of(context).size.height * 6),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
