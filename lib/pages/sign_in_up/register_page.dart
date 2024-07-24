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

  Future<void> registerUser() async {
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
      // If the server did return a 201 CREATED response,
      // then navigate to the CreateUser page.
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateUser(),
        ),
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create user.');
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
                        CustomTextField(
                          controller: emailController,
                          text: 'Email',
                          icon: 'email'
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        //Nhập Mật khẩu
                        CustomTextField(
                          controller: passwordController,
                          text: 'Mật khẩu',
                          icon: 'lock'
                        ),
                        const SizedBox(height: 25,),
                        //Nhập ngày sinh
                        CustomTextField(
                          controller: dobController,
                          text: 'Ngày sinh',
                          icon: 'birthday'
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
        ],
      ),
    );
  }
}
