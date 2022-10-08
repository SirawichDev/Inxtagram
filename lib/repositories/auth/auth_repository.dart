import 'dart:ui';

import 'package:bloc_medium_scale_project/config/paths.dart';
import 'package:bloc_medium_scale_project/repositories/auth/base_auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../models/failure_model.dart';

class AuthRepository extends BaseAuthRepository {
  late final FirebaseFirestore _firebaseFirestore;
  late final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({ FirebaseFirestore? firebaseFirestore, auth.FirebaseAuth? firebaseAuth})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  @override
  Future<auth.User?> signUpWithEmailAndPassword(
      {required String username, required String email, required String password}) async {
    try {
      final credent = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = credent.user;
      _firebaseFirestore.collection(Paths.users).doc(user?.uid).set({
        'username': username,
        'email': email,
        'followers': 0,
        'following': 0
      });
      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message);
    }
  }

  @override
  Future<User?> logInWithEmailAndPassword(
      {required String email, required String password}) async {

    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on auth.FirebaseAuthException catch (err) {
    throw Failure(code: err.code, message: err.message);
    } on PlatformException catch (err) {
    throw Failure(code: err.code, message: err.message);
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
