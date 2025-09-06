import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/mbti_analysis.dart';
import 'serrated_edge.dart';

class MBTIReceiptCard extends StatefulWidget {
  final MBTIAnalysis analysis;
  final VoidCallback onReset;
  final String username;

  const MBTIReceiptCard({
    super.key,
    required this.analysis,
    required this.onReset,
    required this.username,
  });

  @override
  State<MBTIReceiptCard> createState() => _MBTIReceiptCardState();
}

class _MBTIReceiptCardState extends State<MBTIReceiptCard> {
  final GlobalKey _receiptKey = GlobalKey();

  String _getFormattedDate() {
    final now = DateTime.now();
    final weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final weekday = weekdays[now.weekday - 1];
    final month = months[now.month - 1];
    final day = now.day;
    final year = now.year;

    return '$weekday, $month $day, $year';
  }

  Future<void> _downloadReceipt() async {
    try {
      // Capture the receipt as an image
      RenderRepaintBoundary boundary =
          _receiptKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      if (byteData != null) {
        // Convert to blob and create download link
        final blob = html.Blob([byteData.buffer.asUint8List()], 'image/png');
        final url = html.Url.createObjectUrlFromBlob(blob);

        // Create download link
        html.AnchorElement(href: url)
          ..setAttribute('download', 'mbti-receipt-${widget.username}.png')
          ..click();

        // Clean up
        html.Url.revokeObjectUrl(url);

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Receipt downloaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download receipt: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _receiptKey,
      child: ClipPath(
        clipper: ZigZagClipper(zigzagHeight: 12, zigzagWidth: 30),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 700),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Receipt Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 30,
                  right: 30,
                  top: 30,
                  bottom: 5,
                ),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  children: [
                    // Company Logo/Title
                    Text(
                      'TWITTER MBTI RECEIPT',
                      style: GoogleFonts.spaceMono(
                        fontSize: 24,
                        fontWeight: FontWeight.w100,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getFormattedDate(),
                      style: GoogleFonts.spaceMono(
                        fontSize: 14,
                        color: Colors.grey[400],
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Customer:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          "@${widget.username}",
                          style: TextStyle(
                            fontFamily: "Doto",
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cashier: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          "brrocode",
                          style: TextStyle(
                            fontFamily: "Doto",
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // Divider
                    Container(height: 1, color: Colors.grey[600]),
                    const SizedBox(height: 16),
                    // MBTI Type Badge
                    Text(
                      "ISTG",
                      style: GoogleFonts.spaceMono(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        letterSpacing: 10,
                      ),
                    ),
                    Text(
                      "YOUR PERSONALITY TYPE",
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w200,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),

              // Receipt Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Analysis Sections
                    _buildReceiptSection(
                      'INTROVERSION vs EXTROVERSION',
                      widget.analysis.analyses.ie,
                    ),
                    const SizedBox(height: 20),
                    _buildReceiptSection(
                      'SENSING vs INTUITION',
                      widget.analysis.analyses.sn,
                    ),
                    const SizedBox(height: 20),
                    _buildReceiptSection(
                      'THINKING vs FEELING',
                      widget.analysis.analyses.tf,
                    ),
                    const SizedBox(height: 20),
                    _buildReceiptSection(
                      'JUDGING vs PERCEIVING',
                      widget.analysis.analyses.jp,
                    ),

                    if (widget.analysis.similarCelebrity.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      _buildReceiptSection(
                        'SIMILLAR PERSONALITY',
                        widget.analysis.similarCelebrity,
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Receipt Footer
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.grey[300]!, width: 1),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Generated by AI Analysis',
                              style: GoogleFonts.spaceMono(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateTime.now().toString().split(' ')[0],
                              style: GoogleFonts.spaceMono(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Action Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 180,
                  right: 180,
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _downloadReceipt,
                  style: ElevatedButton.styleFrom(
                    overlayColor: Colors.transparent,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 25,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.download,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Download Image',
                        style: GoogleFonts.spaceMono(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),

                  // Text(
                  //   'Download Image',
                  //   style: GoogleFonts.spaceMono(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //     letterSpacing: 1,
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptSection(String title, String content) {
    if (content.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: title == "SIMILLAR PERSONALITY"
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.spaceMono(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.transparent),
          ),
          child: Text(
            textAlign: title == "SIMILLAR PERSONALITY"
                ? TextAlign.center
                : TextAlign.start,
            content,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: Colors.black87,
              height: 1.8,
            ),
          ),
        ),
      ],
    );
  }
}
