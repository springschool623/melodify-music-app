import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/list_fav_artist.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class ArtistPage extends StatefulWidget {
  final String artistName;
  final String artistImage;
  const ArtistPage({super.key, required this.artistName, required this.artistImage});

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
                  background: Image.asset(
                    'assets/images/artist2.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //App bar
                    SliverAppBar(
                      backgroundColor: blueColor,
                      expandedHeight: 250,
                      pinned: true,
                      flexibleSpace: LayoutBuilder(
                        builder: (BuildContext context, BoxConstraints constraints) {
                          //Tính chiều dài của AppBar sau đó khi cuộn xuống nhất định thì sẽ đổi style Text
                          final double appBarHeight = constraints.biggest.height;
                          final bool isCollapsed = appBarHeight <= kToolbarHeight + 50;
                          return FlexibleSpaceBar(
                            titlePadding: EdgeInsets.only(
                              left: isCollapsed ? 60 : 14,
                              bottom: isCollapsed ? 9 : 0,
                            ),
                            title: Text(
                              widget.artistName,
                              style: isCollapsed
                                  ? changeTextColor(robotoBlack22, whiteColor)
                                  : changeTextColor(robotoBlack30, whiteColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.asset(
                                  widget.artistImage,
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.topCenter,
                                ),
                              ],
                            ),
                            collapseMode: CollapseMode.parallax,
                          );
                        },
                      ),
                      leading: Transform.translate(
                        offset: const Offset(0, 4),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: whiteColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),

                    //Cái Box chứa các phần còn lại
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Số người nghe mỗi tháng
                          Padding(
                            padding: const EdgeInsets.only(right: 16, top: 16, left: 16),
                            child: Text(
                              '574,3N người nghe hàng tháng',
                              style: changeTextColor(robotoRegular14, lightGrayColor),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Giới thiệu',
                              style: changeTextColor(robotoBold22, whiteColor),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          //Phần giới thiệu nghệ sĩ
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: double.infinity,
                              height: 360,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/artist2.png',
                                    )),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.verified,
                                          color: blueColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Nghệ sĩ đã xác minh',
                                          style: changeTextColor(robotoMedium14, whiteColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.baseline,
                                              textBaseline: TextBaseline.alphabetic,
                                              children: [
                                                Text(
                                                  '574.333',
                                                  style: changeTextColor(robotoBlack22, whiteColor),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'NGƯỜI NGHE HÀNG THÁNG',
                                                  style: changeTextColor(robotoRegular14, whiteColor),
                                                )
                                              ],
                                            ),
                                            Text(
                                              'sap noi tieng',
                                              style: changeTextColor(robotoRegular16, whiteColor),
                                            )
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: whiteColor,
                                              size: 28,
                                            )),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Fan cũng thích',
                              style: changeTextColor(robotoBold22, whiteColor),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          //Phần Fan cũng thích
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: ListFavoriteArtist(),
                          ),
                          const SizedBox(
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
