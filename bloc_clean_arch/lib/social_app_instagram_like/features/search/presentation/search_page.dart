import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_components.dart/followers_user_tile.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/search/presentation/search_bloc_cubit/search_bloc.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/search/presentation/search_bloc_cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchFieldTextController =
      TextEditingController();
  late final searchCubit = context.read<SearchBloc>();

  void onSeacrhFieldchanged() {
    final query = searchFieldTextController.text;
    searchCubit.searchUsers(query);
  }

  @override
  void dispose() {
    super.dispose();
    searchFieldTextController.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchFieldTextController.addListener(onSeacrhFieldchanged);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedScaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchFieldTextController,
          decoration: InputDecoration(
            hintText: "Search user",
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
      body:
          BlocBuilder<SearchBloc, SearchState>(builder: (context, searchState) {
        // loaded
        if (searchState is SearchLoaded) {
          if (searchState.users.isEmpty) {
            return const Center(
              child: Text('No user found'),
            );
          }
          // users...
          return ListView.builder(
              itemCount: searchState.users.length,
              itemBuilder: (context, index) {
                final user = searchState.users[index];
                return FollowersUserTile(
                  user: user!,
                );
              });
        } else if (searchState is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (searchState is SearchError) {
          return Center(
            child: Text(searchState.message),
          );
        }

        //default
        return const Center(
          child: Text("Start searching for users..."),
        );
      }),
    );
  }
}
