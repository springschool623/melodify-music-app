import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioProvider with ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  String _audioURL = '';
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  AudioPlayer get player => _player;
  String get audioURL => _audioURL;

  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void setPlaying(bool playing) {
    _isPlaying = playing;
    notifyListeners();
  }
  
  Future<void> stopAudio() async {
    await _player.pause();
    await _player.stop();
    notifyListeners();
  }

  Future<void> playAudio(String url) async {
    await _player.setSourceUrl(url);
    notifyListeners();
  }

  void setAudioURL(String url) {
    _audioURL = url;
    notifyListeners();
  }
}
