import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/data/firebase_auth_repo.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_states.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/themes/light_mode_theme.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/views/auth_page.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/home/presentation/views/social_home_page.dart';
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

final authRepo = FirebaseAuthRepo();

class SocialApp extends StatefulWidget {
// db injection through the app
  //final TodoRepo todoRepo;
  const SocialApp({
    super.key, //required this.todoRepo
  });

  @override
  State<SocialApp> createState() => _SocialAppState();
}

class _SocialAppState extends State<SocialApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBlocCubits(authRepo: authRepo)..checkAuth(),
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
