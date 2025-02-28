
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
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Card(
      elevation: 1.5,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
              const SizedBox(width: 8),
              Text(
                title,
              textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
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
