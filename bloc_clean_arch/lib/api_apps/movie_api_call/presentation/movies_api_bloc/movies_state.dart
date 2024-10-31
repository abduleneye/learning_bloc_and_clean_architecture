import 'package:bloc_clean_arch/api_apps/movie_api_call/domain/movie_entity.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final MovieAlbum movieAlbum;
  MoviesLoaded({required this.movieAlbum});
}

class MoviesLoadedError extends MoviesState {
  final String errorMessage;
  MoviesLoadedError({required this.errorMessage});
}
