import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_counter/const/constantcolors.dart';
import 'package:step_counter/widget/reuseable/input_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _Signup();
}

class _Signup extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future signUp() async {
    if (confirmPasswordController.text.trim() ==
        passwordController.text.trim()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text("Password Do not match"),
              content: Text("Re-enter Password"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text("Okay"),
                ),
              ],
            ),
      );
      passwordController.clear();
      confirmPasswordController.clear();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget header(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context); // Optional: back functionality
            },
            icon: Icon(Icons.arrow_back),
            iconSize: 30.sp,
          ),
        ),
        Center(
          child: Text(
            "Sign up",
            style: TextStyle(
              color: primaryColor,
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget orDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color.fromARGB(197, 189, 189, 189),
            thickness: 0.5,
            endIndent: 5.w,
          ),
        ),
        Text(
          "OR",
          style: TextStyle(
            color: primaryColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color.fromARGB(197, 189, 189, 189),
            thickness: 0.5,
            indent: 5.w,
          ),
        ),
      ],
    );
  }

  Widget socialButton(String text, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 0.85.sw,
      height: 65.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: primaryColor, width: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: cardBackgroundColor,
        ),
        child: Row(
          children: [
            Icon(icon, color: secondaryColor, size: 25.sp),

            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formFields() {
    return Column(
      children: [
        CustomTextField(hint: "Full Name"),
        SizedBox(height: 15.h),
        CustomTextField(hint: "Username"),
        SizedBox(height: 15.h),
        CustomTextField(hint: "Email", controller: emailController),
        SizedBox(height: 15.h),
        CustomTextField(
          hint: "Password",
          isPassword: true,
          controller: passwordController,
        ),
        SizedBox(height: 15.h),
        CustomTextField(
          hint: "Confirm Password",
          isPassword: true,
          controller: confirmPasswordController,
        ),
        SizedBox(height: 25.h),

        SizedBox(
          width: double.infinity,
          height: 60.h,
          child: ElevatedButton(
            onPressed: signUp,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 25.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                header(context),
                SizedBox(height: 15.h),
                formFields(),
                SizedBox(height: 30.h),
                orDivider(),
                SizedBox(height: 60.h),
                socialButton(
                  "Sign up with Google",
                  FontAwesomeIcons.google,
                  () {},
                ),
                SizedBox(height: 20.h),
                socialButton(
                  "Sign up with Facebook",
                  FontAwesomeIcons.facebook,
                  () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
