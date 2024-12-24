import 'package:firebase_database/firebase_database.dart';


class OtoparkRepository {
final FirebaseDatabase database;
  OtoparkRepository({required this.database});
  // Otopark durumunu Firebase'den getirir
  Future<DataSnapshot> getOtoparkData() async {
    final ref = database.ref('otoparklar');
    return await ref.get();
  }
}