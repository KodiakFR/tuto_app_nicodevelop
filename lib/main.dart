import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tuto_app_nicodevelop/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  

  runApp(EasyLocalization (
   
    supportedLocales: const  [Locale('en'), Locale('fr')],
    path: 'assets/translations',
    fallbackLocale: const Locale('en'),
     child: const App(),
    
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Better Devs',
      home: const HomeScreen(),
    );
  }
}
