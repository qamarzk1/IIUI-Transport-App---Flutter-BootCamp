import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/view/Card/incompletecardinfo_screen.dart';
import 'package:iiui_transport_app/view/Services/session_manager.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
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
          title: const Center(child: Text('Card')),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: SizedBox(
                      width: 400,
                      height: 300,
                      child: StreamBuilder(
                        stream: ref
                            .child(SessionController().userId.toString())
                            .onValue,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasData) {
                            Map<dynamic, dynamic> map =
                                snapshot.data.snapshot.value;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // ignore: sized_box_for_whitespace
                                // Stack(
                                //   alignment: Alignment.bottomCenter,
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.symmetric(
                                //           vertical: 10),
                                //       child: Center(
                                //         child: Container(
                                //           height: 130,
                                //           width: 130,
                                //           decoration: BoxDecoration(
                                //               shape: BoxShape.circle,
                                //               border: Border.all(
                                //                   color: Colors.grey,
                                //                   width: 5)),
                                //           child: ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(100),
                                //               child: Image(
                                //                 image: NetworkImage(
                                //                     map['profile'].toString()),
                                //                 fit: BoxFit.cover,
                                //                 loadingBuilder: (context, child,
                                //                     loadingProgress) {
                                //                   if (loadingProgress == null) {
                                //                     return child;
                                //                   }
                                //                   return const Center(
                                //                       child:
                                //                           CircularProgressIndicator());
                                //                 },
                                //                 errorBuilder:
                                //                     (context, object, stack) {
                                //                   return const Icon(
                                //                     Icons.error_outline,
                                //                     color: AppColors.alertColor,
                                //                   );
                                //                 },
                                //               )),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // const SizedBox(
                                //   height: 40,
                                // ),
                                // Divider(
                                //   color: const Color.fromARGB(255, 0, 0, 0)
                                //       .withOpacity(0.6),
                                //   thickness: 3,
                                // ),

                                // Username retrieve and change option with dialogue box
                                ReusableRow(
                                  title: 'Name:',
                                  value: map['userName'],
                                ),

                                // Email retrieve
                                ReusableRow(
                                  title: 'Email:',
                                  value: map['email'],
                                ),

                                // Phone Number retrieve and change option with dialogue box
                                ReusableRow(
                                  title: 'Phone:',
                                  value: map['phone'],
                                ),

                                // Registeration retrieve and change option with dialogue box
                                ReusableRow(
                                  title: 'Reg. No:',
                                  value: map['registerationNo'],
                                  // iconData: Icons.app_registration_outlined,
                                ),

                                // // Degree retrieve and change option with dialogue box
                                // GestureDetector(
                                //   onTap: () {
                                //     provider.showdegreeDialogueAlert(
                                //       context,
                                //       map['degree'],
                                //     );
                                //   },
                                //   child: ReusableRow(
                                //       title: 'Degree.',
                                //       value: map['degree'] == ''
                                //           ? 'xxxxxx'
                                //           : map['degree'],
                                //       iconData: Icons.book_outlined),
                                // ),

                                // // Degree retrieve and change option with dialogue box
                                // GestureDetector(
                                //   onTap: () {
                                //     provider.showsamesterDialogueAlert(
                                //       context,
                                //       map['samester'],
                                //     );
                                //   },
                                //   child: ReusableRow(
                                //       title: 'Samester.',
                                //       value: map['samester'] == ''
                                //           ? 'xxxxxx'
                                //           : map['samester'],
                                //       iconData: Icons.book_outlined),
                                // ),

                                // bus number retrieve and change option with dialogue box
                                ReusableRow(
                                  title: 'Bus Number.',
                                  value: map['busnumber'],
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: IncompleteDartScreen(),
                            );
                          }
                        },
                      )
                      // decoration: const BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage('assets/images/QR code.png'),
                      //     // fit: BoxFit.fill,
                      //   ),
                      // ),
                      ),
                )
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

  const ReusableRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          trailing: Text(value),
        ),
      ],
    );
  }
}
