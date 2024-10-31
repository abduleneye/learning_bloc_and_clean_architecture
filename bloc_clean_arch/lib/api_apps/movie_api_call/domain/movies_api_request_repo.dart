import 'package:bloc_clean_arch/api_apps/movie_api_call/domain/movie_entity.dart';

abstract class MovieApiServiceRepo {
  Future<MovieAlbum?> fetchAlbum();
}
