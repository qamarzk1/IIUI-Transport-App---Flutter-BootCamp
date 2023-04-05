import 'package:flutter/material.dart';
import 'package:iiui_transport_app/res/components/input_text_field.dart';
import 'package:iiui_transport_app/res/components/round_button.dart';
import 'package:iiui_transport_app/utils/routes/route_name.dart';
import 'package:iiui_transport_app/utils/utils.dart';
import 'package:iiui_transport_app/view/signup/signup_controller.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameFocusNode = FocusNode();
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
            child: ChangeNotifierProvider(
              create: (_) => SignupController(),
              child: Consumer<SignupController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: Text(
                            "IIUI Transport Application",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Enter your email address and password \n              to register your account',
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
                                myController: usernameController,
                                focusNode: usernameFocusNode,
                                // ignore: non_constant_identifier_names
                                onFiledSubmittedValue: (value) {
                                  Utils.fieldFocus(context, usernameFocusNode,
                                      emailFocusNode);
                                },
                                onValidator: (value) {
                                  return value.isEmpty
                                      ? 'enter Username'
                                      : null;
                                },
                                keyBoardType: TextInputType.text,
                                hint: 'User Name',
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
                                myController: emailController,
                                focusNode: emailFocusNode,
                                onFiledSubmittedValue: (value) {
                                  Utils.fieldFocus(context, emailFocusNode,
                                      passwordFocusNode);
                                },
                                onValidator: (value) {
                                  return value.isEmpty ? 'enter Email' : null;
                                },
                                keyBoardType: TextInputType.emailAddress,
                                hint: 'Email',
                                obsecureText: false,
                                prefixIcon: const Icon(
                                  Icons.person_outline,
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
                                  return value.isEmpty
                                      ? 'enter Password'
                                      : null;
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
                        RoundButton(
                          title: 'Sign up',
                          loading: provider.loading,
                          onPress: () {
                            // ignore: avoid_print
                            print('tap');
                            if (_formkey.currentState!.validate()) {
                              provider.signup(
                                  usernameController.text.toString(),
                                  emailController.text.toString(),
                                  passwordController.text.toString());
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginScreen);
                          },
                          child: Text.rich(
                            TextSpan(
                              text: "Already have an account?",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: 15),
                              children: [
                                TextSpan(
                                  text: "  Login",
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
