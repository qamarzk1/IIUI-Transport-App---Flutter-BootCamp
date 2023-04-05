import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:iiui_transport_app/res/color.dart';
import 'package:iiui_transport_app/view/Bus%20Details/bus_details.dart';
import 'package:iiui_transport_app/view/Profile%20Screen/profile_controller.dart';
import 'package:iiui_transport_app/view/Profile%20Screen/profile_screen.dart';
import 'package:iiui_transport_app/view/Services/session_manager.dart';
import 'package:iiui_transport_app/view/User%20List/userlist_screen.dart';
import 'package:iiui_transport_app/view/login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingsScreen> {
  final ref = FirebaseDatabase.instance.ref('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        gradient: const LinearGradient(
          colors: [
            Colors.brown,
            Colors.amberAccent,
          ],
        ),
        title: const Center(child: Text('Settings')),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const LoginScreen();
                  },
                ),
                (_) => false,
              );
              // auth.signOut();
              // Navigator.pushNamed(context, RouteName.homeScreen);
            },
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child:
            Consumer<ProfileController>(builder: ((context, provider, child) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.brown,
                Colors.amber,
              ],
            )),
            child: SingleChildScrollView(
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
                            const SizedBox(
                              height: 40,
                            ),

                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 112, 128, 221),
                                  Colors.grey,
                                ],
                              )),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileSceen()));
                                },
                                leading: const Icon(Icons.person),
                                title: const Text('Profile'),
                                trailing: const Icon(Icons.navigate_next),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 112, 128, 221),
                                  Colors.grey,
                                ],
                              )),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BusdetailsScreen()));
                                },
                                leading: const Icon(Icons.bus_alert),
                                title: const Text('Bus Details'),
                                trailing: const Icon(Icons.navigate_next),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 112, 128, 221),
                                  Colors.grey,
                                ],
                              )),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const UserlistScreen()));
                                },
                                leading: const Icon(Icons.chat),
                                title: const Text('Message Section'),
                                trailing: const Icon(Icons.navigate_next),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 112, 128, 221),
                                  Colors.grey,
                                ],
                              )),
                              child: ListTile(
                                onTap: () {},
                                leading: const Icon(Icons.person),
                                title: const Text('Contact Us'),
                                trailing: const Icon(Icons.navigate_next),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
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
            ),
          );
        })),
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
