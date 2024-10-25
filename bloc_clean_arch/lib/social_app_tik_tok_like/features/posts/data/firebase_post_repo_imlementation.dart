import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_entities.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePostRepoImlementation implements PostRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // store the post in a collection called 'posts'
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

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
      // get all post eith the most recent posts at the top
      final postsSnapShot =
          await postCollection.orderBy('timestamp', descending: true).get();

      // convert each firestore doc fro json -> list of posts
      final List<Post> allPosts = postsSnapShot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

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
}
