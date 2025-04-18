import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';

class AIResponse {
  final String text;
  final bool isError;

  AIResponse({required this.text, this.isError = false});
}

class GeminiService {
  final Gemini _gemini = Gemini.instance;
  
  Future<AIResponse> generateResponse(String prompt, {File? image}) async {
    try {
      if (image != null) {
        final response = await _gemini.textAndImage(
          text: prompt,
          images: [await image.readAsBytes()],
        );
        return AIResponse(
          text: response?.content?.parts?.first.text ?? "No response received",
        );
      } else {
        final response = await _gemini.text(prompt);
        return AIResponse(
          text: response?.content?.parts?.first.text ?? "No response received",
        );
      }
    } catch (e) {
      return AIResponse(
        text: "Error processing your request: ${e.toString()}",
        isError: true,
      );
    }
  }
}