import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../errors/exceptions.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in createUserWithEmailAndPassword: ${e.toString()} and code: ${e.code}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The provided password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'An account already exists with this email.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'The email address is invalid.');
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException(
            message: 'Email/password sign-in is not allowed.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'An error occurred. Please try again later.');
      }
    } catch (e) {
      log('Unexpected error in createUserWithEmailAndPassword: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }

  Future<User> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in signInWithEmailAndPassword: ${e.toString()} and code: ${e.code}');
      if (e.code == 'user-not-found' ||
          e.code == 'invalid-credential' ||
          e.code == 'wrong-password') {
        throw CustomException(message: 'Invalid email or password.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'The email address is invalid.');
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: 'This account has been disabled.');
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException(
            message: 'Email/password sign-in is not allowed.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'An error occurred. Please try again later.');
      }
    } catch (e) {
      log('Unexpected error in signInWithEmailAndPassword: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return (await FirebaseAuth.instance.signInWithCredential(credential))
          .user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in signInWithGoogle: ${e.toString()} and code: ${e.code}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
            message: 'An account already exists with this email.');
      } else if (e.code == 'invalid-credential' ||
          e.code == 'operation-not-allowed' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        throw CustomException(
            message: 'An error occurred. Please try again later.');
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: 'This account has been disabled.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'An error occurred. Please try again later.');
      }
    } catch (e) {
      log('Unexpected error in signInWithGoogle: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }

  Future<User> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
      return (await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential))
          .user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in signInWithFacebook: ${e.toString()} and code: ${e.code}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
            message: 'An account already exists with this email.');
      } else if (e.code == 'invalid-credential' ||
          e.code == 'operation-not-allowed' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        throw CustomException(
            message: 'An error occurred. Please try again later.');
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: 'This account has been disabled.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'An error occurred. Please try again later.');
      }
    } catch (e) {
      log('Unexpected error in signInWithFacebook: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<User> signInWithApple() async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      return (await FirebaseAuth.instance.signInWithCredential(oauthCredential))
          .user!;
    } on CustomException catch (e) {
      log('CustomException in signInWithApple: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    } catch (e) {
      log('Unexpected error in signInWithApple: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }

  Future<void> forgetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log('Exception in forgetPassword: ${e.toString()}');
      if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        throw CustomException(
            message: 'No account found with this email address.');
      }
    } catch (e) {
      log('Unexpected error in forgetPassword: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }

  Future deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.deleteUser method: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    } catch (e) {
      log('Exception in FirebaseAuthService.deleteUser method: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log('Exception in FirebaseAuthService.signOut method: ${e.toString()}');
      throw CustomException(
          message: 'An error occurred. Please try again later.');
    }
  }
}
