import 'package:bloc_clean_arch/social_app_tik_tok_like/features/post/presentation/post_components/social_drawer_tile.dart';
import 'package:flutter/material.dart';

class MySocialDrawer extends StatelessWidget {
  const MySocialDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              //logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              //divider line
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),

              // home tile
              SocialDrawerTile(
                title: 'H O M E',
                icon: Icons.home,
                onTap: () {},
              ),

              // search tile
              SocialDrawerTile(
                title: 'P R O F I L E',
                icon: Icons.person,
                onTap: () {},
              ),

              // settings tile
              SocialDrawerTile(
                title: 'S E A R C H',
                icon: Icons.search,
                onTap: () {},
              ),

              const Spacer(),

              // logout tile
              SocialDrawerTile(
                title: 'L O G O U T',
                icon: Icons.login,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
