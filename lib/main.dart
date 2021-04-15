import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vbee_app/app/pokemon/pokemon_page.dart';
import 'package:vbee_app/base/theme/custom_theme.dart';
import 'app/home/home_page.dart';
import 'locales/i18n.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  //1
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();

    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knight and Day',
      supportedLocales: [
        Locale('vn'),
        Locale('en'),
      ],
      localizationsDelegates: [
        I18n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (locale != null && supportedLocale != null) {
            print(supportedLocale);
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      // home: MyHomePage(title: "hehe",customTheme: currentTheme,),
      theme: CustomTheme.lightTheme,
      //3
      darkTheme: CustomTheme.darkTheme,
      //4
      themeMode: currentTheme.currentTheme,
      //
      routes: {
        // '/': (context) => MyHomePage(
        //       title: I18n.of(context).t("app_name"),
        //       customTheme: currentTheme,
        //     ),
        '/': (context) => PokemonHome("Pokemon List", currentTheme)
      },
    );
  }
}
