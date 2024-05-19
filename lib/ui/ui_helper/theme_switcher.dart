import 'package:crypto_app/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    IconData switchIcon = themeProvider.darkMode
        ? CupertinoIcons.sun_max_fill
        : CupertinoIcons.moon_fill;

    return IconButton(onPressed: () {
      themeProvider.toggleTheme();
    }, icon: Icon(switchIcon));
  }
}
