import 'dart:typed_data';

import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_entities.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_repo.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/posts_cubit_bloc/post_state.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/storage/domain/storage_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostCubitsBloc extends Cubit<PostsState> {
  final PostRepo postRepo;
  final StorageRepo storageRepo;
  PostCubitsBloc({
    required this.postRepo,
    required this.storageRepo,
  }) : super(PostsInitial());

  // create a new post
  Future<void> createPost(Post post,
      {String? imagepath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      // handle image upload for mobiel platforms (using file path)
      if (imagepath != null) {
        emit(PostsUploading());
        imageUrl =
            await storageRepo.uploadProfileImagesMobile(imagepath, post.id);
      }

      // handle image uploading for the web
      else if (imageBytes != null) {
        imageUrl = await storageRepo.uploadProfileImageWeb(imageBytes, post.id);
      }

      // give image url to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      // create new post in the backend
      postRepo.createPost(newPost);
    } catch (e) {
      emit(PostsError('An error occured while creating post $e'));
    }
  }

  // fectch all posts
  Future<void> fetchAllPosts() async {
    try {
      emit(PostsLoading());
      final posts = await postRepo.fetchAllPosts();
      emit(PostsLoaded(posts: posts));
    } catch (e) {
      emit(PostsError('Failed to fetch posts: $e'));
    }
  }

  //deleting a post
  Future<void> deletePost(String postId) async {
    try {
      await postRepo.deletePost(postId);
    } catch (e) {
      emit(PostsError('Failed to delete post $e'));
    }
  }

  // fecth specific post by id
  Future<void> fetchPostById(String uId) async {
    try {
      emit(PostsLoading());
      final postByUid = await postRepo.fetchPostByUserId(uId);
      emit(PostsLoaded(posts: postByUid));
    } catch (e) {
      emit(PostsError('Failed to fetch post by uId $e'));
    }
  }
}
