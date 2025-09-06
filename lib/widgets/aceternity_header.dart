import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AceternityHeader extends StatelessWidget {
  const AceternityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      width: 800,
      decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20), // round corners
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 2, // spread of shadow
        blurRadius: 50, // smoothness of blur
        offset: Offset(0, 2), // position of shadow
      ),
    ],
  ),
      child: Column(
        children: [
          // Main Title
          Text(
            'Twitter MBTI Receipt',
            style: TextStyle(
              fontFamily: 'Doto',
              fontSize: 48,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 16),
      
          // Subtitle
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                'Discover personality type \n on basis of Tweets',
                style: GoogleFonts.spaceMono(
                  fontSize: 18,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
