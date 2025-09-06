import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mbti_analysis.dart';

class MBTIService {
  static const String _baseUrl =
      'https://vijayy.app.n8n.cloud/webhook/mbti-analysis';

  static Future<MBTIAnalysis?> analyzeMBTI(String username) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return MBTIAnalysis.fromJson(data[0]);
        }
        return null;
      } else {
        throw Exception(
          'Failed to analyze MBTI. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error analyzing MBTI: $e');
    }
  }
}
