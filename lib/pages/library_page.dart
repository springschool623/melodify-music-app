import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final List<Map<String, String>> itemsLibrary = [
    {
      'image': 'assets/images/album2023.png',
      'name': 'Bài hát bạn yêu thích nhất 2023',
      'des': 'Danh sách phát',
      'des1': 'Dành cho Lê Nguyễn Gia Bảo'
    },
    {'image': 'assets/images/artist2.png', 'name': 'Negav', 'des': 'Nghệ sĩ'},
    {
      'image': 'assets/images/album1.png',
      'name': 'KILL MY DOUBT',
      'des': 'Album',
      'des1': 'ITZY'
    },
    {'image': 'assets/images/artist4.png', 'name': 'W/N', 'des': 'Nghệ sĩ'},
    {
      'image': 'assets/images/artist1.png',
      'name': 'HIEUTHUHAI',
      'des': 'Nghệ sĩ'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        buildBackgroundContainer(),
        CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 25, left: 16, right: 16),
              sliver: SliverAppBar(
                backgroundColor: transparent,
                title: Text('Thư viện',
                    style: changeTextColor(robotoBold22, whiteColor)),
                titleSpacing: 15,
                leading: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logotest.jpg'),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: whiteColor,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: whiteColor,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 25,
                              child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () {},
                                  icon: const FaIcon(
                                    FontAwesomeIcons.arrowDownShortWide,
                                    color: whiteColor,
                                    size: 16,
                                  )),
                            ),
                            Text(
                              'Gần đây',
                              style: changeTextColor(robotoBold16, whiteColor),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.grid_view_outlined,
                              size: 18,
                              color: whiteColor,
                            )),
                      ],
                    ),

                    //List các thư viện
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/like_img.png',
                          height: 65,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bài hát đã thích',
                              style: changeTextColor(robotoBold16, whiteColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.push_pin_rounded,
                                  color: blueColor,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'Danh sách phát',
                                  style: changeTextColor(
                                      robotoMedium14, lightGrayColor),
                                ),
                                Container(
                                  width: 4,
                                  height: 4,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: lightGrayColor),
                                ),
                                Text(
                                  '23 Bài hát',
                                  style: changeTextColor(
                                      robotoMedium14, lightGrayColor),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    //List
                    Column(
                      children: itemsLibrary.map((item) {
                        final isAlbum = item['image']!.contains('album');
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  shape: isAlbum
                                      ? BoxShape.rectangle
                                      : BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(item['image']!),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name']!,
                                    style: changeTextColor(robotoBold16, whiteColor),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  isAlbum
                                      ? Row(
                                          children: [
                                            Text(
                                              item['des']!,
                                              style: changeTextColor(
                                                  robotoMedium14,
                                                  lightGrayColor),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Container(
                                              width: 4,
                                              height: 4,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: lightGrayColor),
                                            ),
                                            SizedBox(
                                              width: 170,
                                              child: Text(
                                                item['des1']!,
                                                style: changeTextColor(
                                                    robotoMedium14,
                                                    lightGrayColor),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          item['des']!,
                                          style: changeTextColor(
                                              robotoMedium14, lightGrayColor),
                                        ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Thêm Nghệ sĩ
                    Row(
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            color: darkGray,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 50,
                            color: lightGrayColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Thêm nghệ sĩ',
                          style: changeTextColor(robotoBold16, whiteColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Thêm Album, Playlist
                    Row(
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            color: darkGray,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 50,
                            color: lightGrayColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Thêm Album/Playlist',
                          style: changeTextColor(robotoBold16, whiteColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 130,),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
