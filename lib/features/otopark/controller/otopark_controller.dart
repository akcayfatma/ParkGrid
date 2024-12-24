import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/features/otopark/repository/otopark_repository.dart';
import 'package:firebase_database/firebase_database.dart';

// Controller sınıfı
final otoparkRepositoryProvider = Provider<OtoparkRepository>((ref) {
  return OtoparkRepository(database: FirebaseDatabase.instance);
});

final otoparkControllerProvider = Provider<OtoparkController>((ref) {
  final otoparkRepository = ref.watch(otoparkRepositoryProvider);
  return OtoparkController(otoparkRepository: otoparkRepository);
});

class OtoparkController {
  final OtoparkRepository otoparkRepository;

  OtoparkController({required this.otoparkRepository});

  Future<DataSnapshot> getOtoparkData() async {
    return await otoparkRepository.getOtoparkData();
  }
}