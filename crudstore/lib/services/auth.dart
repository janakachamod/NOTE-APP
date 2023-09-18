import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User?> resgister(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future<User?> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
        backgroundColor: Colors.red,
      ));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

      if (googleuser != null) {
        final GoogleSignInAuthentication googleauth =
            await googleuser.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: googleauth.accessToken, idToken: googleauth.idToken);
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        return userCredential.user;
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }
}
