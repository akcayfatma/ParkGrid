import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/models/user_model.dart';


final profileRepositoryProvider = Provider((ref) => ProfileRepository(
  auth: FirebaseAuth.instance,
  firebaseFirestore: FirebaseFirestore.instance,));

class ProfileRepository{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  ProfileRepository({
    required this.firebaseFirestore, required this.auth,});

   Future<void> signOut() async {
    await auth.signOut();
  }

  Future<UserModel> getUser() async {
    final user = await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get();
    return UserModel.fromMap(user.data()!);
  }
}
