/*
SETTINGS PAGE

-Dark Mode
-Blocked users
-Account settings e.t.c
*/

import 'package:bloc_clean_arch/social_app_instagram_like/features/responsive/constraint_scaffold.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/themes/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // theme cubit
    final themeCubit = context.watch<ThemeCubit>();

    // is darkMode
    bool isDarkmode = themeCubit.isDarkMode;
    return ConstrainedScaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          // dark mode tile
          ListTile(
            title: const Text('Dark Mode'),
            trailing: CupertinoSwitch(
                value: isDarkmode,
                onChanged: (value) {
                  themeCubit.toogleTheme();
                }),
          )
        ],
      ),
    );
  }
}
