import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:authapp/models/models.dart';
import 'package:authapp/services/services.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<User>(
        stream: authService.userStatus,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          final User user = snapshot.data;
          if (user != null) {
            MultiProvider(
              providers: [
                Provider<User>.value(value: user),
                StreamProvider<UserModel>.value(
                    value: AuthService().streamFirestoreUser(user),
                    initialData: null)
              ],
            );
          }
          return builder(context, snapshot);
        });
  }
}
