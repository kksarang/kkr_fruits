import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth? _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _user;
  bool _isGuest = false;

  User? get user => _user;
  bool get isGuest => _isGuest;

  AuthProvider() {
    _initializeAuth();
  }

  void _initializeAuth() {
    try {
      _auth = FirebaseAuth.instance;
      _auth!.authStateChanges().listen((User? user) {
        _user = user;
        if (user != null) {
          _isGuest = false;
        }
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Firebase Auth init failed: $e');
    }
  }

  Future<User?> signInWithGoogle() async {
    if (_auth == null) {
      debugPrint('Auth not initialized');
      return null;
    }
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // The user canceled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth!.signInWithCredential(
        credential,
      );
      _user = userCredential.user;
      _isGuest = false;
      notifyListeners();
      return _user;
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      return null;
    }
  }

  void signInAsGuest() {
    _isGuest = true;
    _user = null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    if (_auth != null) {
      await _auth!.signOut();
    }
    _isGuest = false;
    _user = null;
    notifyListeners();
  }

  Future<void> deleteAccount() async {
    if (_user != null) {
      try {
        await _user!.delete();
        await logout();
      } catch (e) {
        debugPrint('Delete Account Error: $e');
        // Handle re-authentication requirement if necessary
      }
    }
  }
}
