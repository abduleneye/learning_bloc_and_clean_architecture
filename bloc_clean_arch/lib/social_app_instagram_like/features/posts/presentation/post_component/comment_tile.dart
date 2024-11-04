import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/domain/comment_entities.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/presentation/posts_cubit_bloc/post_cubit_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentTile extends StatefulWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  //current user
  AppUser? currentUser;
  bool isOwnerpost = false;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthBlocCubits>();
    currentUser = authCubit.currentuser;
    isOwnerpost = (widget.comment.userId == currentUser!.uid);
  }

  // show option for deletion
  void showDeletionDialogBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete Comment'),
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
                    context.read<PostCubitsBloc>().deleteComment(
                          widget.comment.postId,
                          widget.comment.id,
                        );
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          //name
          Text(
            widget.comment.userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(
            width: 10,
          ),

          // comment text
          Text(widget.comment.text),

          const Spacer(),
          //delete button
          if (isOwnerpost)
            GestureDetector(
                onTap: () {
                  showDeletionDialogBox();
                },
                child: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.primary,
                ))
        ],
      ),
    );
  }
}
