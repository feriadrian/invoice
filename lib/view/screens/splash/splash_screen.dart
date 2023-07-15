// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/data/pref.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/auth/signin_screen.dart';
import 'package:myinvoice/view/screens/home/home_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/viewmodel/profile_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkToken() async {
    String? token = await Pref.getToken();
    if (token != null) {
      await Provider.of<ProfileProvider>(context, listen: false).getCustomer();
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
            builder: (context) => SignInScreen(),
          ),
          (route) => false);
    }
  }

  initSplash() {
    return Timer(
      const Duration(seconds: 1),
      () {
        checkToken();
      },
    );
  }

  @override
  void initState() {
    initSplash();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: SizedBox(
                  height: 200,
                  width: 250,
                  child: SvgPicture.asset(appLogo),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(
                    "Manage your bill\n  with one hand",
                    style: heading2.copyWith(fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
