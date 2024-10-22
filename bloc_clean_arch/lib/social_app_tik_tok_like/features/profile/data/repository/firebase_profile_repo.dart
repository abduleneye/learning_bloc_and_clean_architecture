import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/entities/profile_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/repository/profile_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      //get user doc from firestore
      final userDoc =
          await firebaseFirestore.collection("users").doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData['email'],
            name: userData['name'],
            bio: userData['bio'] ?? "",
            profileImageUrl: userData['profileImageUrl'].toString(),
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfile) async {
    print('bio from repo: ${updatedProfile.bio}');
    try {
      // convert updated profile to json to store in  firestore
      print('attempting to update profile from repo impl');

      await firebaseFirestore
          .collection('users')
          .doc(updatedProfile.uid)
          .update({
        'bio': updatedProfile.bio,
        'profileImageUrl': updatedProfile.profileImageUrl
      });
    } catch (e) {
      print('error updating profile from repo impl$e');
      throw Exception(e);
    }
  }
}
