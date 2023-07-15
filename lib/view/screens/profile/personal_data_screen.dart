import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myinvoice/services/customer_service.dart';
import 'package:myinvoice/view/styles/styles.dart';
import 'package:myinvoice/view/widgets/custom_textfield.dart';
import 'package:myinvoice/view/widgets/method_helper.dart';
import 'package:myinvoice/view/widgets/rounded_button.dart';
import 'package:myinvoice/viewmodel/profile_provider.dart';
import 'package:provider/provider.dart';


class PersonalDataScreen extends StatelessWidget {
  PersonalDataScreen({super.key, required this.fullName});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullName;

  final TextEditingController phoneC = TextEditingController();
  final TextEditingController adressC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    File file = File('');
    Future<XFile?> getImage() async {
      ImagePicker picker = ImagePicker();
      XFile? selectImage =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
      file = File(selectImage!.path);
      print(file);
      return XFile(selectImage.path);
    }

    final profileHomeView = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: MethodHelper.buildAppBar(context, 'Personal Data'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(
                    profileHomeView.customer.displayProfilePictureUrl!),
              ),
              const SizedBox(
                height: 6,
              ),
              TextButton(
                onPressed: () async {
                  await getImage();
                  await CustomerServices().uploadImage(file);
                  await profileHomeView.getCustomer();
                },
                child: Text(
                  'Edit Photo',
                  style: heading5.copyWith(color: primaryMain),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                        controller: fullName,
                        title: 'Full Name',
                        hint: 'Enter your name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required.';
                          } else {
                            return null;
                          }
                        }),
                    Text(
                      'Email Adress',
                      style: body3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: profileHomeView.customer.email,
                          fillColor: const Color(0xffcdcdcd),
                          filled: true,
                          hintStyle: paragraph4.copyWith(
                              fontSize: 14, color: netralDisableColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    CustomTextField(
                      controller: phoneC,
                      keyboardType: TextInputType.number,
                      title: ' Phone Number',
                      hint: '0849723434',
                    ),
                    Text(
                      'Adress',
                      style: body3,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 110,
                      child: TextFormField(
                        controller: adressC,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required.';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter your address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    RoundedButton(
                      title: 'Save',
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          await CustomerServices().updateProfileCustomer(
                              fullName.text, adressC.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Update Profile Success!',
                              ),
                            ),
                          );
                          await profileHomeView.getCustomer();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
