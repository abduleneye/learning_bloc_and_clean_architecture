import 'package:bloc_clean_arch/social_app_instagram_like/features/search/domain/search_repo.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/search/presentation/search_bloc_cubit/search_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchBloc({required this.searchRepo}) : super(SearchInitial());
  Future<void> searchUsers(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }
    try {
      emit(SearchLoading());
      final users = await searchRepo.searchusers(query);
      emit(SearchLoaded(users));
    } catch (e) {
      emit(SearchError("Error fetching serach result"));
    }
  }
}
