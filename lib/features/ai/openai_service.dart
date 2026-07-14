import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'models/chat_message.dart';

class OpenAiException implements Exception {
  final String message;
  OpenAiException(this.message);

  @override
  String toString() => message;
}

class OpenAiService {
  /// Cheapest current OpenAI model, well suited for short coaching-style replies.
  static const _model = 'gpt-4.1-nano';

  static String get _apiKey => dotenv.env['OPENAI_API_KEY'] ?? '';

  static bool get isConfigured => _apiKey.isNotEmpty;

  static Future<String> sendMessage({
    required List<ChatMessage> history,
    required String systemContext,
  }) async {
    if (!isConfigured) {
      throw OpenAiException('missing_api_key');
    }

    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

    final messages = [
      {'role': 'system', 'content': systemContext},
      ...history.map(
        (m) => {
          'role': m.role == ChatRole.user ? 'user' : 'assistant',
          'content': m.text,
        },
      ),
    ];

    final body = jsonEncode({
      'model': _model,
      'messages': messages,
      'temperature': 0.7,
      'max_tokens': 400,
    });

    http.Response response;
    try {
      response = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_apiKey',
            },
            body: body,
          )
          .timeout(const Duration(seconds: 30));
    } catch (_) {
      throw OpenAiException('network_error');
    }

    if (response.statusCode != 200) {
      String? apiMessage;
      try {
        final decoded = jsonDecode(response.body);
        apiMessage = decoded['error']?['message'] as String?;
      } catch (_) {
        // ignore parse failure, fall back to status-based message
      }
      throw OpenAiException(apiMessage ?? 'http_${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);
    final choices = decoded['choices'] as List?;

    if (choices == null || choices.isEmpty) {
      throw OpenAiException('empty_response');
    }

    final content = choices.first['message']?['content'] as String?;
    if (content == null || content.trim().isEmpty) {
      throw OpenAiException('empty_response');
    }

    return content.trim();
  }
}
