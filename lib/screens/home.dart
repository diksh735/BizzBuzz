import 'package:flutter/material.dart';
import 'settings.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          Navigator.pushNamed(context, SettingsPage.routeName);
        },
      ),
    );
  }
}
