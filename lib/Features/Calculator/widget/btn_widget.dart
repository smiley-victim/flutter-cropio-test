import 'package:flutter/material.dart';

class FadeScaleButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const FadeScaleButton({super.key, required this.text, required this.onPressed});

  @override
  _FadeScaleButtonState createState() => _FadeScaleButtonState();
}

class _FadeScaleButtonState extends State<FadeScaleButton> {
  bool _isPressed = false;

  void _onPressed() {
    setState(() {
      _isPressed = true;
    });

    // Call the provided onPressed function
    widget.onPressed();

    // Reset the animation after 300ms
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isPressed = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isPressed ? 0.5 : 1.0,
      child: AnimatedScale(
        scale: _isPressed ? 0.8 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 10, 104, 13),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.green), // Outline border
              ),
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
