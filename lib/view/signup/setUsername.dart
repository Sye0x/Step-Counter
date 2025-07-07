import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_counter/const/constantcolors.dart';
import 'package:step_counter/widget/reuseable/input_field.dart';

class Setusername extends StatefulWidget {
  const Setusername({super.key});

  @override
  State<Setusername> createState() => _Setusername();
}

class _Setusername extends State<Setusername> {
  final TextEditingController userNameController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            // 👈 This is the key fix
            child: Column(
              children: [
                SizedBox(height: 100.h), // Gives spacing from top
                Text(
                  "Create your username",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: 30.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        hint: "Enter username",
                        controller: userNameController,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      height: 56.h,
                      width: 56.h,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        onPressed: () {
                          final username = userNameController.text.trim();
                          if (username.isNotEmpty) {
                            Navigator.pop(context, username);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please enter a username"),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
