import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/repository/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  @override
  Future<AppUser?> loginWithEmailAndPassword(
      String email, String password) async {
    //Attempt sign in
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: '',
      );

      // return user
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    //Attempt registering user
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // save user data in firestore
      await firebaseFireStore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      // return user
      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // get current logged in user fomr firebase
    final fireBaseUser = firebaseAuth.currentUser;

    //No user logged in
    if (fireBaseUser == null) {
      return null;
    }

    //user exists
    return AppUser(
      uid: fireBaseUser.uid,
      email: fireBaseUser.email!,
      name: '',
    );
  }
}
