import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spiritual_gpt/utils/show_snackbar_widget.dart';
import 'package:spiritual_gpt/widgets/custom_button.dart';
import 'package:spiritual_gpt/widgets/custom_text_field.dart';

import '../services/firebase_auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showSnackBarWidget(context, 'Please fill in all the required fields');
      return;
    }

    if (password != confirmPassword) {
      showSnackBarWidget(context, 'Passwords do not match');
      return;
    }

    context.read<FirebaseAuthMethods>().signUpWithEmail(
      email: email,
      password: password,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded))),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dive into Enlightenment',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              const Text(
                'Let\'s create an account!',
                style: TextStyle(fontSize: 35),
              ),
              const SizedBox(height: 14),
              CustomTextField(
                  hintText: 'First Name', controller: firstNameController),
              const SizedBox(height: 14),
              CustomTextField(
                  hintText: 'Last Name', controller: lastNameController),
              const SizedBox(height: 14),
              CustomTextField(hintText: 'Email', controller: emailController),
              const SizedBox(height: 14),
              CustomTextField(
                  hintText: 'Password', controller: passwordController),
              const SizedBox(height: 14),
              CustomTextField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController),
              const SizedBox(height: 14),
              CustomButton(title: 'Sign Up', onTap: signUpUser),
              const SizedBox(height: 14),
              Center(
                  child: Text(
                'OR',
                style: Theme.of(context).textTheme.bodySmall,
              )),
              const SizedBox(height: 14),
              CustomButton(
                  title: 'Continue with Google',
                  onTap: () {
                    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                  }),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      ' Sign In',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
