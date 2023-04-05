import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:iiui_transport_app/res/color.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:iiui_transport_app/view/Profile%20Screen/profile_controller.dart';
import 'package:iiui_transport_app/view/Services/session_manager.dart';
import 'package:provider/provider.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ProfileSceen extends StatefulWidget {
  const ProfileSceen({super.key});

  @override
  State<ProfileSceen> createState() => _ProfileSceenState();
}

class _ProfileSceenState extends State<ProfileSceen> {
  final ref = FirebaseDatabase.instance.ref('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: NewGradientAppBar(
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade300,
            Colors.grey.shade300,
          ],
        ),
        title: const Center(child: Text('Profile')),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              auth.signOut();
              Navigator.pushNamed(context, RouteName.loginScreen);

              // Navigator.pushNamed(context, RouteName.homeScreen);
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: screenwidth,
        height: screenheight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown.shade300,
              Colors.amber.shade200,
            ],
          ),
        ),
        child: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child:
              Consumer<ProfileController>(builder: ((context, provider, child) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: StreamBuilder(
                    stream: ref
                        .child(SessionController().userId.toString())
                        .onValue,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        Map<dynamic, dynamic> map =
                            snapshot.data.snapshot.value;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            // ignore: sized_box_for_whitespace
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Container(
                                      height: 130,
                                      width: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.grey, width: 5)),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: provider.image == null
                                            ? map['profile'].toString() == ""
                                                ? const Icon(
                                                    Icons.person_outlined,
                                                    size: 50,
                                                    color: Colors.grey,
                                                  )
                                                : Image(
                                                    image: NetworkImage(
                                                        map['profile']
                                                            .toString()),
                                                    fit: BoxFit.cover,
                                                    loadingBuilder: (context,
                                                        child,
                                                        loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) {
                                                        return child;
                                                      }
                                                      return const Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                    },
                                                    errorBuilder: (context,
                                                        object, stack) {
                                                      return const Icon(
                                                        Icons.error_outline,
                                                        color: AppColors
                                                            .alertColor,
                                                      );
                                                    },
                                                  )
                                            : Image.file(
                                                File(provider.image!.path)
                                                    .absolute),
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    provider.pickImage(context);
                                  },
                                  child: const CircleAvatar(
                                    radius: 14,
                                    backgroundColor: AppColors.primaryIconColor,
                                    child: Icon(
                                      Icons.add,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Divider(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.6),
                              thickness: 3,
                            ),

                            // Username retrieve and change option with dialogue box
                            GestureDetector(
                              onTap: () {
                                provider.showUserNameDialogueAlert(
                                    context, map['userName']);
                              },
                              child: ReusableRow(
                                  title: 'Name:',
                                  value: map['userName'],
                                  iconData: Icons.person_outline),
                            ),

                            // Email retrieve
                            ReusableRow(
                                title: 'Email:',
                                value: map['email'],
                                iconData: Icons.email_outlined),

                            // Phone Number retrieve and change option with dialogue box
                            GestureDetector(
                              onTap: () {
                                provider.showPhoneDialogueAlert(
                                    context, map['phone']);
                              },
                              child: ReusableRow(
                                  title: 'Phone:',
                                  value: map['phone'] == ''
                                      ? 'xxx-xxx-xxx'
                                      : map['phone'],
                                  iconData: Icons.phone_outlined),
                            ),

                            // Registeration retrieve and change option with dialogue box
                            GestureDetector(
                              onTap: () {
                                provider.showRegDialogueAlert(
                                  context,
                                  map['registerationNo'],
                                );
                              },
                              child: ReusableRow(
                                  title: 'Reg. No:',
                                  value: map['registerationNo'] == ''
                                      ? 'xxxxxx'
                                      : map['registerationNo'],
                                  iconData: Icons.app_registration_outlined),
                            ),

                            // Degree retrieve and change option with dialogue box
                            GestureDetector(
                              onTap: () {
                                provider.showdegreeDialogueAlert(
                                  context,
                                  map['degree'],
                                );
                              },
                              child: ReusableRow(
                                  title: 'Degree:',
                                  value: map['degree'] == ''
                                      ? 'xxxxxx'
                                      : map['degree'],
                                  iconData: Icons.book_outlined),
                            ),

                            // Degree retrieve and change option with dialogue box
                            GestureDetector(
                              onTap: () {
                                provider.showsamesterDialogueAlert(
                                  context,
                                  map['samester'],
                                );
                              },
                              child: ReusableRow(
                                  title: 'Samester:',
                                  value: map['samester'] == ''
                                      ? 'xxxxxx'
                                      : map['samester'],
                                  iconData: Icons.book_outlined),
                            ),

                            // bus number retrieve and change option with dialogue box
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                });
                                // Timer(const Duration(seconds: 10),
                                //     () => setState(() => _isenabled = true));
                                await Future.delayed(
                                    const Duration(seconds: 2));

                                // ignore: use_build_context_synchronously
                                provider.showbusnumberDialogueAlert(
                                  context,
                                  map['busnumber'],
                                );
                              },
                              child: ReusableRow(
                                  title: 'Bus Number:',
                                  value: map['busnumber'],
                                  iconData: Icons.directions_bus_outlined),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        );
                      } else {
                        return Center(
                            child: Text(
                          'Something went wrong',
                          style: Theme.of(context).textTheme.titleMedium,
                        ));
                      }
                    },
                  ),
                ),
              ),
            );
          })),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReusableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(iconData),
          trailing: Text(value),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.5),
        ),
      ],
    );
  }
}
