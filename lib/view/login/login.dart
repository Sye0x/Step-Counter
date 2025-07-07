import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:step_counter/const/constantcolors.dart';
import 'package:step_counter/widget/pages/signup/signup.dart';
import 'package:step_counter/widget/reuseable/input_field.dart';
import 'package:step_counter/widget/pages/login/loginlogic.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = LoginController(
      emailController: emailController,
      passwordController: passwordController,
      context: context,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget header() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, size: 30.sp),
          ),
        ),
        Center(
          child: Text(
            "Sign In",
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

  Widget formFields() {
    return Column(
      children: [
        CustomTextField(hint: "Email", controller: emailController),
        SizedBox(height: 15.h),
        CustomTextField(
          hint: "Password",
          isPassword: true,
          controller: passwordController,
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                "Forgot Password",
                style: TextStyle(color: primaryColor, fontSize: 18.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        SizedBox(
          width: double.infinity,
          height: 60.h,
          child: ElevatedButton(
            onPressed: controller.signIn,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              "Login",
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

  Widget orDivider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color.fromARGB(144, 189, 189, 189),
            thickness: 1.5,
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
            color: const Color.fromARGB(144, 189, 189, 189),
            thickness: 1.5,
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

  Widget signUpRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: secondaryColor, fontSize: 18.sp),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUp()),
            );
          },
          child: Text(
            "Sign up",
            style: TextStyle(color: primaryColor, fontSize: 22.sp),
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
                header(),
                SizedBox(height: 75.h),
                formFields(),
                SizedBox(height: 75.h),
                signUpRedirect(),
                SizedBox(height: 20.h),
                orDivider(),
                SizedBox(height: 60.h),
                socialButton(
                  "Sign in with Google",
                  FontAwesomeIcons.google,
                  controller.signInWithGoogle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
