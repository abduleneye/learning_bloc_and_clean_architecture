import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/repository/auth_repo.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*

  Auth Bloc Cubits

 */

class AuthBlocCubits extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;
  AuthBlocCubits({required this.authRepo}) : super(AuthInitial());

  // check if user is already authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }

  // get current user???
  AppUser? get currentuser => _currentUser;
  // login ith email + pw
  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailAndPassword(
        email,
        password,
      );

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthErrors(e.toString()));
    }
  }

  // register with email + pw
  Future<void> register(String email, String password, String name) async {
    try {
      emit(AuthLoading());
      final user =
          await authRepo.registerWithEmailAndPassword(email, password, name);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthErrors(e.toString()));
    }
  }

  // logout
  Future<void> logout() async {
    authRepo.logout();
    emit(Unauthenticated());
  }
}
