import 'package:flutter/material.dart';

class Signboard extends StatefulWidget {
  final String text;
  const Signboard({super.key, required this.text});

  @override
  State<Signboard> createState() => _SignboardState();
}

class _SignboardState extends State<Signboard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 100).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          width: _animation.value + _animation.value,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 10, 170, 18).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          width: _animation.value + _animation.value - 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 37, 139, 11).withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            width: _animation.value,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 40, 94, 19).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Positioned.directional(
          textDirection: TextDirection.ltr,
          top: 10,
          start: 10,
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}