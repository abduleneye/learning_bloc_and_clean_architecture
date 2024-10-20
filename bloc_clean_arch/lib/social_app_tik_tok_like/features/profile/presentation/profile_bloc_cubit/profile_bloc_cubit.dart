import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/repository/profile_repo.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBlocCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileBlocCubit({required this.profileRepo}) : super(ProfileInitial());

  // fetch user profile using repo
  Future<void> fecthUserProfile(String uid) async {
    try {
      print('attempting to fetch user details');
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        print('from else fetch user: user not found');
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      print('Error from fetch user: $e');
      emit(ProfileError(e.toString()));
    }
  }

  // update bio and or profile picture
  Future<void> updateProfile({
    required String uid,
    String? newBio,
  }) async {
    emit(ProfileLoading());

    try {
      // fetch current profile first
      final currentUser = await profileRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError('Failed to fetch user for profile update'));
        return;
      }

      // profile picture update

      // update new profile
      final updatedProfile =
          currentUser.copyWith(newBio: newBio ?? currentUser.bio);

      // update in repo
      await profileRepo.updateProfile(updatedProfile);

      //re-fetch the updated profile
      await profileRepo.fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError('Error updating profile: $e'));
    }
  }
}
