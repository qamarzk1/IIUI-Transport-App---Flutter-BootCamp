import 'package:flutter/material.dart';
import 'package:iiui_transport_app/view/Services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices services = SplashServices();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    services.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown,
              Colors.amber,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/background.png"))),
            ),
            const SizedBox(
              height: 40,
            ),
            const Center(
              child: Text(
                "Welcome",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                "To",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Center(
              child: Text(
                "IIUI Transport Application",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),

      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      // body: Container(
      //   decoration: const BoxDecoration(
      //       image: DecorationImage(
      //           fit: BoxFit.fill,
      //           image: AssetImage("assets/images/background.png"))),
      // ),
    );
  }
}
