import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/presentation/post_component/post_tile.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/presentation/posts_cubit_bloc/post_cubit_bloc.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/presentation/posts_cubit_bloc/post_state.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_components.dart/follow_button.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_components.dart/profile_stats.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/views/edit_profile_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_bloc_cubit/profile_bloc_cubit.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_bloc_cubit/profile_state.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_components.dart/bio_box.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/views/follower_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //cubits
  late final authCubit = context.read<AuthBlocCubits>();
  late final profileCubit = context.read<ProfileBlocCubit>();

  // current user
  late AppUser? currentUser = authCubit.currentuser;

  // posts
  int postCount = 0;

  // on startup

  @override
  void initState() {
    profileCubit.fetchUserProfile(widget.uid);

    super.initState();
  }

  void followButtonPressed() {
    final profileState = profileCubit.state;

    if (profileState is! ProfileLoaded) {
      return; // return is profile is not loaded
    }

    final profileUser = profileState.profileUser;
    final isFollowing = profileUser.followers.contains(currentUser!.uid);

    //optimistically update UI
    setState(() {
      //unfollow
      if (isFollowing) {
        profileUser.followers.remove(currentUser!.uid);
      }

      //follow
      else {
        profileUser.followers.add(currentUser!.uid);
      }
    });

    //perform actual toogle in cubit

    profileCubit.toogleFollow(currentUser!.uid, widget.uid).catchError((error) {
      // revert update if there's an error
      setState(() {
        //unfollow
        if (isFollowing) {
          profileUser.followers.add(currentUser!.uid);
        }

        //follow
        else {
          profileUser.followers.remove(currentUser!.uid);
        }
      });
    });
  }

  //BUILD UI

  @override
  Widget build(BuildContext context) {
    //SCAFOLD

    // is own post
    bool isOwnPost = (widget.uid == currentUser!.uid);

    return BlocBuilder<ProfileBlocCubit, ProfileState>(
        builder: (context, profileState) {
      if (profileState is ProfileLoaded) {
        // get loaded user
        final user = profileState.profileUser;
        return ConstrainedScaffold(
          //APP BAR
          appBar: AppBar(
            title: Text(
              user.name,
            ),
            foregroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              //edit profile button
              if (isOwnPost)
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfilePage(
                              user: user,
                            ),
                          ));
                    },
                    icon: const Icon(Icons.settings))
            ],
          ),
          body: ListView(children: [
            //email
            Center(
              child: Text(
                user.email,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            //profile pic
            CachedNetworkImage(
              imageUrl: user.profileImageUrl,
              //loading...
              placeholder: (context, url) {
                return const CircularProgressIndicator();
              },
              // error -> failed to load
              errorWidget: (context, url, error) {
                return Icon(
                  Icons.person,
                  size: 72,
                  color: Theme.of(context).colorScheme.primary,
                );
              },

              //loaded
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      )),
                  clipBehavior: Clip.hardEdge,
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            //bio box
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Text(
                    'Bio',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // profile stats
            ProfileStats(
              postCount: postCount,
              followersCount: user.followers.length,
              followingCount: user.following.length,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FollowerPage(
                              followers: user.followers,
                              following: user.following,
                            )));
              },
            ),

            //follow  button
            if (!isOwnPost)
              FollowButton(
                onPressed: () {
                  followButtonPressed();
                },
                isFollowing: user.followers.contains(currentUser!.uid),
              ),

            //bio box
            BioBox(text: user.bio),

            const SizedBox(
              height: 10,
            ),

            //posts
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Row(
                children: [
                  Text(
                    'Posts',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //lists of post from this user
            BlocBuilder<PostCubitsBloc, PostsState>(
                builder: (context, postState) {
              // posts loaded
              if (postState is PostsLoaded) {
                //filter post by user id
                final userPosts = postState.posts
                    .where((post) => post.userId == widget.uid)
                    .toList();

                postCount = userPosts.length;

                return ListView.builder(
                    itemCount: postCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      //get individual post and
                      final post = userPosts[index];

                      // return it as a post tile UI
                      return PostTile(
                          post: post,
                          onDeletePressed: () {
                            context.read<PostCubitsBloc>().deletePost(post.id);
                          });
                    });
              }
              //post loading...
              else if (postState is PostsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Center(
                  child: Text('This user hasn\'t posted yet'),
                );
              }
            })
          ]),
        );
      } else if (profileState is ProfileLoading) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else {
        return const Center(
          child: Text('No profile found...'),
        );
      }
    });
  }
}
