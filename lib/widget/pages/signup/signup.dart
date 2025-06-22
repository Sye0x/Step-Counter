import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:step_counter/const/constantcolors.dart";
import "package:step_counter/widget/reuseable/input_field.dart";

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget header() {
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
              iconSize: screenWidth * 0.06,
            ),
          ),
          Center(
            child: Text(
              "Sign up",
              style: TextStyle(
                color: primaryColor,
                fontSize: screenWidth * 0.06,
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
          CustomTextField(hint: "Full Name"),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(hint: "Username"),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(hint: "Email"),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(hint: "Password", isPassword: true),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(hint: "Confirm Password", isPassword: true),
          SizedBox(height: screenHeight * 0.03),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.4,
                ),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),

              backgroundColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.pressed)) {
                  return primaryColor.withOpacity(
                    0.8,
                  ); // Slightly darker when pressed
                }
                return primaryColor; // Normal state
              }),
            ),
            child: Text("Sign Up", style: TextStyle(color: Color(0xFFFFFFFF))),
          ),
        ],
      );
    }

    Widget orDivider() {
      return Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey.shade500,
              thickness: 0.5,
              endIndent: screenWidth * 0.02,
            ),
          ),
          Text(
            "OR",
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: screenHeight * 0.02,
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.shade500,
              thickness: 0.5,
              indent: screenWidth * 0.02,
            ),
          ),
        ],
      );
    }

    Widget socialButton({
      required String text,
      required IconData icon,
      required VoidCallback onPressed,
      required double screenWidth,
      required double screenHeight,
    }) {
      return SizedBox(
        width: screenWidth * 0.85,
        height: screenHeight * 0.065,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: primaryColor, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: cardBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon, color: secondaryColor, size: 20),
              SizedBox(width: screenWidth * 0.05),
              Text(
                text,
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, // 4% of screen width
            vertical: screenHeight * 0.02, // 2% of screen height
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              header(),
              SizedBox(height: screenHeight * 0.06),
              formFields(),
              SizedBox(height: screenHeight * 0.03),
              orDivider(),
              SizedBox(height: screenHeight * 0.02),
              socialButton(
                text: "Sign in with Google",
                icon: FontAwesomeIcons.google,
                onPressed: () {
                  // Handle Google sign-in
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                // Add an icon before the text for Google
              ),

              SizedBox(height: screenHeight * 0.02),

              socialButton(
                text: "Sign in with Facebook",
                icon: FontAwesomeIcons.facebook,
                onPressed: () {
                  // Handle Facebook sign-in
                },
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
              // Add other widgets here, using similar responsive values
            ],
          ),
        ),
      ),
    );
  }
}
