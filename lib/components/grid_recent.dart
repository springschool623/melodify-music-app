import 'package:flutter/material.dart';

class RecentPlayListGridView extends StatefulWidget {
  RecentPlayListGridView({super.key});

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
    // Calculate the total height based on the number of items and the estimated height of each GridTile
    final double totalHeight = (items.length * 21.8) +
        ((items.length - 1) *
            15); // 60 is the height of each GridTile, 15 is the mainAxisSpacing

    return SizedBox(
      height: totalHeight,
      child: GridView.builder(
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
                  selectedIndex =
                      index; // Cập nhật chỉ số của playlist được chọn
                });
              },
              child: GridTile(
                  child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(66, 66, 66, 1),
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
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        items[index]['text']!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'MonFontsBold',
                            fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    if(selectedIndex == index)
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.more_horiz_outlined, 
                          color: Color.fromRGBO(30, 144, 255, 1),
                          size: 16,
                        ),
                      ),
                  ],
                ),
              )),
            );
          }),
    );
  }
}
