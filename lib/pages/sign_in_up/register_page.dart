// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:melodify_app_project/components/text_field.dart';
import 'package:melodify_app_project/pages/sign_in_up/create_user.dart';
import 'package:melodify_app_project/pages/sign_in_up/login_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      final response = await http.post(
        Uri.parse('https://melodify-app-api.vercel.app/api/users'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
          'dob': dobController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else if (response.statusCode == 400) {
        // If the server returned a 400 CONFLICT response, email already exists.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    'Email đã tồn tại',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              content: Text(
                'Vui lòng sử dụng một email khác!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 10),
                  Text('Đăng ký không thành công', style: TextStyle(fontSize: 16),),
                ],
              ),
              content: Text(
                'Vui lòng kiểm tra lại thông tin!',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              actions: [
                TextButton(
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        throw Exception('Failed to create user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
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
                          // Nhập Email
                          CustomTextField(
                            controller: emailController,
                            text: 'Email',
                            icon: 'email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập email';
                              } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                return 'Vui lòng nhập email hợp lệ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          // Nhập Mật khẩu
                          CustomTextField(
                            controller: passwordController,
                            text: 'Mật khẩu',
                            icon: 'lock',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập mật khẩu';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25,),
                          // Nhập ngày sinh
                          CustomTextField(
                            controller: dobController,
                            text: 'Ngày sinh',
                            icon: 'birthday',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Vui lòng nhập ngày sinh';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      ElevatedButton(
                        onPressed: registerUser, 
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(500, 50),
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
                          const Expanded(
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
                          const Expanded(
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
                            'Đã có tài khoản?',
                            style: changeTextColor(robotoRegular16, whiteColor),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
