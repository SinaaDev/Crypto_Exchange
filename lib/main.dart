import 'package:crypto_app/provider/MarketViewProvider.dart';
import 'package:crypto_app/provider/UserDataProvider.dart';
import 'package:crypto_app/provider/crypto_data_provider.dart';
import 'package:crypto_app/provider/theme_provider.dart';
import 'package:crypto_app/ui/main_wrapper.dart';
import 'package:crypto_app/ui/sign_up_screen.dart';
import 'package:crypto_app/ui/ui_helper/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (ctx) => ThemeProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => CryptoDataProvider(),
    ),ChangeNotifierProvider(
      create: (ctx) => MarketViewProvider(),
    ),ChangeNotifierProvider(
      create: (ctx) => UserDataProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('fa'), // Spanish
        ],
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        debugShowCheckedModeBanner: false,
        home: MainWrapper());
  }
}
