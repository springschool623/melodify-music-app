// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/text_field.dart';
import 'package:melodify_app_project/pages/sign_in_up/create_user.dart';
import 'package:melodify_app_project/pages/sign_in_up/login_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
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
                  height: 35,
                ),
                Text(
                  'Đăng ký',
                  style: changeTextColor(robotoBold30, whiteColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    //Nhập Email
                    CustomTextField(text: 'Email', icon: 'email'),
                    const SizedBox(
                      height: 25,
                    ),
                    //Nhập Mật khẩu
                    CustomTextField(text: 'Mật khẩu', icon: 'lock'),
                    const SizedBox(height: 25,),
                    //Nhập ngày sinh
                    CustomTextField(text: 'Ngày sinh', icon: 'birthday'),
                  ],
                ),
                const SizedBox(height: 25,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateUser(),
                      )
                    );
                  }, 
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(500, 50),
                    backgroundColor: blueColor
                  ),
                  child: Text(
                    'Đăng ký',
                    style: changeTextColor(robotoMedium18, whiteColor),
                  ),
                ),
                const SizedBox(height: 20,),
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
                const SizedBox(height: 20,),
                //Option đăng nhập khác
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: blackColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: lightGrey, width: 1),
                        ),
                        child: Image.asset(
                          'assets/images/google_icon.png',
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: blackColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: lightGrey, width: 1),
                        ),
                        child: Image.asset(
                          'assets/images/fb_icon.png',
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: blackColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: lightGrey, width: 1),
                        ),
                        child: Image.asset(
                          'assets/images/mphone_icon.png',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đã có tài khoản?',
                      style: changeTextColor(robotoRegular16, whiteColor),
                    ),
                    TextButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        )
                      );
                    }, 
                    child: Text(
                      'Đăng nhập',
                      style: changeTextColor(robotoBold18, blueColor),
                    ),
                  ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}