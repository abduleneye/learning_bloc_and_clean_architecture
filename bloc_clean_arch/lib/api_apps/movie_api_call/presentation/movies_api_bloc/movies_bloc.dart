import 'package:bloc_clean_arch/api_apps/movie_api_call/domain/movies_api_request_repo.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movies_api_bloc/movies_event.dart';
import 'package:bloc_clean_arch/api_apps/movie_api_call/presentation/movies_api_bloc/movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc(MovieApiServiceRepo moviesRepo) : super(MoviesLoading()) {
    on<LoadMoviesAlbum>(
      (event, emit) async {
        emit(MoviesLoading());
        try {
          final album = await moviesRepo.fetchAlbum();
          if (album != null) {
            emit(MoviesLoaded(movieAlbum: album));
          }
        } catch (e) {
          emit(MoviesLoadedError(errorMessage: e.toString()));
        }
      },
    );
  }
}
