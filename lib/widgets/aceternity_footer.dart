import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AceternityFooter extends StatelessWidget {
  const AceternityFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // Decorative Line
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton.icon(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.2),
                      ), // Ripple
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.black.withOpacity(
                                0.9,
                              ); // 👈 hover background
                            }
                            return Colors.transparent; // normal state
                          }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),

                    onPressed: () async {
                      final Uri url = Uri.parse('https://github.com/vijay4dev');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    label: Text(
                      "vijay4dev",
                      style: TextStyle(
                        fontFamily: "Doto",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(FontAwesomeIcons.github, color: Colors.white),
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton.icon(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                        Colors.black.withOpacity(0.2),
                      ), // Ripple
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.black.withOpacity(
                                0.9,
                              ); // 👈 hover background
                            }
                            return Colors.transparent; // normal state
                          }),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final Uri url = Uri.parse('https://x.com/brrocode');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    label: Text(
                      "@brrocode",
                      style: TextStyle(
                        fontFamily: "Doto",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(FontAwesomeIcons.xTwitter, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Footer Text
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.psychology,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'POWERED BY N8N',
                  style: GoogleFonts.spaceMono(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.auto_awesome,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
