import 'package:bloc_clean_arch/social_app_tik_tok_like/features/home/presentation/home_components/social_home_drawer.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/pages/upload_post_page.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/posts_cubit_bloc/post_cubit_bloc.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/posts_cubit_bloc/post_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialHomePage extends StatefulWidget {
  const SocialHomePage({super.key});

  @override
  State<SocialHomePage> createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  //post cubit
  late final postCubit = context.read<PostCubitsBloc>();
  // on start up
  @override
  void initState() {
    fetchAllPosts();
    super.initState();
  }

  // fetch all posts
  void fetchAllPosts() {
    postCubit.fetchAllPosts();
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //APP BAR
        appBar: AppBar(
          title: Text('Home Page'),
          actions: [
            //uppload new post Button
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadPostPage()));
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                fetchAllPosts();
              },
              icon: const Icon(Icons.refresh),
            )
          ],
        ),

        //DRAWER
        drawer: const MySocialDrawer(),
        body: BlocBuilder<PostCubitsBloc, PostsState>(
            builder: (context, postState) {
          print(postState);
          //loading...
          if (postState is PostsLoading && postState is PostsUploading) {
            return const Center(child: CircularProgressIndicator());
          }
          // loaded
          else if (postState is PostsLoaded) {
            print('your posts ${postState.posts} ');
            final allPosts = postState.posts;
            if (allPosts.isEmpty) {
              return const Center(child: Text('No posts available'));
            } else {
              return ListView.builder(
                  itemCount: allPosts.length,
                  itemBuilder: (context, index) {
                    //get individual post from the big list
                    final post = allPosts[index];

                    //image
                    return CachedNetworkImage(
                      imageUrl: post.imageUrl,
                      height: 430,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const SizedBox(
                        height: 430,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );

                    //
                  });
            }
          }

          //error
          else if (postState is PostsError) {
            return Center(
              child: Text(postState.message),
            );
          } else {
            return const SizedBox();
          }
        }));
  }
}
