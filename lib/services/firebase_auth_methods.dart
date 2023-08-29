import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spiritual_gpt/utils/show_snackbar_widget.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  //state persistence
  Stream<User?> get authState => _auth.authStateChanges();
  //FirebaseAuth.instance.userChanges();
  //FirebaseAuth.instance.idTokenChanges();

  //Email Sign up
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBarWidget(context, e.message!);
    }
  }

  //Email Login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // if(_auth.currentUser!.emailVerified){
      //   await sendEmailVerification(context);
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBarWidget(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBarWidget(context, 'Wrong password');
      } else {
        showSnackBarWidget(context, e.message!);
      }
    }
  }

  //Email Verification
  // Future<void> sendEmailVerification(BuildContext context) async {
  //   try {
  //     await _auth.currentUser!.sendEmailVerification();
  //     showSnackBar(context, 'Verification Email Sent');
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!);
  //   }
  // }

  //google sign in
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      showSnackBarWidget(context, e.message!);
    }
  }
}
