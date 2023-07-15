import 'package:flutter/material.dart';
import 'package:myinvoice/view/styles/styles.dart';

class MethodHelper {
  //ini merupakan method untuk build Custom Appbar
  static AppBar buildAppBar(BuildContext context, String title,
      {bool isCenter = true}) {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: const [
              Icon(
                Icons.arrow_back_ios_new_sharp,
              ),
              Text('Back'),
            ],
          ),
        ),
      ),
      leadingWidth: MediaQuery.of(context).size.height * 1 / 10,
      elevation: 0,
      centerTitle: isCenter,
      title: Text(
        title,
        style: heading3.copyWith(color: pressed),
      ),
    );
  }
}
