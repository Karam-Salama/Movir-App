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
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword method:  ${e.toString()} and code is ${e.code}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'كلمة المرور المقدمة ضعيفة جدًا.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'يوجد حساب بالفعل بهذا البريد الإلكتروني.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'عنوان البريد الإلكتروني غير صالح.');
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException(message: 'عنوان البريد الإلكتروني غير مسموح به.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'يرجى التحقق من الاتصال بالانترنت.');
      } else {
        throw CustomException(
            message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.createUserWithEmailAndPassword method:  ${e.toString()}');
      throw CustomException(message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
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
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword method:  ${e.toString()} and code is ${e.code}');
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        throw CustomException(
            message: ' البريد الإلكتروني او الرقم السري غير صحيح.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(
            message: ' البريد الإلكتروني او الرقم السري غير صحيح.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'عنوان البريد الإلكتروني غير صالح.');
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: 'حسابك معطل.');
      } else if (e.code == 'operation-not-allowed') {
        throw CustomException(message: 'عنوان البريد الإلكتروني غير مسموح به.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'يرجى التحقق من الاتصال بالانترنت.');
      } else {
        throw CustomException(
            message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithEmailAndPassword method:  ${e.toString()}');
      throw CustomException(message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
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
      log('Exception in FirebaseAuthService.signInWithGoogle method:  ${e.toString()} and code is ${e.code}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
            message: 'يوجد حساب بالفعل بهذا البريد الإلكتروني.');
      } else if (e.code == 'invalid-credential' ||
          e.code == 'operation-not-allowed' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        throw CustomException(
            message: 'حدث خطاء، يرجى المحاولة مرة اخرى لاحقا.');
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: 'حسابك معطل.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'يرجى التحقق من الاتصال بالانترنت.');
      } else {
        throw CustomException(
            message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithGoogle method: ${e.toString()}');
      throw CustomException(message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
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
      log('Exception in FirebaseAuthService.signInWithFacebook method:  ${e.toString()} and code is ${e.code}');
      if (e.code == 'account-exists-with-different-credential') {
        throw CustomException(
            message: 'يوجد حساب بالفعل بهذا البريد الإلكتروني.');
      } else if (e.code == 'invalid-credential' ||
          e.code == 'operation-not-allowed' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        throw CustomException(
            message: 'حدث خطاء، يرجى المحاولة مرة اخرى لاحقا.');
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: 'حسابك معطل.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'يرجى التحقق من الاتصال بالانترنت.');
      } else {
        throw CustomException(
            message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithFacebook method: ${e.toString()}');
      throw CustomException(message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
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
      log('Exception in FirebaseAuthService.signInWithApple method:  ${e.toString()}');
      throw CustomException(message: 'حدث خطاء، يرجى المحاولة مرة أخرى لاحقا.');
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithApple method: ${e.toString()}');
      throw CustomException(message: 'حدث خطاء، يرجى المحاولة مرة أخرى لاحقا.');
    }
  }

  Future<void> forgetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.forgetPassword method: ${e.toString()}');
      if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        throw CustomException(
            message: 'لا يوجد حساب مسجل بهذا البريد الإلكتروني.');
      }
    } catch (e) {
      log('Exception in FirebaseAuthService.forgetPassword method: ${e.toString()}');
      throw CustomException(message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  Future deleteUser() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuthService.deleteUser method: ${e.toString()}');
      throw CustomException(message: 'حدث خطاء، يرجى المحاولة مرة أخرى لاحقا.');
    } catch (e) {
      log('Exception in FirebaseAuthService.deleteUser method: ${e.toString()}');
      throw CustomException(
          message: 'حدث خطاء، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log('Exception in FirebaseAuthService.signOut method: ${e.toString()}');
      throw CustomException(message: 'حدث خطاء، يرجى المحاولة مرة اخرى لاحقا.');
    }
  }
}
