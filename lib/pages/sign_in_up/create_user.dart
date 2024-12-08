import 'package:flutter/material.dart';
import 'package:melodify_app_project/pages/main_page.dart';
import 'package:melodify_app_project/stuff/background.dart';
import 'package:melodify_app_project/stuff/color.dart';
import 'package:melodify_app_project/stuff/same_using.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController _userName = TextEditingController();

  bool? _isChecked1 = false;
  bool? _isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundContainer(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 75, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tên của bạn là gì?',
                  style: changeTextColor(robotoBold26, lighterGrey),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _userName,
                  style: changeTextColor(robotoMedium18, lighterGrey),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17.0, horizontal: 25.0),
                    floatingLabelStyle:
                        changeTextColor(robotoMedium18, blueColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: lightGrey,
                          width: 1.5,
                          style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: blueColor,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Tên của bạn sẽ hiện trên Melodify',
                  style: changeTextColor(robotoRegular14, lighterGrey),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.white, // Màu của đường kẻ
                  thickness: 1, // Độ dày của đường kẻ
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Bằng việc nhấn vào "Tạo tài khoản", bạn đồng ý vối Điều khoản sử dụng qua Melodify.',
                  style: changeTextColor(robotoRegular14, lighterGrey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Điều khoản sử dụng',
                  style: changeTextColor(robotoBlack16, lightBlue),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Để tìm hiểu thêm về cách thức Melodify thu thập, sử dụng, chia sẻ và bảo vệ dữ liệu cá nhân của bạn, vui lòng xem Chính sách quyền riêng tư của Melodify.',
                  style: changeTextColor(robotoRegular14, lighterGrey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Chính sách quyền riêng tư',
                  style: changeTextColor(robotoBlack16, lightBlue),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        'Tôi không muốn nhận tin nhắn tiếp thị từ Melodify.',
                        style: changeTextColor(robotoRegular14, lighterGrey),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Transform.scale(
                        scale: 1.6,
                        child: Checkbox(
                          value: _isChecked1,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isChecked1 = newValue;
                            });
                          },
                          activeColor:
                              Colors.blue,
                          checkColor: Colors.white,
                          side: const BorderSide(
                            color: lighterGrey,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(
                        'Chia sẻ dữ liệu đăng ký của tôi với các nhà cung cấp nội dung Melodify nhằn mục đích tiếp thị.',
                        style: changeTextColor(robotoRegular14, lighterGrey),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Transform.scale(
                        scale: 1.6,
                        child: Checkbox(
                          value: _isChecked2,
                          onChanged: (bool? newValue) {
                            setState(() {
                              _isChecked2 = newValue;
                            });
                          },
                          activeColor:
                              Colors.blue,
                          checkColor: Colors.white,
                          side: const BorderSide(
                            color: lighterGrey,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox.shrink()),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        )
                      );
                    }, 
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      foregroundColor: blackColor,
                      fixedSize: const Size(250, 60),
                    ),
                    child: Text(
                      'Tạo tài khoản',
                      style: changeTextColor(robotoBold18, blackColor),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
