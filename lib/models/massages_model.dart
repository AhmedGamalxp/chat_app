import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class MassageModel {
  final String massage;
  final String id;
  final Timestamp sentAt;
  MassageModel(this.massage, this.id, this.sentAt);

  factory MassageModel.fromJson(jsonData) {
    return MassageModel(jsonData[kMassage], jsonData['id'], jsonData['sentAt']);
  }
}
