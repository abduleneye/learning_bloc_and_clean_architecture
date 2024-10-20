import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/repository/profile_repo.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBlocCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileBlocCubit({required this.profileRepo}) : super(ProfileInitial());

  // fetch user profile using repo
  Future<void> fecthUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // update bio and or profile picture
  Future<void> updateProfile({
    required String uid,
    String? newBio,
  }) async {
    emit(ProfileLoading());
  }
}
