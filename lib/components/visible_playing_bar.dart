import 'package:flutter/material.dart';

class CurrentPlayingSong with ChangeNotifier {
  String _title = '';
  String _artist = '';
  String _img = '';
  int _duration = 0;
  bool _isVisible = false;

  String get title => _title;
  String get artist => _artist;
  String get img => _img;
  int get duration => _duration;
  bool get isVisible => _isVisible;

  void updateSong(String title, String artist, String img, int duration) {
    _title = title;
    _artist = artist;
    _img = img;
    _duration = duration;
    _isVisible = true; // Hiển thị PlayingBar khi cập nhật bài hát
    notifyListeners();
  }

  void hide() {
    _isVisible = false; // Ẩn PlayingBar
    notifyListeners();
  }
}
