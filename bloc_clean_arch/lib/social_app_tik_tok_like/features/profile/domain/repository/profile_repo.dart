/*
   
   Profile Repo
  
*/

import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/entities/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uid);
  Future<void> updateProfile(ProfileUser updateProfile);
}
