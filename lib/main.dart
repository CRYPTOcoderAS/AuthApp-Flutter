import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:authapp/models/user_model.dart';
import 'package:authapp/ui/auth/auth.dart';
import 'package:authapp/ui/ui.dart';
import 'package:authapp/services/services.dart';
import 'package:authapp/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
      ),
      ChangeNotifierProvider<AuthService>(
        create: (context) => AuthService(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        return AuthWidgetBuilder(
          builder: (BuildContext context, AsyncSnapshot<User> userSnapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: Routes.routes,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeProviderRef.isDarkModeOn
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: (userSnapshot?.data?.uid != null) ? HomeUI() : SignInUI(),
            );
          },
        );
      },
    );
  }
}
