// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class PlayListPage extends StatefulWidget {
  final String title;
  const PlayListPage({super.key, required this.title});

  @override
  State<PlayListPage> createState() => PlayListPageState();
}

class PlayListPageState extends State<PlayListPage> {
  List<Map<String, String>> items = [
    {
      'image': 'assets/images/music1.png',
      'musicName': 'sao trông em lại như thế này',
      'artist': 'Negav'
    },
    {
      'image': 'assets/images/music2.png',
      'musicName': 'Ngày Đẹp Trời Để Nói Chia Tay',
      'artist': 'Lou Hoàng'
    },
    {
      'image': 'assets/images/music3.png',
      'musicName': 'Đừng Làm Trái Tim Anh Đau',
      'artist': 'Sơn Tùng M-TP'
    },
    {
      'image': 'assets/images/music4.png',
      'musicName': 'Không Thể Say',
      'artist': 'HIEUTHUHAI'
    },
    {
      'image': 'assets/images/music5.png',
      'musicName': 'ĐỢI (SPECIAL VERSION) (feat. WEAN)',
      'artist': '52HZ'
    },
    {
      'image': 'assets/images/music6.png',
      'musicName': 'Sau Cơn Mưa',
      'artist': 'CoolKid, RHYDER'
    },
    {
      'image': 'assets/images/music7.png',
      'musicName': 'Bật Tình Yêu Lên',
      'artist': 'Tăng Duy Tân, Hòa Minzy'
    },
    {
      'image': 'assets/images/music8.png',
      'musicName': 'NOLOVENOLIFE',
      'artist': 'HIEUTHUHAI'
    },
    {
      'image': 'assets/images/music9.png',
      'musicName': 'Có Em Chờ',
      'artist': 'MIN, Mr A'
    },
    {
      'image': 'assets/images/music10.png',
      'musicName': 'bao tiền một mớ bình yên?',
      'artist': 'Negav'
    },
  ];

  List<Map<String, String>> allItems = [];
  @override
  void initState() {
    super.initState();
    allItems = List.from(items);
  }

  final TextEditingController searchController = TextEditingController();

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = allItems;
      });
    } else {
      items = allItems.where((item) {
        final musicNameLower = item['musicName']!.toLowerCase();
        final artistLower = item['artist']!.toLowerCase();
        final searchLower = query.toLowerCase();
        return musicNameLower.contains(searchLower) ||
            artistLower.contains(searchLower);
      }).toList();
    }
  }

  //Mục có thể bạn sẽ thích
  final List<Map<String, String>> itemsLikes = [
    {
      'imageLike': 'assets/images/like1.png',
      'likeName': 'Best of Hip-hop Việt 2023',
      'des': 'Những track Hip-hop Việt nổi bật năm 2023. Ảnh bìa: Phúc Du'
    },
    {
      'imageLike': 'assets/images/like2.png',
      'likeName': 'Top Nghệ Sĩ Việt 2023',
      'des': 'Những nghệ sĩ Việt được nghe nhiểu nhất năm 2023'
    },
    {
      'imageLike': 'assets/images/like4.png',
      'likeName': 'Best of Inđậm Indie 2023',
      'des': 'Những dấu ấn Inđậm Indie nổi bật năm 2023. Ảnh bìa: Vũ.'
    },
    {
      'imageLike': 'assets/images/like3.png',
      'likeName': 'Tiếng Hát Át Tiếng Ka',
      'des': 'Ảnh bìa: say này bé thành ca sĩ nhưng thi thoảng diễn hài đỉnh cao'
    },
  ];

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
                    'Negav Radio',
                    style: changeTextColor(robotoBold20, whiteColor)
                  ),
                  centerTitle: true,
                  titleSpacing: 15,
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 40,
                      color: whiteColor,
                    ),
                  )
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //Thanh Search
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Thanh Search
                        SizedBox(
                          width: 300,
                          height: 40,
                          child: SearchBar(
                            controller: searchController,
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              lightGrayColorLowOpacity,
                            ),
                            elevation: MaterialStateProperty.all<double>(0),
                            leading: Icon(
                              Icons.search,
                              color: lightGrayColor,
                            ),
                            hintText: 'Tìm trong danh sách phát',
                            hintStyle: MaterialStateProperty.all<TextStyle>(
                              changeTextColor(robotoRegular14, lightGrayColor)
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: lightGrayColorLowOpacity,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            'Sắp xếp',
                            style: changeTextColor(robotoRegular14, lightGrayColor)
                          ),
                        )
                      ],
                    ),
                    //Logo cho mỗi PlayList
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 250,
                      height: 250,
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/playlist1.png',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Với HIEUTHUHAI, AMEE, PRT MCK và nhiều hơn nữa',
                            style: changeTextColor(robotoMedium14, lightGrayColor)
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Dành riêng cho ',
                                style: changeTextColor(robotoMedium14, lightGrayColor)
                              ),
                              Text(
                                'Lê Nguyễn Gia Bảo',
                                style: changeTextColor(robotoBold16, whiteColor)
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                '113 lượt lưu',
                                style: changeTextColor(robotoMedium14, lightGrayColor)
                              ),
                              Container(
                                width: 4,
                                height: 4,
                                alignment: Alignment.bottomCenter,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: lightGrayColor
                                ),
                              ),
                              Text(
                                '3 giờ 0 phút',
                                style: changeTextColor(robotoMedium14, lightGrayColor)
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //3 Icon bên Trái
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.downloading,
                                    size: 30,
                                    color: lightGrayColor
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.control_point,
                                    size: 30,
                                    color: lightGrayColor
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_vert,
                                    size: 30,
                                    color: lightGrayColor
                                  )),
                            ],
                          ),
                          const SizedBox(
                            width: 100,
                          ),
                          //2 Icon bên Phải
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.shuffle_rounded,
                                    size: 30,
                                    color: blueColor,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.play_circle,
                                    size: 50,
                                    color: blueColor,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        //Dùng ListView thì sẽ bị giới hạn chiều cao nên dùng Column có items.map sẽ ko cần lo bị giới hạn
                        children: items.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
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
                                        item['musicName']!,
                                        style: changeTextColor(robotoBold16, whiteColor),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        item['artist']!,
                                        style: changeTextColor(robotoMedium14, lightGrayColor)
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: lightGrayColor,
                                      size: 26,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Có thể bạn sẽ thích',
                        style: changeTextColor(robotoBold20, whiteColor),
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 495,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 28,
                            mainAxisSpacing: 20,
                            mainAxisExtent: 238
                          ),
                          itemCount: itemsLikes.length,
                          itemBuilder: (context, index) {
                            final itemLike = itemsLikes[index];
                            return GridTile(
                              child: Container(
                                height: 300,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 175,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(itemLike['imageLike']!),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(
                                      itemLike['likeName']!,
                                      style: changeTextColor(robotoBold14, whiteColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      itemLike['des']!,
                                      style: changeTextColor(robotoMedium135, lightGrayColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                    ),

                    const SizedBox(
                      height: 150,
                    ),
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
