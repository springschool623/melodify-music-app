import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/audio_provider.dart';
import 'package:melodify_app_project/components/track_provider.dart';
import 'package:melodify_app_project/components/visible_playing_bar.dart';
import 'package:melodify_app_project/pages/main_page.dart';
import 'package:melodify_app_project/pages/sign_in_up/intro_page.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentPlayingSong()),
        ChangeNotifierProvider(create: (_) => TrackProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}
