import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:iiui_transport_app/res/color.dart';
import 'package:iiui_transport_app/utils/utils.dart';
import 'package:iiui_transport_app/view/Services/session_manager.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class MessageScreen extends StatefulWidget {
  final String image, name, email, recieverId;
  const MessageScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.recieverId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  // ignore: non_constant_identifier_names
  final MessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Row(
          children: [
            Container(
              height: 30,
              width: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            // CircleAvatar(
            //   child: Container(
            //     // color: Colors.transparent,
            //     decoration: const BoxDecoration(
            //       color: Colors.transparent,
            //       image: DecorationImage(
            //         image: AssetImage('assets/images/logo.png'),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              width: 4,
            ),
            Text(widget.name.toString()),
          ],
        ),
        gradient: LinearGradient(
          colors: [
            Colors.brown.shade300,
            Colors.grey.shade300,
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: FirebaseAnimatedList(
                      query: ref
                          .child('Chats')
                          .child(SessionController().userId.toString()),
                      itemBuilder: (context, snapshot, animation, index) {
                        return ListTile(
                          title: Container(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey,
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  snapshot.child('message').value.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Expanded(
                //   child: ListView.builder(
                //     itemCount: 100,
                //     itemBuilder: ((context, index) {
                //       return Row(
                //         children: [
                //           Text(
                //             index.toString(),
                //           ),
                //           const Text(':\t\t'),

                //           // Text(ref.child('Chat').child('message').toString())
                //         ],
                //       );
                //     }),
                //   ),
                // ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: // padding of whole chat text field area
                            const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: MessageController,

                          cursorColor: Colors.black,
                          cursorHeight: 15,

                          // decoration
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(height: 0, fontSize: 19),
                          decoration: InputDecoration(
                              hintText: 'Enter Message',
                              contentPadding: const EdgeInsets.all(
                                  15), // padding of content within text field
                              suffixIcon: InkWell(
                                onTap: () {
                                  sendMessage();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(
                                      8), // also for content within text field
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.primaryIconColor,
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              labelStyle: TextStyle(
                                  color: Colors.black45.withOpacity(0.8)),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.alertColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendMessage() {
    if (MessageController.text.isEmpty) {
      Utils.toastMessage('Enter Message');
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref
          .child('Chats')
          .child(SessionController().userId.toString())
          .child(timeStamp)
          .set({
        'isSeen': false,
        'message': MessageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'recieverId': widget.recieverId,
        'type': 'text',
        'time': timeStamp.toString(),
      }).then((value) {
        MessageController.clear();
      });
    }
  }
}
