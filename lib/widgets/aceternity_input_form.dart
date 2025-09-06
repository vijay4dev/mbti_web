import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AceternityInputForm extends StatefulWidget {
  final TextEditingController usernameController;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onAnalyze;
  final int? elapsedSeconds;
  final String? currentStatus;

  const AceternityInputForm({
    super.key,
    required this.usernameController,
    required this.isLoading,
    this.errorMessage,
    required this.onAnalyze,
    this.elapsedSeconds,
    this.currentStatus,
  });

  @override
  State<AceternityInputForm> createState() => _AceternityInputFormState();
}

class _AceternityInputFormState extends State<AceternityInputForm>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 30,
                  offset: const Offset(0, -15),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  // Title
                  Text(
                    'ENTER USERNAME',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover your personality type',
                    style: GoogleFonts.spaceMono(
                      fontSize: 14,
                      color: Colors.grey[600],
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Input Field with Aceternity Style
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: widget.usernameController,
                      onTap: () {
                        setState(() {
                          _isFocused = true;
                        });
                        _animationController.forward();
                      },
                      onSubmitted: (value) {
                        setState(() {
                          _isFocused = false;
                        });
                        _animationController.reverse();
                        if (value.trim().isNotEmpty) {
                          widget.onAnalyze();
                        }
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          setState(() {
                            _isFocused = false;
                          });
                          _animationController.reverse();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'brrocode',
                        hintStyle: GoogleFonts.spaceMono(
                          color: Colors.grey[400],
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.alternate_email,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: _isFocused ? Colors.grey[50] : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                      ),
                      style: GoogleFonts.spaceMono(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Animated Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        gradient: widget.isLoading
                            ? LinearGradient(
                                colors: [Colors.grey[400]!, Colors.grey[500]!],
                              )
                            : const LinearGradient(
                                colors: [Colors.black, Color(0xFF333333)],
                              ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: widget.isLoading
                            ? []
                            : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: widget.isLoading ? null : widget.onAnalyze,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.isLoading
                                      ? 'ANALYZING...'
                                      : 'ANALYZE TWEETS',
                                  style: GoogleFonts.spaceMono(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: widget.isLoading
                                        ? Colors.grey[600]
                                        : Colors.white,
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  widget.isLoading
                                      ? Icons.hourglass_empty
                                      : Icons.auto_awesome,
                                  color: widget.isLoading
                                      ? Colors.grey[600]
                                      : Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Progress Bar and Timer (only when loading)
                  if (widget.isLoading) ...[
                    const SizedBox(height: 24),

                    // Status Message with Progress Fill
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Stack(
                        children: [
                          // Progress Fill Background
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: LinearProgressIndicator(
                              value: widget.elapsedSeconds != null
                                  ? (widget.elapsedSeconds! / 30).clamp(
                                      0.0,
                                      1.0,
                                    )
                                  : 0.0,
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          // Content
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                // Timer in place of dot
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    '${widget.elapsedSeconds ?? 0}s',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    widget.currentStatus ??
                                        'Initializing analysis...',
                                    style: GoogleFonts.spaceMono(
                                      fontSize: 12,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Error Message
                  if (widget.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red[200]!),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red[600],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.errorMessage!,
                              style: GoogleFonts.spaceMono(
                                color: Colors.red[600],
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
