import 'dart:io';

import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/domain/entities/app_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/domain/post_entities.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/posts_cubit_bloc/post_cubit_bloc.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/posts/presentation/posts_cubit_bloc/post_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // mobile image pick
  PlatformFile? mobileImagePickedFile;

  // web image pick
  Uint8List? webImage;

  // text controller -> caption
  final captionTextController = TextEditingController();

  // current user
  AppUser? currentUser;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  // get current user
  void getCurrentUser() async {
    final authCubit = context.read<AuthBlocCubits>();
    currentUser = authCubit.currentuser;
  }

  // select image
  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      compressionQuality: 0,
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        mobileImagePickedFile = result.files.first;
        if (kIsWeb) {
          webImage = mobileImagePickedFile!.bytes;
        }
      });
    }
  }

  //create an upload post

  void uploadPost() {
    //check if both image and caption are provided
    if (mobileImagePickedFile == null || captionTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Both image and caption are required')));
      return;
    }

    // create a new post object
    final newPost = Post(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        userId: currentUser!.uid,
        userName: currentUser!.name,
        text: captionTextController.text,
        imageUrl: '',
        timeStamp: DateTime.now(),
        likes: []);

    // post cubit
    final postCubit = context.read<PostCubitsBloc>();

    // web upload
    if (kIsWeb) {
      postCubit.createPost(newPost, imageBytes: mobileImagePickedFile?.bytes);
    } else {
      postCubit.createPost(newPost, imagepath: mobileImagePickedFile?.path);
    }
  }

  @override
  void dispose() {
    captionTextController.dispose();
    super.dispose();
  }

  //Build UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return BlocConsumer<PostCubitsBloc, PostsState>(
        builder: (context, postState) {
      if (postState is PostsLoading || postState is PostsUploading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        // Build Upload page
        return buildUploadPage();
      }
    }, listener: (context, postState) {
      if (postState is PostsLoaded) {
        Navigator.pop(context);
      }
    });
  }

  Widget buildUploadPage() {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: uploadPost,
              icon: const Icon(Icons.upload),
            )
          ],
        ),

        //BODY
        body: Center(
          child: Column(
            children: [
              // image preview for web
              if (kIsWeb && mobileImagePickedFile != null)
                Image.memory(webImage!),

              // image preview for mobile
              if (!kIsWeb && mobileImagePickedFile != null)
                Image.file(File(mobileImagePickedFile!.path!)),

              //pick image button
              MaterialButton(
                onPressed: pickImage,
                color: Colors.blue,
                child: const Text('Pick Image'),
              ),

              //caption Text box
              MyTextFieldSocialApp(
                controller: captionTextController,
                hintText: 'caption',
                obscureText: false,
              ),
            ],
          ),
        ));
  }
}
