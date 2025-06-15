import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../errors/exceptions.dart';
import 'database_service.dart';

class FirabaseFirestoreService implements DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<void> addData(
      {required String path,
      required Map<String, dynamic> data,
      String? documentId}) async {
    try {
      if (documentId != null) {
        await firestore.collection(path).doc(documentId).set(data);
      } else {
        await firestore.collection(path).add(data);
      }
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseFirestoreService.addData: ${e.toString()}');
      if (e.code == 'permission-denied') {
        throw CustomException(
            message: 'You do not have permission to access this resource.');
      } else if (e.code == 'unavailable') {
        throw CustomException(
            message:
                'The service is currently unavailable. Please try again later.');
      } else if (e.code == 'deadline-exceeded') {
        throw CustomException(
            message: 'The operation timed out. Please try again.');
      } else if (e.code == 'already-exists') {
        throw CustomException(message: 'The data already exists.');
      } else if (e.code == 'invalid-argument') {
        throw CustomException(message: 'Invalid data provided.');
      } else if (e.code == 'unauthenticated') {
        throw CustomException(
            message: 'You need to be authenticated to access this resource.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Network error. Please check your internet connection.');
      } else {
        throw CustomException(
            message: 'An unexpected error occurred. Please try again later.');
      }
    } catch (e) {
      log('Exception in FirabaseFirestoreService.addData method: ${e.toString()}');
      throw CustomException(
          message: 'Failed to add data. Please try again later.');
    }
  }

  @override
  Future<Map<String, dynamic>> getData(
      {required String path, required String documentId}) async {
    try {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.data() as Map<String, dynamic>;
    } catch (e) {
      log('Exception in FirabaseFirestoreService.getUserData method: ${e.toString()}');
      throw CustomException(
          message: 'Failed to add data. Please try again later.');
    }
  }

  Future<void> deleteData(
      {required String path, required String documentId}) async {
    try {
      await firestore.collection(path).doc(documentId).delete();
    } catch (e) {
      log('Exception in FirabaseFirestoreService.deleteData method: ${e.toString()}');
      throw CustomException(
          message: 'Failed to add data. Please try again later.');
    }
  }

  @override
  Future<bool> checkIfDataExists(
      {required String path, required String documentId}) async {
    try {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.exists;
    } catch (e) {
      log('Exception in FirabaseFirestoreService.checkIfDataExists method: ${e.toString()}');
      throw CustomException(
          message: 'Failed to add data. Please try again later.');
    }
  }
}
