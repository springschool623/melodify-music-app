import 'package:flutter/material.dart';

class TrackProvider with ChangeNotifier {
  String? _trackId;
  VoidCallback? _pauseAudio;

  String? get trackId => _trackId;
  VoidCallback? get pauseAudio => _pauseAudio;

  void setTrackId(String? trackId) {
    _trackId = trackId;
    notifyListeners();
  }
}
