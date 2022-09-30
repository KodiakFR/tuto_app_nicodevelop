import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.setLocale(const Locale('fr'));

    return Scaffold(
      appBar: AppBar(
        title:  Text(tr('homeScreen.title')),
      ),
      body: Center(
        child: Text(
          tr('homeScreen.text1'),style: Theme.of(context).textTheme.headline1,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.language),
      ),
    );
  }
}
