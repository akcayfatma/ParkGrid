import 'package:parkgrid_y/features/profile/repository/profile_repository.dart';
import 'package:parkgrid_y/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


  final profileControllerProvider = Provider((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileController(profileRepository: profileRepository, ref: ref);
});

class ProfileController{
  final ProfileRepository profileRepository;
  final ProviderRef ref;

 ProfileController({required this.profileRepository, required this.ref});

  Future<UserModel> getUser() async {
    return await profileRepository.getUser();
  }


  Future<void> signOut() async {
      await profileRepository.signOut();
    }


  Future<void> updateProfile(UserModel model) async {
    await profileRepository.updateProfile(model);
    ref.refresh(profileControllerProvider).getUser();
  }


}