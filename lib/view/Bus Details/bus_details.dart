import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class BusdetailsScreen extends StatefulWidget {
  const BusdetailsScreen({super.key});

  @override
  State<BusdetailsScreen> createState() => _BusdetailsScreenState();
}

class _BusdetailsScreenState extends State<BusdetailsScreen> {
  Query ref = FirebaseDatabase.instance.ref().child('Buses');
  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Buses');

  //Function
  Widget listItem({required Map buses}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 600,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Center(
                child: Text(
                  'Bus Number:  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  buses['busnumber'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Center(
                child: Text(
                  'Vechile No:   ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  buses['vechileno'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Center(
                child: Text(
                  'Driver Name:  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  buses['drivername'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Center(
                child: Text(
                  'Driver Mobile:  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  buses['drivermobile'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Center(
                child: Text(
                  'Location:  ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  buses['location'],
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Bus Stop (Time) :  ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              buses['busstopstime'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 3,
            height: 40,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
        appBar: NewGradientAppBar(
          gradient: LinearGradient(
            colors: [
              Colors.brown.shade300,
              Colors.grey.shade300,
            ],
          ),
          title: const Center(child: Text('Bus Details')),
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
          child: SafeArea(
            child: SizedBox(
              height: double.infinity,
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map buses = snapshot.value as Map;
                  buses['key'] = snapshot.key;

                  return listItem(buses: buses);
                },
              ),
            ),
          ),
        ));
  }
}
