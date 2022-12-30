import 'package:auto_spare_part/data/models/user_model.dart';
import 'package:auto_spare_part/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      userModel = event.first;
    });
    return userModel;
  }
}
