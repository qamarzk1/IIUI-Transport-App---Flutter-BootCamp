import 'package:flutter/material.dart';
import 'package:iiui_transport_app/res/components/input_text_field.dart';
import 'package:iiui_transport_app/res/components/round_button.dart';
import 'package:iiui_transport_app/view/Foregot%20Password/forgot_controller.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    emailFocusNode.dispose();
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Enter your email address\nto recover your password',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        InputTextField(
                          myController: emailController,
                          focusNode: emailFocusNode,
                          // ignore: non_constant_identifier_names
                          onFiledSubmittedValue: (Value) {},
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ChangeNotifierProvider(
                    create: (_) => ForgotPasswordController(),
                    child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child) {
                        return RoundButton(
                          title: 'Recover',
                          loading: provider.loading,
                          onPress: () {
                            if (_formkey.currentState!.validate()) {
                              provider.forgot(
                                context,
                                emailController.text.toString(),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
