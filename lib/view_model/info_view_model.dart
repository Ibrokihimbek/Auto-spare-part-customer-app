import 'dart:async';

import 'package:auto_spare_part/data/app_repositroy/info_repository.dart';
import 'package:auto_spare_part/data/models/info_model.dart';
import 'package:flutter/cupertino.dart';

class InfoViewModel extends ChangeNotifier {
  final InfoStoreRepository infoStoreRepository;
  InfoViewModel({required this.infoStoreRepository}) {
    listenInfoStore();
  }

  late StreamSubscription subscription;

  List<InfoModel> information = [];

  listenInfoStore() async {
    subscription = infoStoreRepository.getInfo().listen((event) {
      if (event.isNotEmpty) {
        information = event;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}
