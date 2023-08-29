import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spiritual_gpt/utils/show_snackbar_widget.dart';
import 'package:spiritual_gpt/widgets/get_started_widget.dart';
import 'package:spiritual_gpt/widgets/custom_button.dart';
import 'package:spiritual_gpt/widgets/custom_text_field.dart';

import '../services/firebase_auth_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void logInUser() async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        showSnackBarWidget(context, 'Please enter both email and password');
        return;
      }

      context.read<FirebaseAuthMethods>()
          .loginWithEmail(email: email, password: password, context: context);
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        enableDrag: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(8),
                            height: 250,
                            child: const GetStartedWidget(),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Get Started',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Signup',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/logoImage.png',
                width: 389,
                height: 389,
              ),
              const Text(
                'spiritual gpt',
                style: TextStyle(
                  fontFamily: 'Samarkan',
                  fontSize: 45,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Enlightening Conversations, Nurturing Souls',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 20),
              CustomTextField(hintText: 'Email', controller: emailController),
              const SizedBox(height: 10),
              CustomTextField(
                  hintText: 'Password', controller: passwordController),
              const SizedBox(height: 10),
              CustomButton(title: 'Sign In', onTap: logInUser),
              const SizedBox(height: 10),
              const Center(
                  child: Text(
                'OR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              )),
              const SizedBox(height: 10),
              CustomButton(
                title: 'Continue with Google',
                onTap: () {
                  context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                },
                iconUrl: 'assets/images/googleIcon.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
