import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final temaBilesenleriFSRepositoryProvider = Provider((ref) =>
    temaBilesenleriFirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

class temaBilesenleriFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  temaBilesenleriFirebaseStorageRepository({required this.firebaseStorage});

  Future<String> storeFileToFirebase(String ref, File file) async {
    final storageRef = firebaseStorage.ref(ref);
    final uploadTask = storageRef.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}