import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:authapp/models/user_model.dart';
import 'package:authapp/ui/components/components.dart';
import 'package:authapp/services/services.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              })
        ],
      ),
      body: LoadingScreen(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 120),
              //Avatar(user),
            ],
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  //_isUserAdmin() async {}
}
