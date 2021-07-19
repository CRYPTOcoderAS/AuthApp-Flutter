import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:authapp/ui/components/components.dart';
import 'package:authapp/ui/components/form_input_field_with_icon.dart';
import 'package:authapp/ui/components/label_button.dart';
import 'package:authapp/ui/components/primary_button.dart';

import 'package:authapp/services/services.dart';

class SignInUI extends StatefulWidget {
  _SignInUIState createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LoadingScreen(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    LogoGraphicHeader(),
                    SizedBox(height: 48.0),
                    FormInputFieldWithIcon(
                      controller: _email,
                      iconPrefix: Icons.email,
                      labelText: "EMAIL",
                      //validator: Validator,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) => _email.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _password,
                      iconPrefix: Icons.lock,
                      labelText: "PASSWORD",
                      //validator: Validator,
                      obscureText: true,
                      onChanged: (value) => null,
                      onSaved: (value) => _password.text = value,
                      maxLines: 1,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                      labelText: "Sign In",
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          AuthService _auth = AuthService();
                          bool status = await _auth
                              .signInWithEmailAndPassword(
                                  _email.text, _password.text)
                              .then((status) {
                            setState(() {
                              _loading = false;
                            });
                            return status;
                          });
                          //if (status == false) {
                          //  //
                          //  _scaffoldKey.currentState.showSnackBar(SnackBar(
                          //    content: Text('incorrect'),
                          //  ));
                          //  print("incorrect");
                          //} else {
                          //  print("suppper");
                          //}
                        }
                      },
                    ),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: "Reset Password",
                      onPressed: null,
                    ),
                    LabelButton(
                      labelText: "Sign Up",
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/signup'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
