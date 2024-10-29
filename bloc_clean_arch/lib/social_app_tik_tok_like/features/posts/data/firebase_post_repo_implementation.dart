import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/comment_entities.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_entities.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePostRepoImlementation implements PostRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // store the post in a collection called 'posts'
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection("posts");

  @override
  Future<void> createPost(Post post) async {
    try {
      await postCollection.doc(post.id).set(post.toJson());
    } catch (e) {
      throw Exception('Error occurred creating a post');
    }
  }

  @override
  Future<List<Post>> fetchAllPosts() async {
    try {
      final postsSnapShot = await postCollection.get();
      // This .orderFunction was preventin fecthingPosts: final postsSnapShot = await postCollection.orderBy('timestamp', descending: true).get();

      // print('Returned post ${postsSnapShot.docs.toList()}');
      // print('Returned post ${directPost.docs.toList()}');

      // convert each firestore doc fro json -> list of posts
      final List<Post> allPosts = postsSnapShot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      print('Your returned post $allPosts');

      return allPosts;
    } catch (e) {
      throw Exception('Failed to fetch posts');
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    postCollection.doc(postId).delete();
  }

  @override
  Future<List<Post>> fetchPostByUserId(String userId) async {
    try {
      // fetch posts snapshot with this uid
      final postsSnapshot =
          await postCollection.where('userId', isEqualTo: userId).get();

      // convert firestore documents from json -> lsit of posts
      final userPosts = postsSnapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      return userPosts;
    } catch (e) {
      throw Exception("Error fetching posts by ");
    }
  }

  @override
  Future<void> toggleLikePost(String postId, String userId) async {
    try {
      // get the post doc from firestore
      final postDoc = await postCollection.doc(postId).get();
      if (postDoc.exists) {
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);
        //check if user has already liked this post
        final hasLiked = post.likes.contains(userId);

        //update the likes list
        if (hasLiked) {
          post.likes.remove(userId); // unlike
        } else {
          post.likes.add(userId); // like
        }

        // update the post document with the new like list
        await postCollection.doc(postId).update({'likes': post.likes});
      } else {
        throw Exception('Post not found');
      }
    } catch (e) {
      throw Exception("Error toggling like: $e ");
    }
  }

  @override
  Future<void> addComment(String postId, Comment comment) async {
    try {
      // get post doc
      final postDoc = await postCollection.doc(postId).get();
      if (postDoc.exists) {
        //conv json object to post
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

        //add the new comment
        post.comments.add(comment);

        //update the post doc with the new comment
        await postCollection.doc(postId).update({
          'comments': post.comments.map((comment) => comment.toJson()).toList()
        });
      } else {
        throw Exception('Post not found');
      }
    } catch (e) {
      throw Exception("Error adding comment: $e");
    }
  }

  @override
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      // get post doc
      final postDoc = await postCollection.doc(postId).get();
      if (postDoc.exists) {
        //conv json object to post
        final post = Post.fromJson(postDoc.data() as Map<String, dynamic>);

        //add the new comment
        post.comments.removeWhere((comment) => comment.id == commentId);

        //update the post doc with the new comment
        await postCollection.doc(postId).update({
          'comments': post.comments.map((comment) => comment.toJson()).toList()
        });
      } else {
        throw Exception('Post not found');
      }
    } catch (e) {
      throw Exception("Error deleting comment: $e");
    }
  }
}
