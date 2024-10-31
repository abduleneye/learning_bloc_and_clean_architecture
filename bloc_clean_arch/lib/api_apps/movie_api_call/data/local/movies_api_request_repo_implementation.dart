import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc_clean_arch/api_apps/movie_api_call/domain/movie_entity.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/domain/movies_api_request_repo.dart';

class MoviesApiRequestRepoImplementation implements MovieApiServiceRepo {
  @override
  Future<MovieAlbum?> fetchAlbum() async {
    final resposne = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

    if (resposne.statusCode == 200) {
      return MovieAlbum.fromJson(
          jsonDecode(resposne.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to load album");
    }
  }
}
