/*
  Auth States
 */

import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/entities/app_user.dart';

abstract class AuthStates {}

// intial

class AuthInitial extends AuthStates {}

// loading
class AuthLoading extends AuthStates {}

// authenticated
class Authenticated extends AuthStates {
  final AppUser user;
  Authenticated({required this.user});
}

// un-authenticated
class Unauthenticated extends AuthStates {}

// errors...
class AuthErrors extends AuthStates {
  final String message;
  AuthErrors(this.message);
}
