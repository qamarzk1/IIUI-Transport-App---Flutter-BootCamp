// ignore_for_file: dead_code

import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiui_transport_app/res/color.dart';
import 'package:iiui_transport_app/utils/utils.dart';
import 'package:iiui_transport_app/view/Services/session_manager.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as firebase_Storage;

class ProfileController with ChangeNotifier {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

  firebase_Storage.FirebaseStorage storage =
      firebase_Storage.FirebaseStorage.instance;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final regController = TextEditingController();
  final degreeController = TextEditingController();
  final samesterController = TextEditingController();
  final busnumberController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final regFocusNode = FocusNode();
  final degreeFocusNode = FocusNode();
  final samesterFocusNode = FocusNode();
  final busnumberFocusNode = FocusNode();

  final picker = ImagePicker();
  XFile? _image;

  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      // ignore: use_build_context_synchronously
      uploadImage(context); //image upload call
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      // ignore: use_build_context_synchronously
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // ignore: sized_box_for_whitespace
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                  },
                  leading: const Icon(Icons.image),
                  title: const Text('Gallery'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_Storage.Reference storageRef =
        firebase_Storage.FirebaseStorage.instance
            // ignore: prefer_interpolation_to_compose_strings
            .ref('/profileImage' + SessionController().userId.toString());

    firebase_Storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);
    final newUrl = await storageRef.getDownloadURL();

    ref
        .child(SessionController().userId.toString())
        .update({'profile': newUrl.toString()}).then((value) {
      setLoading(false);
      Utils.toastMessage('Profile updated');
      _image = null;
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
    });
  }

  Future<void> showUserNameDialogueAlert(BuildContext context, String name) {
    nameController.text = name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('Update Username')),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  maxLength: 20,
                  controller: nameController,
                  focusNode: nameFocusNode,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[A-Z a-z]')),
                  ],
                  decoration: const InputDecoration(
                      hintText: "Enter User Name",
                      icon: Icon(Icons.person_outline)),
                  keyboardType: TextInputType.text,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: AppColors.alertColor),
              ),
            ),
            TextButton(
              onPressed: () {
                ref.child(SessionController().userId.toString()).update(
                    {'userName': nameController.text.toString()}).then((value) {
                  nameController.clear();
                });
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: Theme.of(context).textTheme.titleSmall!,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPhoneDialogueAlert(
      BuildContext context,
      // ignore: non_constant_identifier_names
      String PhoneNumber) {
    phoneController.text = PhoneNumber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Phone Number')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 12,
                    controller: phoneController,
                    focusNode: phoneFocusNode,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter Phone Number",
                        icon: Icon(Icons.phone_outlined)),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update(
                      {'phone': phoneController.text.toString()}).then((value) {
                    phoneController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ],
          );
        });
  }

  Future<void> showRegDialogueAlert(
      BuildContext context,
      // ignore: non_constant_identifier_names
      String RegNumber) async {
    regController.text = RegNumber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Registeration Number')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 10,
                    controller: regController,
                    focusNode: regFocusNode,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter Registeration Number",
                        icon: Icon(Icons.app_registration_outlined)),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    'registerationNo': regController.text.toString()
                  }).then((value) {
                    regController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  void showdegreeDialogueAlert(BuildContext context, String Degree) async {
    degreeController.text = Degree;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Degree Details')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 20,
                    controller: degreeController,
                    focusNode: degreeFocusNode,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter Degree Details",
                        icon: Icon(Icons.book_outlined)),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    'degree': degreeController.text.toString()
                  }).then((value) {
                    degreeController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ],
          );
        });
  }

  // ignore: non_constant_identifier_names
  void showsamesterDialogueAlert(BuildContext context, String Samester) async {
    samesterController.text = Samester;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Samester Details')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 2,
                    controller: samesterController,
                    focusNode: samesterFocusNode,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter Samester number",
                        icon: Icon(Icons.book_outlined)),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    'samester': samesterController.text.toString()
                  }).then((value) {
                    samesterController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ],
          );
        });
  }

  void showbusnumberDialogueAlert(
      // ignore: non_constant_identifier_names
      BuildContext context,
      // ignore: non_constant_identifier_names
      String Busnumber) async {
    busnumberController.text = Busnumber;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Update Bus Number')),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 2,
                    controller: busnumberController,
                    focusNode: busnumberFocusNode,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        hintText: "Enter Bus Number",
                        icon: Icon(Icons.directions_bus_outlined)),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: AppColors.alertColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    'busnumber': busnumberController.text.toString()
                  }).then((value) {
                    busnumberController.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ],
          );
        });
  }
}
