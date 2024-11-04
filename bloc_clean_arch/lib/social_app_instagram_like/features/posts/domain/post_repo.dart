import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/domain/comment_entities.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/domain/post_entities.dart';

abstract class PostRepo {
  Future<List<Post>> fetchAllPosts();
  Future<void> createPost(Post post);
  Future<void> deletePost(String postId);
  Future<List<Post>> fetchPostByUserId(String userId);
  Future<void> toggleLikePost(String postId, String userId);
  Future<void> addComment(String postId, Comment comment);
  Future<void> deleteComment(String postId, String commentId);
}
