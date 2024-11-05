/*
 This page will diaplay a tab bar to show:
 -List of followers
 -List of following
*/
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_bloc_cubit/profile_bloc_cubit.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_components.dart/followers_user_tile.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowerPage extends StatelessWidget {
  final List<String> followers;
  final List<String> following;
  const FollowerPage({
    super.key,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    // TAB CONTROLLER
    return DefaultTabController(
      length: 2,
      child: ConstrainedScaffold(
        appBar: AppBar(
          bottom: TabBar(
              dividerColor: Colors.transparent,
              labelColor: Theme.of(context).colorScheme.inversePrimary,
              unselectedLabelColor: Theme.of(context).colorScheme.primary,
              tabs: const [
                Tab(
                  text: 'Followers',
                ),
                Tab(
                  text: 'Followers',
                )
              ]),
        ),
        body: TabBarView(
          children: [
            _buildUserList(followers, "No followers", context),
            _buildUserList(following, "No followers", context)
          ],
        ),
      ),
    );
  }

  // build user list, given a list of profile uids
  Widget _buildUserList(
      List<String> uids, String emptyMessage, BuildContext context) {
    return uids.isEmpty
        ? Center(
            child: Text(emptyMessage),
          )
        : ListView.builder(
            itemCount: uids.length,
            itemBuilder: (context, index) {
              // get each uid
              final uid = uids[index];

              return FutureBuilder(
                  future: context.read<ProfileBlocCubit>().getUserProfile(uid),
                  builder: (context, snapshot) {
                    //user loaded
                    if (snapshot.hasData) {
                      final user = snapshot.data!;
                      return FollowersUserTile(user: user);
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const ListTile(title: Text('Loading...'));
                    } else {
                      return const ListTile(
                        title: Text('Users not found'),
                      );
                    }
                  });
            });
  }
}
