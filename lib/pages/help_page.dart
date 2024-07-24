import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:melodify_app_project/stuff/color.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  // Define the YouTube video ID
  final String videoId = 'qkUx4aHeqsY';

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 50, 113), // Màu nền tương tự trang chính
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Color.fromARGB(0, 17, 4, 68),
            title: Text('Video hướng dẫn', style: TextStyle(color: Colors.white)),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            floating: true,
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Embed YouTube video
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, // Color of the border
                          width: 2.0, // Width of the border
                        ),
                      ),
                      child: ClipRRect(
                        child: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Video hướng dẫn chi tiết cho ứng dụng Melodify", style: TextStyle(color: whiteColor,fontSize: 16),textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
