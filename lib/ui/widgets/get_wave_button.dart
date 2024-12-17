
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MicrophoneButtonWithWave extends StatefulWidget {
  const MicrophoneButtonWithWave({super.key});

  @override
  _MicrophoneButtonWithWaveState createState() =>
      _MicrophoneButtonWithWaveState();
}

class _MicrophoneButtonWithWaveState extends State<MicrophoneButtonWithWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(); // Doimiy ravishda animatsiya
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        // Animatsiyani boshlash
        _controller.repeat();
      },
      onTapUp: (_) {
        // Animatsiyani to‘xtatish
        _controller.stop();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(100, 100),
            painter: WavePainter(_controller),
          ),
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.mic,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;

  WavePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    // final Paint paint = Paint()
    //   ..color = Colors.red.withOpacity(0.5)
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 2;

    final double maxRadius = size.width / 2;
    final double progress = animation.value;

    // Blur effektni o'rnatish
    Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20); // Blur radius

    // Ovalni chizish
    Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 100,
      height: 100,
    );

    for (double i = 0; i < 3; i++) {
      final double radius = maxRadius * (progress + i / 3);
      if (radius > maxRadius) continue;
    RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
      // canvas.drawCircle(size.center(Offset.zero), radius, paint);
      canvas.drawRRect(rRect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}