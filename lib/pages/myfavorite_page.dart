import 'package:flutter/material.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
class MyFavoritePage extends StatefulWidget {
  const MyFavoritePage({super.key});

  @override
  State<MyFavoritePage> createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
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
                    'Bài hát ưa thích',
                    style: changeTextColor(robotoBold20, whiteColor)
                  ),
                  centerTitle: true,
                  titleSpacing: 15,
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
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
                          width: 450,
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
                        
                      ],
                    ),
                     
                    //Logo cho mỗi PlayList
                    const SizedBox(
                      height: 1,
                    ),
                    
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '23 bài hát',
                            style: changeTextColor(robotoRegular14, whiteColor),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.downloading_outlined, size: 35,),
                                color: whiteColor,
                                onPressed: () {},
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.shuffle, size: 35,),
                                    color: blueColor,
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.play_circle_fill_outlined, size: 35,),
                                    color: blueColor,
                                    onPressed: () {},
                                  ),
                                ],
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

                    
                    const SizedBox(height: 5,),
                    

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