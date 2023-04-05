import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';

class NavigationDrawerWidget extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final Padding = const EdgeInsets.symmetric(horizontal: 20);
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        child: Scaffold(
          body: Container(
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
            child: ListView(
              padding: Padding,
              children: <Widget>[
                const SizedBox(
                  height: 35,
                ),
                // buildHeader(text: 'IIUI Transport Registration System'),
                Container(
                  height: 100,
                  width: 80,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/fulllogo.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                    thickness: 2, color: Color.fromARGB(179, 0, 0, 0)),
                const SizedBox(
                  height: 30,
                ),
                buildMenuitem(
                  text: 'Profile',
                  icon: Icons.person,
                  onClicked: () => Selecteditem(context, 0),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuitem(
                  text: 'Bus Details',
                  icon: Icons.directions_bus_outlined,
                  onClicked: () => Selecteditem(context, 1),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuitem(
                  text: 'Message Section',
                  icon: Icons.chat,
                  onClicked: () => Selecteditem(context, 2),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuitem(
                  text: 'Contact Us',
                  icon: Icons.contact_mail,
                  onClicked: () => Selecteditem(context, 3),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuitem(
                  text: 'Log Out',
                  icon: Icons.logout_outlined,
                  onClicked: () => Selecteditem(context, 4),
                ),
                const SizedBox(
                  height: 30,
                ),
                // const Divider(color: Colors.white70),
                // buildMenuitem(
                //   text: 'Log Out',
                //   icon: Icons.logout,
                //   onClicked: () => Selecteditem(context, 4),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@override
Widget buildMenuitem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  const Color.fromARGB(179, 0, 0, 0);
  const hoverColor = Color.fromARGB(221, 240, 204, 96);
  return Container(
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      leading: Icon(icon, color: const Color.fromARGB(179, 0, 0, 0)),
      title: Text(text,
          style: const TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
      hoverColor: hoverColor,
      onTap: onClicked,
    ),
  );
}

// Widget buildHeader({required String text}) {
//   const Color.fromARGB(179, 0, 0, 0);
//   return ListTile(
//     title:
//         Text(text, style: const TextStyle(color: Color.fromARGB(179, 0, 0, 0))),
//   );
// }

// ignore: non_constant_identifier_names
void Selecteditem(BuildContext context, int index) {
  FirebaseAuth auth = FirebaseAuth.instance;

  switch (index) {
    case 0:
      Navigator.pushNamed(context, RouteName.profileScreen);
      break;

    case 1:
      Navigator.pushNamed(context, RouteName.busdetailsScreen);
      break;

    case 2:
      Navigator.pushNamed(context, RouteName.userlistScreen);
      break;

    case 3:
      Navigator.pushNamed(context, RouteName.contactScreen);
      break;

    case 4:
      auth.signOut();
      Navigator.pushNamed(context, RouteName.loginScreen);
      break;
  }
}
