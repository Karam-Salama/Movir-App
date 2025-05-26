// ignore_for_file: unnecessary_null_comparison, unnecessary_type_check

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/database/cache_helper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/service/database_service.dart';
import '../../../../core/service/service_firebase_auth.dart';
import '../../../../core/service/service_locator.dart';
import '../../../../core/utils/api_const.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repos/auth_repo.dart';
import '../models/user_model.dart';

class AuthRepoImplement extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImplement(
      {required this.databaseService, required this.firebaseAuthService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = UserEntity(
        name: name,
        email: email,
        uId: user.uid,
      );
      await addUserData(user: userEntity);
      await verifyEmail();
      return Right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      log('Exception in AuthRepoImplementation.createUserWithEmailAndPassword method:  ${e.toString()}');
      return Left(ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final user = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImplementation.signInWithEmailAndPassword method:  ${e.toString()}');
      return Left(ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(
          path: FirebaseEndpoints.ifUserExists, documentId: user.uid);
      if (isUserExist) {
        await getUserData(uid: user.uid);
        await saveUserData(user: userEntity);
      } else {
        await addUserData(user: userEntity);
      }
      return Right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImplementation.signInWithGoogle method: ${e.toString()}');
      if (user != null) {
        await _handleSignInFailure(user);
      }
      return Left(ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithFacebook();
      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(
          path: FirebaseEndpoints.ifUserExists, documentId: user.uid);
      if (isUserExist) {
        await getUserData(uid: user.uid);
        await saveUserData(user: userEntity);
      } else {
        await addUserData(user: userEntity);
      }
      return Right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      log('Exception in AuthRepoImplementation.signInWithFacebook method:  ${e.toString()}');
      return Left(ServerFailure('حدث خطاء، يرجى المحاولة مرة اخرى لاحقًا.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithApple();
      var userEntity = UserModel.fromFirebaseUser(user);
      var isUserExist = await databaseService.checkIfDataExists(
          path: FirebaseEndpoints.ifUserExists, documentId: user.uid);
      if (isUserExist) {
        await getUserData(uid: user.uid);
        await saveUserData(user: userEntity);
      } else {
        await addUserData(user: userEntity);
      }
      return Right(userEntity);
    } on CustomException catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (user != null) {
        await _handleSignInFailure(user);
      }
      log('Exception in AuthRepoImplementation.signInWithApple method:  ${e.toString()}');
      return Left(ServerFailure('حدث خطاء، يرجى المحاولة مرة اخرى لاحقًا.'));
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      return await firebaseAuthService.forgetPassword(email: email);
    } on CustomException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      log('Exception in AuthRepoImplementation.forgetPassword method: ${e.toString()}');
      throw ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  @override
  Future addUserData({required UserEntity user}) async {
    try {
      await databaseService.addData(
        path: FirebaseEndpoints.addUserData,
        data: UserModel.fromEntity(user).toMap(),
        documentId: user.uId,
      );
    } on CustomException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      log('Exception in AuthRepoImplementation.addUserData method: ${e.toString()}');
      throw ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    try {
      var userData = await databaseService.getData(
          path: FirebaseEndpoints.getUserData, documentId: uid);

      if (userData == null) {
        log('No user data found for uid: $uid');
        throw CustomException(message: 'لم يتم العثور على بيانات للمستخدم');
      }

      if (userData is Map<String, dynamic>) {
        return UserModel.fromJson(userData);
      } else {
        throw CustomException(message: 'خطأ في تحميل بيانات المستخدم');
      }
    } catch (e) {
      log('Exception in AuthRepoImplementation.getUserData method: ${e.toString()}');
      throw ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  @override
  Future<void> verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuthService.signOut();
    } on CustomException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      log('Exception in AuthRepoImplementation.signOut method:  ${e.toString()}');
      throw ServerFailure('حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
    }
  }

  // Helper method to handle failed sign-in attempts
  Future<void> _handleSignInFailure(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var userData = jsonEncode(UserModel.fromEntity(user).toMap());
    await getIt<CacheHelper>().saveData(key: 'userData', value: userData);
  }
}
