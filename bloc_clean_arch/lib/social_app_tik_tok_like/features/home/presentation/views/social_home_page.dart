import 'package:bloc_clean_arch/social_app_tik_tok_like/features/auth/presentation/cubits_bloc/auth_bloc_cubits.dart';
import 'package:bloc_clean_arch/social_app_tik_tok_like/features/home/presentation/home_components/social_home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialHomePage extends StatefulWidget {
  const SocialHomePage({super.key});

  @override
  State<SocialHomePage> createState() => _SocialHomePageState();
}

class _SocialHomePageState extends State<SocialHomePage> {
  //BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //APP BAR
        appBar: AppBar(
          title: Text('Home Page'),
        ),

        //DRAWER
        drawer: const MySocialDrawer());
  }
}
