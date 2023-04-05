import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iiui_transport_app/res/components/input_text_field.dart';
import 'package:iiui_transport_app/res/components/round_button.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:iiui_transport_app/utils/utils.dart';
import 'package:iiui_transport_app/view/login/login_controller.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _loginScreenState();
}

// ignore: camel_case_types
class _loginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    //Back button to exit the system
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.brown,
              Colors.amber,
            ],
          )),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "To",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "IIUI Transport Application",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enter your email address and password',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          InputTextField(
                            myController: emailController,
                            focusNode: emailFocusNode,
                            // ignore: non_constant_identifier_names
                            onFiledSubmittedValue: (Value) {
                              Utils.fieldFocus(
                                  context, emailFocusNode, passwordFocusNode);
                            },
                            onValidator: (value) {
                              return value.isEmpty ? 'enter Email' : null;
                            },
                            keyBoardType: TextInputType.emailAddress,
                            hint: 'Email',
                            obsecureText: false,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Colors.black45,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InputTextField(
                            myController: passwordController,
                            focusNode: passwordFocusNode,
                            // ignore: non_constant_identifier_names
                            onFiledSubmittedValue: (Value) {},
                            onValidator: (value) {
                              return value.isEmpty ? 'enter Password' : null;
                            },
                            keyBoardType: TextInputType.visiblePassword,
                            hint: 'Password',
                            obsecureText: true,
                            prefixIcon: const Icon(
                              Icons.password_outlined,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.forgotPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginController(),
                      child: Consumer<LoginController>(
                        builder: (context, provider, child) {
                          return RoundButton(
                            title: 'Login',
                            loading: provider.loading,
                            onPress: () {
                              if (_formkey.currentState!.validate()) {
                                provider.login(
                                    context,
                                    emailController.text.toString(),
                                    passwordController.text.toString());
                              }
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.signUpScreen);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Dont have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 15),
                            children: [
                            TextSpan(
                              text: "  Sign Up",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
