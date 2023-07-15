import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/custom_textfield.dart';
import 'package:myinvoice/view/widgets/failed_dialog.dart';
import 'package:myinvoice/view/widgets/success_dialog.dart';
import 'package:myinvoice/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isReset = false;

  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: _isReset ? _confirmation() : _resetPassword(),
        ),
      )),
    );
  }

  Column _confirmation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: 200,
            width: 100,
            child: SvgPicture.asset(imageCheckbox),
          ),
        ),
        Text(
          "Check your email",
          style: heading1,
        ),
        Text(
          "An email been sent to your email address, ${email.text}",
          style: TextStyle(color: netralDisableColor),
        )
      ],
    );
  }

  Column _resetPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            height: 300,
            width: 250,
            child: SvgPicture.asset(imageForgotPassword),
          ),
        ),
        Text(
          "Forget Password",
          style: heading1,
        ),
        const SizedBox(
          height: 18,
        ),
        CustomTextField(
          controller: email,
          title: "Email",
          hint: "example@gmail.com",
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: primaryMain, borderRadius: BorderRadius.circular(12)),
          child: Consumer<AuthProvider>(builder: (context, state, _) {
            return TextButton(
                onPressed: () async {
                  // successDialog(context, email.text);
                  final res = await state.resetPassword(email.text);
                  if (res) {
                    successDialog(context, email.text);
                    setState(() {
                      _isReset = true;
                    });
                  } else {
                    failedDialog(context);
                  }
                },
                child: Text(
                  "Reset Password",
                  style: body1.copyWith(color: Colors.white),
                ));
          }),
        ),
      ],
    );
  }
}
