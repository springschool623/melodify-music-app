// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:melodify_app_project/components/text_field.dart';
import 'package:melodify_app_project/pages/main_page.dart';
import 'package:melodify_app_project/pages/sign_in_up/register_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isForgetPass = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final response = await http.post(
      Uri.parse('https://melodify-app-api.vercel.app/api/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then navigate to the MainPage.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    } else {
      // If the server did not return a 200 OK response,
      // then show an error message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Đăng nhập thất bại'),
            content: Text('Vui lòng kiểm tra lại thông tin!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

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
                // Logo
                Container(
                  height: 150,
                  width: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Text(
                  'Đăng nhập',
                  style: changeTextColor(robotoBold30, whiteColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    // Nhập Email
                    CustomTextField(
                      controller: emailController,
                      text: 'Email',
                      icon: 'email',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // Nhập Mật khẩu
                    CustomTextField(
                      controller: passwordController,
                      text: 'Mật khẩu',
                      icon: 'lock',
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                // Nút quên mật khẩu
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: _isForgetPass,
                      onChanged: (bool? value) {
                        setState(() {
                          _isForgetPass = value ?? false;
                        });
                      },
                      activeColor: Colors.blue, // Màu sắc của checkbox khi được chọn
                      checkColor: Colors.white, // Màu sắc của dấu kiểm
                      side: BorderSide(
                        color: Colors.blue, // Màu viền của checkbox
                        width: 2.0, // Độ dày của viền
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Text(
                      'Nhớ mật khẩu',
                      style: changeTextColor(robotoMedium14, lightGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 5,),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(500, 50),
                    backgroundColor: blueColor,
                  ),
                  child: Text(
                    'Đăng nhập',
                    style: changeTextColor(robotoMedium18, whiteColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: changeTextColor(robotoBold16, whiteColor),
                  ),
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
                const SizedBox(height: 20,),
                // Option đăng nhập khác
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
                      'Không có tài khoản?',
                      style: changeTextColor(robotoRegular16, whiteColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Đăng ký',
                        style: changeTextColor(robotoBold18, blueColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
