import 'package:flutter/material.dart';

import '../theme/colors.dart';

class GetRecordButton extends StatefulWidget {
  const GetRecordButton(
      {super.key, required this.onClick});

  final Function() onClick;

  @override
  State<GetRecordButton> createState() => _GetRecordButtonState();
}

class _GetRecordButtonState extends State<GetRecordButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                        BoxShadow(
                          color: primaryColor.withAlpha(80),
                          blurRadius: 20,
                          spreadRadius: 10,
                        ),
                      ],
              ),
              child: Icon(
                Icons.stop ,
                color: Colors.white,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}
Widget getMicButton(Function() onClick){
  return GestureDetector(
    onTap: onClick,
    child: Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.mic,
        color: Colors.white,
        size: 24,
      ),
    ),
  );
}
