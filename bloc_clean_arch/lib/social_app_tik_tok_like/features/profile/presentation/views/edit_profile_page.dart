import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/components/my_text_field_social_app.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/domain/entities/profile_user.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_bloc_cubit.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/profile/presentation/profile_bloc_cubit/profile_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // mobile image picker
  PlatformFile? imagePickedFile;

  //web image pick
  Uint8List? webImage;

  final bioTextController = TextEditingController();

  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;
        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  //update profile button pressed
  void updateProfile() async {
    // profile cubit_bloc
    final updateprofile = context.read<ProfileBlocCubit>();

    //prepare images and data
    final String uid = widget.user.uid;
    final String? newBio =
        bioTextController.text.isNotEmpty ? bioTextController.text : null;
    final imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    final imageWebBytes = kIsWeb ? imagePickedFile?.bytes : null;

    // only update profile if there is something to update
    if (imagePickedFile != null || newBio != null) {
      updateprofile.updateProfile(
          uid: widget.user.uid,
          newBio: bioTextController.text,
          imageMobilePath: imageMobilePath,
          imageWebBytes: imageWebBytes);
    }
    // nothing to update -> go to previous page
    else {
      Navigator.pop(context);
    }
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return BlocConsumer<ProfileBlocCubit, ProfileState>(
      builder: (context, profileState) {
        //profile loading
        if (profileState is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Updating profile...')
                ],
              ),
            ),
          );
        }
        //profile error
        //profile loaded
        //kiss
        else {
          return buildEditPage();
        }
      },
      listener: (context, profileState) {
        print(profileState);
        if (profileState is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // save button
          IconButton(
              onPressed: () {
                updateProfile();
              },
              icon: const Icon(Icons.upload))
        ],
      ),
      body: Column(
        children: [
          // profile picture
          Center(
              child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle),
            child:
                // display selected image for mobile
                (!kIsWeb && imagePickedFile != null)
                    ? Image.file(
                        File(imagePickedFile!.path!),
                      )
                    :
                    //display selected image for web
                    (kIsWeb && webImage != null)
                        ? Image.memory(webImage!)
                        :
                        // no image selected -> display existing profile pic
                        CachedNetworkImage(
                            imageUrl: widget.user.profileImageUrl,
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
                              return Image(image: imageProvider);
                            },
                          ),
          )),
          const SizedBox(
            height: 10,
          ),

          // pick image button
          Center(
            child: MaterialButton(
              onPressed: () {
                pickImage();
              },
              color: Colors.blue,
              child: const Text('Pick Image'),
            ),
          ),

          //bio
          const Text('bio'),

          const SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextFieldSocialApp(
              controller: bioTextController,
              hintText: 'Write something',
              obscureText: false,
            ),
          ),
        ],
      ),
    );
  }
}
