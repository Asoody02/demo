import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    print("User ID: ${userCredential.user?.uid}");
    print("Email: ${userCredential.user?.email}");
    print("Display Name: ${userCredential.user?.displayName}");
    print("Photo URL: ${userCredential.user?.photoURL}");

      return userCredential;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Register with email and password
  Future<UserCredential?> signUpWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}