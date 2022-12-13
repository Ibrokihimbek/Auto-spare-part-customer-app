import 'package:auto_spare_part/data/models/user_model.dart';
import 'package:auto_spare_part/widgets/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addUser({required UserModel userModel}) async {
    try {
      await _firestore.collection("users").add(userModel.toJson());
      getMyToast(message: "User muvaffaqiyatli qo'shildi!");
    } on FirebaseException catch (e) {
      getMyToast(message: e.message.toString());
    }
  }
}
