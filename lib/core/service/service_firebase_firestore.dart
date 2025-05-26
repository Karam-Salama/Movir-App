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
      log('Exception in FirabaseFirestoreService.addData method: ${e.toString()}');
      if (e.code == 'permission-denied') {
        CustomException(message: 'ليس لديك صلاحيات الوصول');
      } else if (e.code == 'unavailable') {
        CustomException(message: 'خدمة البيانات غير متوفرة. جرب مرة أخرى');
      } else if (e.code == 'deadline-exceeded') {
        CustomException(message: 'تم إنتهاء الوقت المطلوب. جرب مرة اخرى');
      } else if (e.code == 'already-exists') {
        CustomException(message: 'البيانات موجودة بالفعل');
      } else if (e.code == 'invalid-argument') {
        CustomException(message: 'البيانات المرسلة غير صالحة');
      } else if (e.code == 'unauthenticated') {
        CustomException(message: 'ليس لديك صلاحيات الوصول');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'يرجى التحقق من الاتصال بالانترنت.');
      } else {
        throw CustomException(
            message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log('Exception in FirabaseFirestoreService.addData method: ${e.toString()}');
      throw CustomException(message: 'حدث خطأ، يرجى المحاولة مرة أخرى لاحقًا.');
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
          message: 'حدث خطاء، يرجى المحاولة مرة اخرى لاحقًا.');
    }
  }
  
  @override
  Future<bool> checkIfDataExists({required String path, required String documentId}) async{
    try {
      var data = await firestore.collection(path).doc(documentId).get();
      return data.exists;
    } catch (e) {
      log('Exception in FirabaseFirestoreService.checkIfDataExists method: ${e.toString()}');
      throw CustomException(
          message: 'حدث خطاء، يرجى المحاولة مرة اخرى لاحقًا.');
    }
  }
}
