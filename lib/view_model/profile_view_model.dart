import 'package:auto_spare_part/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;

  ProfileViewModel({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  UserModel? userModel;

  fetchProfileData() {
    userModel = UserModel(
      age: 0,
      userId: _firebaseAuth.currentUser!.uid,
      fullName: _firebaseAuth.currentUser!.displayName ?? "",
      email: _firebaseAuth.currentUser!.email ?? "",
      createdAt: DateTime.now().toString(),
    );
  }

  setUserName(String userName) async {
    try {
      _firebaseAuth.currentUser!.updateDisplayName(userName);
    } on FirebaseAuthException catch (er) {}
  }
}
