import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Powered by n8n',
      style: GoogleFonts.inter(
        fontSize: 14,
        color: Colors.white60,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
