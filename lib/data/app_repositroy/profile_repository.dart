import 'dart:async';

import 'package:auto_spare_part/data/models/user_model.dart';
import 'package:auto_spare_part/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;
  ProfileRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addUser({required UserModel userModel}) async {
    try {
      DocumentReference newUser =
          await _firestore.collection("users").add(userModel.toJson());
      await _firestore
          .collection("users")
          .doc(newUser.id)
          .update({"docId": newUser.id});
      getMyToast(message: "User muvaffaqiyatli qo'shildi!");
    } on FirebaseException catch (er) {
      getMyToast(message: er.message.toString());
    }
  }

  Future<void> updateUserName({
    required String fullName,
    required String docId,
  }) async {
    try {
      await _firestore.collection('users').doc(docId).update({
        "fullName": fullName,
      });
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  Future<void> updateUserPhoto({
    required String imageUrl,
    required String docId,
  }) async {
    try {
      await _firestore.collection('users').doc(docId).update({
        "imageUrl": imageUrl,
      });
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  Future<void> updateUserFCMToken(
      {required String fcmToken,
      required String docId,
      required String userId}) async {
    try {
      await _firestore.collection("users").doc(docId).update({
        "fcm_token": fcmToken,
        "userId": userId,
      });
    } on FirebaseException catch (er) {
      getMyToast(message: er.message.toString());
    }
  }

  Future<UserModel?> getSingleUser({required String userId}) async {
    UserModel? userModel;
    _firestore
        .collection("users")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map(
          (event1) =>
              event1.docs.map((doc) => UserModel.fromJson(doc.data())).toList(),
        )
        .listen((event) {

      print("USER INFOOOO: ${event.first}");

      userModel = event.first;

      print("USER INFOOOO TWO: $userModel");

    });

    print("USER INFOOOO THREE: $userModel");
    
    return userModel;
  }
}
