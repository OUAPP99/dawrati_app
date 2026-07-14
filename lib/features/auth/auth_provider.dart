import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  bool isGuest = false;
  bool isLoading = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthProvider() {
    user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((u) {
      user = u;
      if (u != null) isGuest = false;
      notifyListeners();
    });
  }

  bool get isSignedIn => user != null;

  /// True right after a brand new account was created (vs. an existing
  /// user signing back in) — callers use this to decide whether to route
  /// to the questionnaire or straight to home.
  Future<AuthResult> signUpWithEmail(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthResult.success(isNewUser: true);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<AuthResult> signInWithEmail(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return AuthResult.success(isNewUser: false);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<AuthResult> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();

    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return AuthResult.failure('cancelled');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await FirebaseAuth.instance.signInWithCredential(credential);
      final isNewUser = result.additionalUserInfo?.isNewUser ?? false;
      return AuthResult.success(isNewUser: isNewUser);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code);
    } catch (_) {
      return AuthResult.failure('unknown');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim());
      return AuthResult.success(isNewUser: false);
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(e.code);
    }
  }

  void continueAsGuest() {
    isGuest = true;
    notifyListeners();
  }

  /// Signs in anonymously if not already signed in. Used by Partner Mode so
  /// a partner can read a shared partner-code view without creating a real
  /// account, while still satisfying Firestore rules that require
  /// `request.auth != null`.
  Future<void> ensureAnonymousSignIn() async {
    if (FirebaseAuth.instance.currentUser != null) return;
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      debugPrint('ensureAnonymousSignIn failed: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    isGuest = false;
    notifyListeners();
  }
}

class AuthResult {
  final bool ok;
  final bool isNewUser;
  final String? errorCode;

  AuthResult.success({required this.isNewUser})
      : ok = true,
        errorCode = null;

  AuthResult.failure(this.errorCode)
      : ok = false,
        isNewUser = false;
}
