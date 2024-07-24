// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:melodify_app_project/pages/sign_in_up/login_page.dart';
import 'package:melodify_app_project/pages/sign_in_up/register_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Logo
                  Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo.png')),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Hàng triệu bài hát\nMiễn phí trên Melodify.',
                    style: changeTextColor(robotoBlack28, whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //Các nút có thể đăng nhập
                  Column(
                    children: [
                      //Tiếp tục bằng SĐT
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(500, 50),
                            backgroundColor: blackColor,
                            foregroundColor: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                  color: lightGreyLowOpacity, width: 1),
                            )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/mphone_icon.png',
                                ),
                              ),
                            ),
                            Text(
                              'Tiếp tục bằng số điện thoại',
                              style:
                                  changeTextColor(robotoMedium18, whiteColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //Đăng nhập bằng Google
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(500, 50),
                            backgroundColor: blackColor,
                            foregroundColor: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                  color: lightGreyLowOpacity, width: 1),
                            )),
                        onPressed: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/google_icon.png',
                                ),
                              ),
                            ),
                            Text(
                              'Tiếp tục bằng Google',
                              style:
                                  changeTextColor(robotoMedium18, whiteColor),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      //Đăng nhập bằng Facebook
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(500, 50),
                            backgroundColor: blackColor,
                            foregroundColor: whiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: BorderSide(
                                  color: lightGreyLowOpacity, width: 1),
                            )),
                        onPressed: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset(
                                  'assets/images/fb_icon.png',
                                ),
                              ),
                            ),
                            Text(
                              'Tiếp tục bằng Facebook',
                              style:
                                  changeTextColor(robotoMedium18, whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white, // Màu của đường kẻ
                          thickness: 1, // Độ dày của đường kẻ
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Hoặc',
                          style: changeTextColor(robotoMedium16, whiteColor),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white, // Màu của đường kẻ
                          thickness: 1, // Độ dày của đường kẻ
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      fixedSize: Size(500, 45),
                    ),
                    child: Text(
                      'Đăng ký miễn phí',
                      style: changeTextColor(robotoMedium16, whiteColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: Text(
                      'Đăng nhập',
                      style: changeTextColor(robotoBold16, whiteColor),
                    ),
                  ),

                  //Link youtube
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Video hướng dẫn',
                        style: changeTextColor(robotoBold16, whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
