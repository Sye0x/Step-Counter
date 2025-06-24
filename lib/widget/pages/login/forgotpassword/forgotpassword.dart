import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:step_counter/const/constantcolors.dart";
import "package:step_counter/widget/reuseable/input_field.dart";

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // Optional: back functionality
                    },
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.sp,
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "Enter your email Address below and we will"
                "send you a verification code to help you reset the password",
                style: TextStyle(color: secondaryColor, fontSize: 14.sp),
              ),
              SizedBox(height: 40.h),
              CustomTextField(hint: "Enter Your Email"),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                height: 60.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    "Send Code",
                    style: TextStyle(
                      fontSize: 25.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
