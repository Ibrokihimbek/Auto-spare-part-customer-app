import 'dart:async';

import 'package:auto_spare_part/data/models/user_model.dart';
import 'package:auto_spare_part/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;
  ProfileRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  /// Add User
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

  /// Update UserInfo

  Future<void> updateUserInfo({required UserModel userModel}) async {
    try {
      await _firestore
          .collection("users")
          .doc(userModel.docId)
          .update(userModel.toJson());
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }

  /// Update FCM token
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

  Stream<List<UserModel>> getAllUsers(String uid) => _firestore
      .collection('users')
      .where("userId", isEqualTo: uid)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList(),
      );
}
