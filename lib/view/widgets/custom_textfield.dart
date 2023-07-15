import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/view/styles/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String? hint;
  final String? icon;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Function()? press;
  final bool isRead;

  const CustomTextField({
    Key? key,
    this.title,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.validator,
    this.isRead = false,
    this.icon,
    this.press,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? "Title",
            style: body3,
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            readOnly: widget.isRead,
            keyboardType: widget.keyboardType,
            onTap: widget.press,
            validator: widget.validator,
            obscureText: showPassword && widget.isPassword,
            controller: widget.controller,
            decoration: widget.icon != null
                ? InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      widget.icon!,
                      height: 20,
                      width: 20,
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: widget.hint,
                    hintStyle: paragraph4.copyWith(color: netralDisableColor),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)))
                : InputDecoration(
                    suffixIcon: widget.isPassword
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            child: Icon(showPassword
                                ? Icons.remove_red_eye
                                : Icons.remove_red_eye_outlined),
                          )
                        : null,
                    hintText: widget.hint,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
          ),
        ],
      ),
    );
  }
}
