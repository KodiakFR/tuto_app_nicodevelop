import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tuto_app_nicodevelop/screens/home_screen.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

// Récupére le fichier de configuration theme
  final themeStr = await rootBundle.loadString('assets/theme.json');
// conversion du fichier en objet
  final themeJson = jsonDecode(themeStr);
  // conversion en theme flutter
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  

  runApp(EasyLocalization (
   
    supportedLocales: const  [Locale('en'), Locale('fr')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
     child:  App(theme: theme),
    
  ),);
}

class App extends StatelessWidget {
  final ThemeData theme;
  const App({
    required this.theme,
    super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Better Devs',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
