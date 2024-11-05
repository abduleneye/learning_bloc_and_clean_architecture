import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/domain/entities/profile_user.dart';

abstract class SearchRepo {
  Future<List<ProfileUser?>> searchusers(String query);
}
