import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 300;
  late CountdownTimerController controller;
  @override
  void initState() {
    controller = CountdownTimerController(
      endTime: endTime,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Consumer<AuthProvider>(builder: (context, state, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Enter code sent\nto your email",
                    style: heading1,
                  ),
                  Text(
                    "Already sent to email :",
                    style: TextStyle(color: netralDisableColor),
                  ),
                  Text(
                    state.emailSignUp ?? "example12345@gmail.com",
                    style: TextStyle(color: netralDisableColor),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  OtpTextField(
                    numberOfFields: 4,
                    fieldWidth: 55,
                    keyboardType: TextInputType.text,
                    onSubmit: (code) async {
                      await state.verifEmail(context, code);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Your code will expire in",
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CountdownTimer(
                          endWidget: const Text(""),
                          endTime: endTime,
                          controller: controller,
                          textStyle: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            controller.start();
                          }),
                          child: const Text(
                            "Resend Code",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
