import 'dart:convert';

import 'package:bloc_clean_arch/api_apps/movie_api_call/data/local/movies_api_request_repo_implementation.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/domain/movie_entity.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movies_api_bloc/movies_bloc.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movies_api_bloc/movies_event.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movies_api_bloc/movies_state.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  // previous: late Future<http.Response> futureData;
  late Future<MovieAlbum> futureData;
  final movieRepo = MoviesApiRequestRepoImplementation();

  @override
  void initState() {
    //fetchAlbum();
    context.read<MoviesBloc>().add(LoadMoviesAlbum());
    super.initState();
  }

  //Previous without response body model: Future<http.Response> fetchAlbum() async {

  // Future<MovieAlbum> fetchAlbum() async {
  //   //return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  // }

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
        appBar: AppBar(
          title: const Text('Fetching Data'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<MoviesBloc>().add(LoadMoviesAlbum());
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, moviesState) {
          if (moviesState is MoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (moviesState is MoviesLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Movie title: ${moviesState.movieAlbum.title}'),
                  Text('Movie user id: ${moviesState.movieAlbum.userId}'),
                  Text('Movie album id: ${moviesState.movieAlbum.id}'),
                ],
              ),
            );
          } else if (moviesState is MoviesLoadedError) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Center(
                child: Text(moviesState.errorMessage),
              ),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(25.0),
              child: Center(
                child: Text('Unknown error'),
              ),
            );
          }
        }));
  }
}
