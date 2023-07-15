import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/auth/signin_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
class SuccessSignupScreen extends StatelessWidget {
  const SuccessSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: SvgPicture.asset(imageSuccessSignup),
              ),
              Text(
                "Yeay, your account has\n          been created",
                style: heading2,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                  "Sign In to continue your journey\n                  for your bills"),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: SizedBox(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primaryMain,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextButton(
                        onPressed: () async {
                          Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                              (route) => false);
                        },
                        child: Text(
                          "Login Now",
                          style: body1.copyWith(color: Colors.white),
                        )),
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
