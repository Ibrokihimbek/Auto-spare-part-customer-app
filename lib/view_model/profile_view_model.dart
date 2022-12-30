import 'package:auto_spare_part/data/app_repositroy/profile_repository.dart';
import 'package:auto_spare_part/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final ProfileRepository _profileRepository;
  ProfileViewModel(
      {required FirebaseAuth firebaseAuth,
      required ProfileRepository profileRepository})
      : _firebaseAuth = firebaseAuth,
        _profileRepository = profileRepository {
    listenUser();
    fetchUser();
  }

  User? user;
  UserModel? userModel;

  fetchUser() async {
    userModel = await _profileRepository.getSingleUser(
        userId: FirebaseAuth.instance.currentUser!.uid);
  }

  Stream<User?> getCurrentUser() => _firebaseAuth.authStateChanges();

  listenUser() {
    _firebaseAuth.authStateChanges().listen((updatedUser) {
      user = updatedUser;
      notifyListeners();
    });
  }
  addUser(UserModel userModel) =>
      _profileRepository.addUser(userModel: userModel);
  setUserName(String userName) async {
    try {
      _firebaseAuth.currentUser!.updateDisplayName(userName);
    } on FirebaseAuthException catch (er) {}
  }

  updatePhoto(String photo) => _firebaseAuth.currentUser!.updatePhotoURL(photo);

  updateFCMToken(String fcmToken, String docId,String userid) =>
      _profileRepository.updateUserFCMToken(fcmToken: fcmToken, docId: docId,userId: userid);
}