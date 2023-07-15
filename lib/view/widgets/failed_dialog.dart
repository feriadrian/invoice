import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myinvoice/view/constant/constant.dart';

Future<dynamic> failedDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              SizedBox(height: 100, child: SvgPicture.asset(imageError)),
              SizedBox(
                height: 20,
              ),
              const Text(
                "Failed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  "Email not found",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
