import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/comment_entities.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_entities.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/post_component/comment_tile.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/posts_cubit_bloc/post_cubit_bloc.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/posts_cubit_bloc/post_state.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/entities/profile_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_bloc_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? onDeletePressed;

  const PostTile(
      {super.key, required this.post, required this.onDeletePressed});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  //cubits
  late final postcubit = context.read<PostCubitsBloc>();
  late final profilecubit = context.read<ProfileBlocCubit>();

  bool isOwnPost = false;

  //current user
  AppUser? currentUser;

  // post user
  ProfileUser? postUser;

  @override
  void initState() {
    getCurrentUser();
    fetchPostUser();
    super.initState();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthBlocCubits>();
    currentUser = authCubit.currentuser;
    isOwnPost = (widget.post.userId == currentUser!.uid);
  }

  void fetchPostUser() async {
    final fetchUser = await profilecubit.getUserProfile(widget.post.userId);
    if (fetchUser != null) {
      setState(() {
        postUser = fetchUser;
      });
    }
  }
  /*

      LIKES
   
   */

  void toggleLikPost() {
    // current like status
    final isLiked = widget.post.likes.contains(currentUser!.uid);
    //optimistically like and update UI
    setState(() {
      if (isLiked) {
        widget.post.likes.remove(currentUser!.uid); // unlike
      } else {
        widget.post.likes.add(currentUser!.uid); // like
      }
    });

    //update like
    postcubit
        .toggleLikePost(
      widget.post.id,
      currentUser!.uid,
    )
        .catchError((error) {
      // if there is an error, we revert back to the original value
      setState(() {
        if (isLiked) {
          widget.post.likes.add(currentUser!.uid); // revert unlike
        } else {
          widget.post.likes.remove(currentUser!.uid); // revert like
        }
      });
    });
  }

  /*
     COMMENTS
 */
  //comment textController
  final commentTextController = TextEditingController();

  //open comment box -> user wants to type a new comment
  void openNewCommentBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: MyTextFieldSocialApp(
                controller: commentTextController,
                hintText: 'Add a comment',
                obscureText: false,
              ),
              actions: [
                // cancel button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),

                //save comment button
                TextButton(
                  onPressed: () {
                    addComment();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(),
                  ),
                )
              ],
            ));
  }

  //add comment
  void addComment() {
    // create new comment
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: widget.post.id,
      userId: currentUser!.uid,
      userName: currentUser!.name,
      text: commentTextController.text,
      timeStamp: DateTime.now(),
    );

    // add comment using cubit
    if (commentTextController.text.isNotEmpty) {
      postcubit.addComment(
        widget.post.id,
        newComment,
      );
    }
  }

  @override
  void dispose() {
    commentTextController.dispose();
    super.dispose();
  }

  // show option for deletion
  void showDeletionDialogBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('DeletePost'),
              actions: [
                // cancel button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),

                //delete button
                TextButton(
                  onPressed: () {
                    widget.onDeletePressed!();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(children: [
        // Top section: profile pic / name / delete button
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            // profile pic
            postUser?.profileImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: postUser!.profileImageUrl,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person),
                    imageBuilder: (context, imageProvider) => Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              )),
                        ))
                : const Icon(Icons.person),

            const SizedBox(
              width: 10,
            ),

            //name
            Text(widget.post.userName),

            const Spacer(),

            //delete button
            if (isOwnPost)
              GestureDetector(
                onTap: showDeletionDialogBox,
                child: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
          ]),
        ),

        // Image
        CachedNetworkImage(
          imageUrl: widget.post.imageUrl,
          height: 430,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const SizedBox(
            height: 430,
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),

        // buttons -> like, comment, timestamps
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // like button
              SizedBox(
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: toggleLikPost,
                        child: Icon(
                          widget.post.likes.contains(currentUser!.uid)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: widget.post.likes.contains(currentUser!.uid)
                              ? Colors.red
                              : Theme.of(context).colorScheme.primary,
                        )),

                    const SizedBox(
                      width: 5,
                    ),

                    // Like count
                    Text(
                      widget.post.likes.length.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              //comment button
              GestureDetector(
                onTap: () {
                  openNewCommentBox();
                },
                child: Icon(
                  Icons.comment,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              const SizedBox(
                width: 5,
              ),

              Text(
                widget.post.comments.length.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 12,
                ),
              ),

              //timestamp
              Text(widget.post.timeStamp.toString())
            ],
          ),
        ),
        //Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              // user name
              Text(
                widget.post.userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                width: 10,
              ),

              //text
              Text(widget.post.text)
            ],
          ),
        ),
        //comment section
        BlocBuilder<PostCubitsBloc, PostsState>(builder: (context, postState) {
          //LOADED
          if (postState is PostsLoaded) {
            //final individual post
            final post = postState.posts
                .firstWhere((post) => (post.id == widget.post.id));

            if (post.comments.isNotEmpty) {
              // how many comments to show
              int showCommentsCount = post.comments.length;

              //comment section
              return ListView.builder(
                itemCount: showCommentsCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // get individual comment
                  final comment = post.comments[index];

                  //comment tile UI
                  return CommentTile(comment: comment);
                },
              );
            }
          }
          //LOADING
          if (postState is PostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (postState is PostsError) {
            return Center(
              child: Text(postState.message),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        })
      ]),
    );
  }
}
