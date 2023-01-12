import 'package:auto_spare_part/data/models/info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InfoStoreRepository {
  final FirebaseFirestore _firestore;

  InfoStoreRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Stream<List<InfoModel>> getInfo() =>
      _firestore.collection('infoStore').snapshots().map((event) =>
          event.docs.map((e) => InfoModel.formJson(e.data())).toList());
}
