import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:step_counter/const/constantcolors.dart';
import 'package:step_counter/view/reuseable/input_field.dart';
import 'package:step_counter/controller/set_username_controller.dart';

class SetUsernameView extends StatefulWidget {
  const SetUsernameView({super.key});

  @override
  State<SetUsernameView> createState() => _SetUsernameViewState();
}

class _SetUsernameViewState extends State<SetUsernameView> {
  late SetUsernameController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SetUsernameController(context);
  }

  @override
  void dispose() {
    _controller.dispose();
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
            child: Column(
              children: [
                SizedBox(height: 100.h),
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
                        controller: _controller.userNameController,
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
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: _controller.submitUsername,
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
