import 'package:flutter/cupertino.dart';

class FlyAnimationWidget extends StatefulWidget {
  final Offset startOffset;
  final Offset endOffset;
  final String imageUrl;
  final VoidCallback onComplete;

  const FlyAnimationWidget({
    required this.startOffset,
    required this.endOffset,
    required this.imageUrl,
    required this.onComplete,
  });

  @override
  State<FlyAnimationWidget> createState() => _FlyAnimationWidgetState();
}

class _FlyAnimationWidgetState extends State<FlyAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine);

    _controller.forward().then((value) => widget.onComplete());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double left = widget.startOffset.dx + (widget.endOffset.dx - widget.startOffset.dx) * _animation.value;
        double top = widget.startOffset.dy + (widget.endOffset.dy - widget.startOffset.dy) * _animation.value;
        double size = 100 * (1 - _animation.value * 0.7); // Image choti hoti jaye gi

        return Positioned(
          left: left,
          top: top,
          child: SizedBox(
            width: size,
            height: size,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(widget.imageUrl, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}