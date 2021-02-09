import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moonlight/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'screens/home.dart';
import 'screens/settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      var darkModeOn = prefs.getBool('darkMode') ?? true;
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
          child: MyApp(),
        ),
      );
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.getTheme(),
      home: HomePage(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        SettingsPage.routeName: (context) => SettingsPage()
      },
    );
  }
}
