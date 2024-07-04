import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class ArtistPage extends StatefulWidget {
  final String artistName;
  const ArtistPage({super.key, required this.artistName});

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Positioned(
                      top: -50,
                      child: Image.asset(
                        'assets/images/artist2.png',
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  
                ),
              SliverToBoxAdapter(
                child: Text('Artiist'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
