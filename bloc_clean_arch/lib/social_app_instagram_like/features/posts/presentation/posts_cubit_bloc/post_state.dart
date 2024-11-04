/*
  POST STATES
*/

import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/domain/post_entities.dart';

abstract class PostsState {}

//initial
class PostsInitial extends PostsState {}

// loading
class PostsLoading extends PostsState {}

// uploading
class PostsUploading extends PostsState {}

// error
class PostsError extends PostsState {
  final String message;
  PostsError(this.message);
}

// loaded
class PostsLoaded extends PostsState {
  final List<Post> posts;
  PostsLoaded({required this.posts});
}
