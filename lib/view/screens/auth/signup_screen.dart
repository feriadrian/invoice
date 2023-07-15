import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myinvoice/view/constant/constant.dart';
import 'package:myinvoice/view/screens/auth/signin_screen.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/circular_loading.dart';
import 'package:myinvoice/view/widgets/custom_textfield.dart';
import 'package:myinvoice/viewmodel/auth_provider.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullname = TextEditingController();

  final _email = TextEditingController();

  final _password = TextEditingController();

  final _confirmPassword = TextEditingController();

  _submit() async {
    if (_formKey.currentState!.validate()) {
      await context
          .read<AuthProvider>()
          .signUp(context, _fullname.text, _email.text, _password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: SvgPicture.asset(imageSignUp),
                ),
              ),
              Text(
                "Sign Up",
                style: heading0,
              ),
              const SizedBox(
                height: 18,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _fullname,
                      title: "Full Name",
                      hint: "e.g Darryl Martine",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Full name can\'t be empty';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _email,
                      title: "Email",
                      hint: "example@gmail.com",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Email can\'t be empty';
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
                        if (text.length < 8 || text.length > 16) {
                          return 'Password must be 8-16 characters';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _confirmPassword,
                      title: "Confirm Password",
                      isPassword: true,
                      hint: "********",
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Confirm password can\'t be empty';
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
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<AuthProvider>(builder: (context, state, _) {
                return Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryMain,
                      borderRadius: BorderRadius.circular(12)),
                  child: TextButton(
                      onPressed: () => _submit(),
                      child: state.isLoading
                          ? const CicularLoading()
                          : Text(
                              "Create Account",
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
                    "Already have account?",
                    style: TextStyle(color: netralDisableColor),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const SignInScreen(),
                        )),
                    child: Text(
                      "Sign In",
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
      )),
    );
  }
}
