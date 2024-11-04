import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/data/firebase_auth_repo.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/cubits_bloc/auth_states.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/themes/light_mode_theme.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/auth/presentation/views/auth_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/home/presentation/views/social_home_page.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/data/firebase_post_repo_implementation.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/posts/presentation/posts_cubit_bloc/post_cubit_bloc.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/data/repository/firebase_profile_repo.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/domain/repository/profile_repo.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/profile/presentation/profile_bloc_cubit/profile_bloc_cubit.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/features/storage/data/firebase_storage_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
 SOCIAL APP - Root Level

 Repositories: for the database
 - firebase

 Bloc providers: for state management
 - auth
 - profile
 - post
 - search
 - theme

 Check Auth State
 - unauthenticated -> auth page (login/register)
 - authenticated -> home page
*/

// auth repo
final firebaseAuthRepo = FirebaseAuthRepo();
// profile repo
final firebaseProfileRepo = FirebaseProfileRepo();
//storage repo
final firebaseStorageRepo = FirebaseStorageRepo();

//post repo
final firebasePostRepoImlementation = FirebasePostRepoImlementation();

class SocialApp extends StatefulWidget {
  const SocialApp({
    super.key, //required this.todoRepo
  });

  @override
  State<SocialApp> createState() => _SocialAppState();
}

class _SocialAppState extends State<SocialApp> {
  @override
  Widget build(BuildContext context) {
    // provide cubit or bloc to app
    return MultiBlocProvider(
      providers: [
        //post cubit
        BlocProvider(
            create: (context) => PostCubitsBloc(
                  postRepo: firebasePostRepoImlementation,
                  storageRepo: firebaseStorageRepo,
                )),
        //profile cubit
        BlocProvider(
            create: (context) => ProfileBlocCubit(
                profileRepo: firebaseProfileRepo,
                storageRepo: firebaseStorageRepo)),

        //auth cubit
        BlocProvider(
            create: (context) =>
                AuthBlocCubits(authRepo: firebaseAuthRepo)..checkAuth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        // home: BlocProvider<QuizBloc>(
        //   create: (context) => QuizBloc(),
        //   child: const QuizHomeScreen(),
        // ),
        home: BlocConsumer<AuthBlocCubits, AuthStates>(
            builder: (context, authState) {
          print(authState);
          // unauthenticated -> auth page (login/register)
          if (authState is Unauthenticated) {
            return const AuthPage();
          }
          // authenticated -> home page
          if (authState is Authenticated) {
            return const SocialHomePage();
          }

          // loading...
          else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }, listener: (context, authStates) {
          if (authStates is AuthErrors) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(authStates.message)));

            print('from listener: ' + authStates.message);
          }
        }),
      ),
    );
  }
}
