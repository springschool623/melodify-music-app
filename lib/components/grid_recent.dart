import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/visiblebotnavbar.dart';
import 'package:melodify_app_project/pages/playlist_page.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class RecentPlayListGridView extends StatefulWidget {
  const RecentPlayListGridView({super.key});

  @override
  State<RecentPlayListGridView> createState() => _RecentPlayListGridViewState();
}

class _RecentPlayListGridViewState extends State<RecentPlayListGridView> {
  final List<Map<String, String>> items = [
    {'image': 'assets/images/mix1.png', 'text': 'Negav Radio'},
    {'image': 'assets/images/mix2.png', 'text': 'Tuyển tập nhạc buồn'},
    {'image': 'assets/images/mix3.png', 'text': 'Daily Mix 2'},
    {'image': 'assets/images/mix4.png', 'text': 'Daily Mix 1'},
    {'image': 'assets/images/mix5.png', 'text': 'Daily Mix 6'},
    {'image': 'assets/images/mix6.png', 'text': 'Thoải Mái Gác Chân Lên'},
    {'image': 'assets/images/mix7.png', 'text': 'Orange Radio'},
    {'image': 'assets/images/mix8.png', 'text': 'Buitruonglinh'},
  ];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final double totalHeight = (items.length * 22) + ((items.length - 1) * 15);

    return SizedBox(
      height: totalHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
          childAspectRatio: 22 / 7,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlayListPage(title: items[index]['text']!),
                ),
              );
            },
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  color: darkGray,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5)),
                      child: Image.asset(
                        items[index]['image']!,
                        height: 60,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        items[index]['text']!,
                        style: changeTextColor(robotoBold12, whiteColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    if (selectedIndex == index)
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.more_horiz_outlined,
                          color: blueColor,
                          size: 16,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

