import 'dart:typed_data';

import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/domain/entities/profile_user.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/domain/repository/profile_repo.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_bloc_cubit/profile_state.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/storage/domain/storage_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBlocCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final StorageRepo storageRepo;
  ProfileBlocCubit({required this.profileRepo, required this.storageRepo})
      : super(ProfileInitial());

  // fetch user profile using repo -> useful for loading single profile pages
  Future<void> fetchUserProfile(String uid) async {
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

  // retun  user profile given uid -> useful for loading many profiles for posts
  Future<ProfileUser?> getUserProfile(String uid) async {
    final user = await profileRepo.fetchUserProfile(uid);
    return user;
  }

  // update bio and or profile picture
  Future<void> updateProfile({
    required String uid,
    String? newBio,
    Uint8List? imageWebBytes,
    String? imageMobilePath,
  }) async {
    print(newBio);
    emit(ProfileLoading());

    try {
      // fetch current profile first
      final currentUser = await profileRepo.fetchUserProfile(uid);

      if (currentUser == null) {
        emit(ProfileError('Failed to fetch user for profile update'));
        return;
      }

      // profile picture update
      String? imageDownloadUrl;

      //ensure there is an image
      if (imageWebBytes != null || imageMobilePath != null) {
        //for mobile
        if (imageMobilePath != null) {
          //upload
          imageDownloadUrl =
              await storageRepo.uploadProfileImagesMobile(imageMobilePath, uid);
        }
        // for web
        else if (imageWebBytes != null) {
          //upload
          imageDownloadUrl =
              await storageRepo.uploadProfileImageWeb(imageWebBytes, uid);
        }
      }
      if (imageDownloadUrl == null) {
        emit(ProfileError('failed to upload image'));
      }

      // update new profile
      final updatedProfile = currentUser.copyWith(
        newBio: newBio ?? currentUser.bio,
        newProfileImageUrl: imageDownloadUrl ?? currentUser.profileImageUrl,
      );

      // update in repo
      await profileRepo.updateProfile(updatedProfile);
      print('Updating...');

      //re-fetch the updated profile
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError('Error updating profile: $e'));
      print(e);
    }
  }

  //toggle follow/unfollow
  Future<void> toogleFollow(String currentUid, String targetUid) async {
    try {
      await profileRepo.toogleFollow(currentUid, targetUid);

      await fetchUserProfile(targetUid);
    } catch (e) {
      emit(ProfileError("Erro toggling follow$e"));
    }
  }
}
