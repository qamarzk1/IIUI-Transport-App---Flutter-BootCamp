import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  //Funcation
  Widget listItem({required Map map}) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 210,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Center(
                child: Text(
                  'Email:  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Text(
                  map['email'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Center(
                child: Text(
                  'Phone:   +92',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              Center(
                child: Text(
                  map['phone'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    final ref = FirebaseDatabase.instance.ref('Admin');
    FirebaseAuth auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: NewGradientAppBar(
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade300,
            Colors.grey.shade300,
          ],
        ),
        title: const Center(child: Text('Contact Us')),
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
          child: SizedBox(
            height: double.infinity,
            child: FirebaseAnimatedList(
              query: ref,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                Map map = snapshot.value as Map;
                map['key'] = snapshot.key;

                return listItem(map: map);
              },
            ),
          ),
        ),
      ),
    );
  }
}
