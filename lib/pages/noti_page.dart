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
      'musicName': 'Không Gian Vàng',
      'artist': 'Miu Lê',
      'image': 'assets/images/music1.png',
      'date': '1 ngày trước',
      'status': 'Mới',
    },
    {
      'musicName': 'Anh Chỉ Là Người Thay Thế',
      'artist': 'Mr.Siro',
      'image': 'assets/images/music1.png',
      'date': '28 tháng 5',
      'status': 'Đã xem',
    },
    {
      'musicName': 'Sau Lời Từ Khước (Live)',
      'artist': 'Mỹ Tâm',
      'image': 'assets/images/music1.png',
      'date': '27 tháng 5',
      'status': 'Đã xem',
    },
    {
      'musicName': 'Algorhythm',
      'artist': 'ITZY',
      'image': 'assets/images/music1.png',
      'date': '15 tháng 5',
      'status': 'Đã xem',
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
          return musicNameLower.contains(searchLower) || artistLower.contains(searchLower);
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
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                sliver: SliverAppBar(
                  backgroundColor: transparent,
                  title: Text(
                    'Thông tin mới',
                    style: changeTextColor(robotoBold20, whiteColor),
                  ),
                  centerTitle: true,
                  titleSpacing: 15,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
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
                            style: changeTextColor(robotoBold16, whiteColor),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const SizedBox(width: 1),
                              Text(
                                'Nội dung phát hành mới nhất từ nghệ sĩ, podcast và chương trình bạn theo dõi',
                                style: changeTextColor(robotoMedium12, lightGrayColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        children: items.map((item) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['status']!,
                                style: changeTextColor(robotoBold16, whiteColor),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  color: blueColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['date']!,
                                            style: changeTextColor(robotoMedium12, lightGrayColor),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item['musicName']!,
                                            style: changeTextColor(robotoBold16, whiteColor),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            item['artist']!,
                                            style: changeTextColor(robotoMedium14, lightGrayColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.control_point,
                                        color: whiteColor,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: whiteColor,
                                        size: 30,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.play_circle,
                                        color: whiteColor,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: lightGrayColor,
                                height: 1,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 150),
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