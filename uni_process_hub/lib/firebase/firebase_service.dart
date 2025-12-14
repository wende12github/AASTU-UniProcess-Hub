import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_process_hub/features/model/user_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// REGISTER User
  Future<void> registerUser(UserModel user) async {
    try {
      //Create auth account
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final uid = credential.user!.uid;

      //Save user profile in Firestore
      await _firestore.collection('users').doc(uid).set({
        'fullName': user.fullName,
        'studentId': user.studentId,
        'yearOfStudy': user.yearOfStudy,
        'department': user.department,
        'enrollmentStatus': user.enrollmentStatus,
        'email': user.email,
        'phone': user.phone,
        'profileImageUrl': user.profileImageUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e));
    }
  }

  /// LOGIN
  Future<User?> login({required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e));
    }
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// FETCH USER PROFILE
  Future<UserModel?> fetchUserProfile() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      return UserModel(
        fullName: data['fullName'] ?? '',
        studentId: data['studentId'] ?? '',
        yearOfStudy: data['yearOfStudy'] ?? '',
        department: data['department'] ?? '',
        enrollmentStatus: data['enrollmentStatus'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        password: '',
        profileImageUrl: data['profileImageUrl'] ?? '',
      );
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return null;
    }
  }

  /// CURRENT USER
  User? get currentUser => _auth.currentUser;

  /// ERROR MAPPING
  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      default:
        return 'Authentication failed. Please try again';
    }
  }
}
