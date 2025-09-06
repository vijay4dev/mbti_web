import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/mbti_analysis.dart';
import 'services/mbti_service.dart';
import 'widgets/aceternity_header.dart';
import 'widgets/aceternity_footer.dart';
import 'widgets/aceternity_input_form.dart';
import 'widgets/mbti_receipt_card.dart';
import 'widgets/aceternity_background.dart';
import 'widgets/loading_receipt.dart';

void main() {
  runApp(const MBTIApp());
}

class MBTIApp extends StatelessWidget {
  const MBTIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MBTI Analysis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.interTextTheme(),
        useMaterial3: true,
      ),
      home: const MBTIHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MBTIHomePage extends StatefulWidget {
  const MBTIHomePage({super.key});

  @override
  State<MBTIHomePage> createState() => _MBTIHomePageState();
}

class _MBTIHomePageState extends State<MBTIHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  MBTIAnalysis? _mbtiResult;
  String? _errorMessage;
  int _elapsedSeconds = 0;
  String _currentStatus = 'Initializing analysis...';
  Timer? _timer;

  Future<void> _analyzeMBTI() async {
    if (_usernameController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a username';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _mbtiResult = null;
      _elapsedSeconds = 0;
      _currentStatus =
          'Getting tweets from @${_usernameController.text.trim()}...';
    });

    // Start timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedSeconds = timer.tick;

        // Update status based on elapsed time
        if (_elapsedSeconds <= 5) {
          _currentStatus =
              'Getting tweets from @${_usernameController.text.trim()}...';
        } else if (_elapsedSeconds <= 10) {
          _currentStatus = 'Analyzing tweet patterns...';
        } else if (_elapsedSeconds <= 15) {
          _currentStatus = 'Processing personality data...';
        } else if (_elapsedSeconds <= 20) {
          _currentStatus = 'Generating MBTI analysis...';
        } else if (_elapsedSeconds <= 25) {
          _currentStatus = 'Creating personalized report...';
        } else {
          _currentStatus = 'Finalizing your personality report...';
        }
      });
    });

    try {
      final result = await MBTIService.analyzeMBTI(
        _usernameController.text.trim(),
      );

      // Stop timer
      _timer?.cancel();

      setState(() {
        _mbtiResult = result;
        _isLoading = false;
        _currentStatus = 'Analysis complete!';
      });
    } catch (e) {
      // Stop timer
      _timer?.cancel();

      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
        _currentStatus = 'Analysis failed';
      });
    }
  }

  void _resetAnalysis() {
    _timer?.cancel();
    setState(() {
      _mbtiResult = null;
      _usernameController.clear();
      _errorMessage = null;
      _isLoading = false;
      _elapsedSeconds = 0;
      _currentStatus = 'Initializing analysis...';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AceternityBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Header
                  const AceternityHeader(),
                  const SizedBox(height: 48),

                  // Input Form
                  AceternityInputForm(
                    usernameController: _usernameController,
                    isLoading: _isLoading,
                    errorMessage: _errorMessage,
                    onAnalyze: _analyzeMBTI,
                    elapsedSeconds: _elapsedSeconds,
                    currentStatus: _currentStatus,
                  ),

                  // Loading or Result Card
                  if (_isLoading) ...[
                    const SizedBox(height: 32),
                    const LoadingReceipt(),
                  ] else if (_mbtiResult != null) ...[
                    const SizedBox(height: 32),
                    MBTIReceiptCard(
                      analysis: _mbtiResult!,
                      onReset: _resetAnalysis,
                      username: _usernameController.text.trim(),
                    ),
                  ],

                  const SizedBox(height: 48),

                  // Footer
                  const AceternityFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _usernameController.dispose();
    super.dispose();
  }
}
