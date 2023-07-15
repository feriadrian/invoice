import 'package:flutter/material.dart';
import 'package:myinvoice/view/styles/styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    required this.press,
    this.isLoading = false,
  }) : super(key: key);

  final String title;
  final Function() press;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: primaryMain,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: press,
        child: isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                title,
                style: heading4,
              ),
      ),
    );
  }
}
