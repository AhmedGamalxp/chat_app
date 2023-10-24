import '../constants.dart';

class MassageModel {
  final String massage;
  final String id;
  MassageModel(this.massage, this.id);

  factory MassageModel.fromJson(jsonData) {
    return MassageModel(jsonData[kMassage], jsonData['id']);
  }
}
