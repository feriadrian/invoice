import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/auth/reset_password_screen.dart';
import 'package:myinvoice/view/screens/auth/signup_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/custom_textfield.dart';
class ConfirmResetPasswordScreen extends StatelessWidget {
  ConfirmResetPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 250,
                    child: SvgPicture.asset(imageSignUp),
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
                  controller: _password,
                  title: "Password",
                  hint: "********",
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (text.length < 4) {
                      return 'Too short';
                    }

                    return null;
                  },
                ),
                CustomTextField(
                  controller: _confirmPassword,
                  isPassword: true,
                  title: "Confirm Password",
                  hint: "********",
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (text.length < 8 || text.length > 16) {
                      return 'Password must be 8-16 characters';
                    }
                    if (text != _password.text) {
                      return 'Password doesnt match';
                    }
                    return null;
                  },
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      )),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(color: netralDisableColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryMain,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                      onPressed: () => _submit(context),
                      child: Text(
                        "Sign In",
                        style: body1.copyWith(color: Colors.white),
                      )),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: TextStyle(color: netralDisableColor),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                          (value) => false),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: primaryMain),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
