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
    _profileRepository
        .getAllUsers(_firebaseAuth.currentUser!.uid)
        .listen((users) {
      if (users.isNotEmpty) {
        userModel = users.first;
        notifyListeners();
      }
    });
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

  updateUser(UserModel userModel) =>
      _profileRepository.updateUserInfo(userModel: userModel);
  
  updateFCMToken(String fcmToken, String docId, String userid) =>
      _profileRepository.updateUserFCMToken(
          fcmToken: fcmToken, docId: docId, userId: userid);
}
