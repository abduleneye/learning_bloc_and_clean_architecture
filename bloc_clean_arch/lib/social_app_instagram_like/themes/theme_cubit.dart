import 'package:bloc_clean_arch/social_app_instagram_like/themes/dark_mode.dart';
import 'package:bloc_clean_arch/social_app_instagram_like/themes/light_mode_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  bool _isDarkMode = false;

  ThemeCubit() : super(lightMode);

  bool get isDarkMode => _isDarkMode;

  void toogleTheme() {
    _isDarkMode = !_isDarkMode;

    if (_isDarkMode) {
      emit(darkMode);
    } else {
      emit(lightMode);
    }
  }
}
