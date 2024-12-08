import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class NewReleasesPage extends StatefulWidget {
  const NewReleasesPage({super.key});

  @override
  State<NewReleasesPage> createState() => _NewReleasesPageState();
}

class _NewReleasesPageState extends State<NewReleasesPage> {
  List<Map<String, String>> items = [
    {
      'musicName': 'sao trông em lại như thế này',
      'artist': 'Negav',
      'image': 'assets/images/music1.png',
      'date': '1 ngày trước',
      'type': 'Đĩa đơn',
    },
    {
      'musicName': 'Anh Chỉ Là Người Thay Thế',
      'artist': 'Mr.Siro',
      'image': 'assets/images/anhchilanguoithaythe.jfif',
      'date': '28 tháng 5',
      'type': 'Đĩa đơn',
    },
    {
      'musicName': 'Sau Lời Từ Khước (Live)',
      'artist': 'Mỹ Tâm',
      'image': 'assets/images/sauloitukhuoc.jfif',
      'date': '27 tháng 5',
      'type': 'Đĩa đơn',
    },
    {
      'musicName': 'Algorhythm',
      'artist': 'ITZY',
      'image': 'assets/images/cateimg/algorhythm.jfif',
      'date': '15 tháng 5',
      'type': 'Album',
    },
    {
      'musicName': 'Love Yourself 轉 Tear',
      'artist': 'ITZY',
      'image': 'assets/images/cateimg/loveyourself.jfif',
      'date': '21 tháng 5',
      'type': 'Album',
    },
    {
      'musicName': 'Không Gian Vắng',
      'artist': 'Miu Lê',
      'image': 'assets/images/khonggianvang.jfif',
      'date': '6 tháng 6',
      'type': 'Đĩa đơn',
    },
  ];

  List<Map<String, String>> allItems = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    allItems = List.from(items);
    searchController.addListener(() {
      search(searchController.text);
    });
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = allItems;
      });
    } else {
      setState(() {
        items = allItems.where((item) {
          final musicNameLower = item['musicName']!.toLowerCase();
          final artistLower = item['artist']!.toLowerCase();
          final searchLower = query.toLowerCase();
          return musicNameLower.contains(searchLower) ||
              artistLower.contains(searchLower);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  blueColor,
                  blackColor,
                ],
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
                sliver: SliverAppBar(
                  backgroundColor: transparent,
                  centerTitle: true,
                  titleSpacing: 15,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bản phát hành mới',
                            style: changeTextColor(robotoBold28, whiteColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nội dung phát hành mới nhất từ nghệ sĩ, podcast và chương trình bạn theo dõi',
                            style:
                                changeTextColor(robotoMedium12, lightGrayColor),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Mới',
                        style: changeTextColor(robotoBold20, whiteColor),
                      ),
                    ),
                    Column(
                      children: items.map((item) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(item['image']!),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['date']!,
                                              style: changeTextColor(
                                                  robotoMedium12,
                                                  lightGrayColor),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              item['musicName']!,
                                              style: changeTextColor(
                                                  robotoBold16, whiteColor),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item['artist']!,
                                              style: changeTextColor(
                                                  robotoMedium14,
                                                  lightGrayColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['type']!,
                                    style: changeTextColor(robotoRegular12, lightGrayColor),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            padding: const EdgeInsets.all(0),
                                            alignment: Alignment.centerLeft,
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.control_point,
                                              color: whiteColor,
                                              size: 30,
                                            ),
                                          ),
                                          IconButton(
                                            padding: const EdgeInsets.all(0),
                                            alignment: Alignment.centerLeft,
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: whiteColor,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.play_circle,
                                          color: whiteColor,
                                          size: 40,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: lightGreyLowOpacity,
                              height: 1,
                            ),
                            const SizedBox(height: 10,)
                          ],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
