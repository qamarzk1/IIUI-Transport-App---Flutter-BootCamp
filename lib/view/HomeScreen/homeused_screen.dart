import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/res/components/navigationdrawerwidget.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:iiui_transport_app/view/Profile%20Screen/profile_screen.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class HomeUsedScreen extends StatefulWidget {
  const HomeUsedScreen({super.key});

  @override
  State<HomeUsedScreen> createState() => _HomeUsedScreenState();
}

class _HomeUsedScreenState extends State<HomeUsedScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor: Colors.brown.shade50,

      // Menu drawer
      drawer: const NavigationDrawerWidget(),
      appBar: NewGradientAppBar(
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade300,
            Colors.grey.shade300,
          ],
        ),
        title: const Center(child: Text('Home')),
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
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 30, 5, 0),
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/fulllogo.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // ignore: sized_box_for_whitespace

                  Divider(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.6),
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade300,
                          Colors.brown.shade300,
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileSceen(),
                          ),
                        );
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade300,
                          Colors.brown.shade300,
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.busdetailsScreen);
                      },
                      leading: const Icon(Icons.directions_bus_outlined),
                      title: const Text('Bus Details'),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade300,
                          Colors.brown.shade300,
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.userlistScreen);
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade300,
                          Colors.brown.shade300,
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.cardScreen);
                      },
                      leading: const Icon(Icons.card_membership_outlined),
                      title: const Text('Card'),
                      trailing: const Icon(Icons.navigate_next),
                      // enabled: false,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade300,
                          Colors.brown.shade300,
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.contactScreen);
                      },
                      leading: const Icon(Icons.contact_mail),
                      title: const Text('Contact Us'),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.grey.shade300,
                          Colors.brown.shade300,
                        ],
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        auth.signOut();
                        Navigator.pushNamed(context, RouteName.loginScreen);

                        // Navigator.pushNamed(context, RouteName.homeScreen);
                      },
                      leading: const Icon(Icons.logout_outlined),
                      title: const Text('Log Out'),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // StreamBuilder(
                  //   stream: ref
                  //       .child(SessionController().userId.toString())
                  //       .child('busnumber')
                  //       .onValue,
                  //   builder: (context, AsyncSnapshot snapshot) {
                  //     if (!snapshot.hasData) {
                  //       return const Center(child: CircularProgressIndicator());
                  //     } else if (snapshot.hasData) {
                  //       return Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           gradient: LinearGradient(
                  //             begin: Alignment.topRight,
                  //             end: Alignment.bottomCenter,
                  //             colors: [
                  //               Colors.grey.shade300,
                  //               Colors.brown.shade300,
                  //             ],
                  //           ),
                  //         ),
                  //         child: ListTile(
                  //           onTap: () {
                  //             Navigator.pushNamed(
                  //                 context, RouteName.cardScreen);
                  //           },
                  //           enabled: true,
                  //           leading: const Icon(Icons.card_membership_outlined),
                  //           title: const Text('Card'),
                  //           trailing: const Icon(Icons.navigate_next),
                  //         ),
                  //       );
                  //     } else {
                  //       return Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           gradient: LinearGradient(
                  //             begin: Alignment.topRight,
                  //             end: Alignment.bottomCenter,
                  //             colors: [
                  //               Colors.grey.shade300,
                  //               Colors.brown.shade300,
                  //             ],
                  //           ),
                  //         ),
                  //         child: ListTile(
                  //           onTap: () {
                  //             Navigator.pushNamed(
                  //                 context, RouteName.cardScreen);
                  //           },
                  //           enabled: false,
                  //           leading: const Icon(Icons.card_membership_outlined),
                  //           title: const Text('Card'),
                  //           trailing: const Icon(Icons.navigate_next),
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
