import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/res/color.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class IncompleteDartScreen extends StatefulWidget {
  const IncompleteDartScreen({super.key});

  @override
  State<IncompleteDartScreen> createState() => _IncompleteDartScreenState();
}

class _IncompleteDartScreenState extends State<IncompleteDartScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: NewGradientAppBar(
          gradient: LinearGradient(
            colors: [
              Colors.brown.shade300,
              Colors.grey.shade300,
            ],
          ),
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
          title: const Center(
            child: Text('Card'),
          ),
        ),
        body: Center(
          child: Container(
            width: 300,
            height: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.brown.shade300,
                  Colors.amber.shade200,
                ],
              ),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 180,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/fulllogo.png'),
                            // fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: Container(
                        width: 15,
                        height: 80,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/dots.png'),
                            // fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Text(
                  'Bus Entry Card',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 4,
                    height: 3,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                    width: 200,
                    height: 300,
                    child: Text(
                        'Please Provide Full Details to Your Profile In Order To View Your Card'))
              ],
            ),
          ),
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
