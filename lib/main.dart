import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tuto_app_nicodevelop/screens/home_screen.dart';
import 'package:json_theme/json_theme.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  // Récupére le fichier de configuration theme
  final themeStr = await rootBundle.loadString('assets/theme.json');
  // conversion du fichier en objet
  final themeJson = jsonDecode(themeStr);
  // conversion en theme flutter
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  //Initialisation de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //si je suis en mode debeug
  if (kDebugMode) {
    // création d'un host pour la plateform Android ou IOS
    final String host = Platform.isAndroid ? "10.0.2.2" : "localhost";

    //Permet la connection à l'émulateur en local
    await FirebaseAuth.instance.useAuthEmulator(
      host,
      9099,
    );

    FirebaseFirestore.instance.useFirestoreEmulator(
      host,
      8080,
    );

    FirebaseFunctions.instance.useFunctionsEmulator(
      host,
      9199,
    );

    FirebaseFunctions.instance.useFunctionsEmulator(
      host,
      5001,
    );
  }

  //permet d'évité du cache dans le FirebaseFirestore
  await FirebaseFirestore.instance.terminate();
  await FirebaseFirestore.instance.clearPersistence();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: App(
        theme: theme,
        firebaseAuth: FirebaseAuth.instance,
        firebaseFirestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance,
        firebaseFunctions: FirebaseFunctions.instance,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final ThemeData theme;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  final FirebaseFunctions firebaseFunctions;
  const App(
      {required this.theme,
      required this.firebaseAuth,
      required this.firebaseFirestore,
      required this.firebaseFunctions,
      required this.firebaseStorage,
      super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Better Devs',
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
