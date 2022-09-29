import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    context.setLocale(Locale('fr'));
    print('langue: ' + context.locale.toString());

    return Scaffold(body: Center(child: Text(tr('homeScreen.text1'))),);
  }
}