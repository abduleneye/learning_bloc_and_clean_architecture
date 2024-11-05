import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/domain/entities/profile_user.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/search/domain/search_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseSearchRepoImplementation implements SearchRepo {
  @override
  Future<List<ProfileUser?>> searchusers(String query) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return result.docs
          .map((doc) => ProfileUser.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error searching users: $e');
    }
  }
}
