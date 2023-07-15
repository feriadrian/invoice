import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/auth/reset_password_screen.dart';
import 'package:myinvoice/view/screens/auth/signup_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/circular_loading.dart';
import 'package:myinvoice/view/widgets/custom_textfield.dart';
import 'package:myinvoice/viewmodel/auth_provider.dart';
import 'package:myinvoice/viewmodel/profile_provider.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();

  final _password = TextEditingController();

  _submit(BuildContext context, String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await context.read<AuthProvider>().signIn(context, email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
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
                    child: SvgPicture.asset(imageSignIn),
                  ),
                ),
                Text(
                  "Sign In",
                  style: heading0,
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomTextField(
                  controller: _email,
                  title: "Email",
                  hint: "example@gmail.com",
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Email can\'t be empty';
                    }
                    if (text.length < 4) {
                      return 'Too short';
                    }
                    if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text)) {
                      return 'Invalid Email';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _password,
                  isPassword: true,
                  title: "Password",
                  hint: "********",
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Password can\'t be empty';
                    }

                    if (text.length < 8) {
                      return 'Password must be at least 8 characters in length';
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
                      "Forgot Password?",
                      style: TextStyle(color: primaryBackground),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Consumer<AuthProvider>(builder: (context, state, _) {
                  return Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: primaryMain,
                        borderRadius: BorderRadius.circular(12)),
                    child: TextButton(
                        onPressed: () async {
                          _submit(context, _email.text, _password.text);
                        },
                        child: state.isLoading
                            ? const CicularLoading()
                            : Text(
                                "Sign In",
                                style: body1.copyWith(color: Colors.white),
                              )),
                  );
                }),
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
