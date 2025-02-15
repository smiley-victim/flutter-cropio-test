import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SquareCardButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const SquareCardButton({
    super.key,
    required this.icon,
    required this.title, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: SizedBox(
            width: 60,
            // height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 8),
                FittedBox(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
