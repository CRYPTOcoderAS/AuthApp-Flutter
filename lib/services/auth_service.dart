import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authapp/models/models.dart';
import 'package:simple_gravatar/simple_gravatar.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Future<User> get getUser => _auth.authStateChanges().listen((User user) {if (user == null)});

  Stream<User> get userStatus => _auth.authStateChanges();

  Stream<UserModel> streamFirestoreUser(User firebaseUser) {
    if (firebaseUser?.uid == null) {}
    return null;
  }

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        print('uID: ' + result.user.uid);
        print('email: ' + result.user.email);
        Gravatar gravatar = Gravatar(email);
        String gravatarUrl = gravatar.imageUrl(
          size: 200,
          defaultImage: GravatarImage.retro,
          rating: GravatarRating.pg,
          fileExtension: true,
        );
        UserModel _newUser = UserModel(
            uid: result.user.uid,
            email: result.user.email,
            name: '',
            photoUrl: gravatarUrl);
        //_updateUserFirestore(_newUser, result.user);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() {
    _auth.signOut();
  }
}
