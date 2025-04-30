import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  bool _isListening = false;

  Future<void> initialize() async {
    await _speechToText.initialize();
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
  }

  Future<bool> startListening({
    required Function(String) onResult,
    required Function() onError,
  }) async {
    if (!_isListening) {
      _isListening = true;
      return await _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            onResult(result.recognizedWords);
            _isListening = false;
          }
        },
        listenMode: ListenMode.confirmation,
        cancelOnError: true,
        partialResults: false,
        onError: (error) {
          onError();
          _isListening = false;
        },
      );
    }
    return false;
  }

  Future<void> stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      _isListening = false;
    }
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  bool get isListening => _isListening;
} 