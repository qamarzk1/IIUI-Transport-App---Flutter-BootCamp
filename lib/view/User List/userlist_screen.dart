import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/res/color.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:iiui_transport_app/view/Chat%20Screen/message_screen.dart';
import 'package:iiui_transport_app/view/Services/session_manager.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class UserlistScreen extends StatefulWidget {
  const UserlistScreen({super.key});

  @override
  State<UserlistScreen> createState() => _UserlistScreenState();
}

class _UserlistScreenState extends State<UserlistScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Admin');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: NewGradientAppBar(
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade300,
            Colors.grey.shade300,
          ],
        ),
        title: const Center(child: Text('Users List')),
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
        height: screenheight,
        width: screenwidth,
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
        child: SafeArea(
          child: FirebaseAnimatedList(
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              if (SessionController().userId.toString() ==
                  snapshot.child('uid').value.toString()) {
                return Container();
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.grey.shade500,
                          ],
                        ),
                      ),
                      child: ListTile(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: MessageScreen(
                                image:
                                    snapshot.child('profile').value.toString(),
                                name:
                                    snapshot.child('userName').value.toString(),
                                email: snapshot.child('email').value.toString(),
                                recieverId:
                                    snapshot.child('uid').value.toString(),
                              ),
                              withNavBar: false);
                        },
                        leading: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                            ),
                          ),
                          // child: snapshot
                          //             .child('profile')
                          //             .value
                          //             .toString() ==
                          //         ''
                          //     ? const Icon(Icons.person)
                          //     : ClipRRect(
                          //         borderRadius: BorderRadius.circular(50),
                          //         child: Image(
                          //             fit: BoxFit.cover,
                          //             image: NetworkImage(snapshot
                          //                 .child('profile')
                          //                 .value
                          //                 .toString())),
                          //       ),
                        ),
                        title:
                            Text(snapshot.child('userName').value.toString()),
                        subtitle:
                            Text(snapshot.child('email').value.toString()),
                        trailing: const Icon(Icons.navigate_next,
                            size: 50, color: AppColors.primaryButtonColor),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
