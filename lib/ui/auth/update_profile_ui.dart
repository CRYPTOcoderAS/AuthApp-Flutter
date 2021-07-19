import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:authapp/models/models.dart';
import 'package:authapp/ui/components/components.dart';
//import 'package:authapp/services/services.dart';

class UpdateProfileUI extends StatefulWidget {
  _UpdateProfileUIState createState() => _UpdateProfileUIState();
}

class _UpdateProfileUIState extends State<UpdateProfileUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //_key: _scaffoldKey,
      appBar: AppBar(title: Text('Update Profile')),
      body: LoadingScreen(
        child: updateProfileForm(context),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  updateProfileForm(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    _name.text = user?.name;
    _email.text = user?.email;
    return Form(
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
                  controller: _name,
                  iconPrefix: Icons.person,
                  labelText: "Name",
                  //validator: Validator,
                  onChanged: (value) => null,
                  onSaved: (value) => _name.text = value,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: _email,
                  iconPrefix: Icons.email,
                  labelText: "email",
                  //validator: Validator,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) => _email.text = value,
                ),
                FormVerticalSpace(),
                PrimaryButton(
                    labelText: "Update",
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        UserModel _updatedUser = UserModel(
                            uid: user?.uid,
                            name: _name.text,
                            email: _email.text,
                            photoUrl: user?.photoUrl);
                        //_updateUserConfirm(context, _updatedUser, user?.email);
                        print(_updatedUser);
                      }
                    }),
                FormVerticalSpace(),
                LabelButton(
                    labelText: "Reset Password",
                    onPressed: () => Navigator.pushNamed(
                        context, '/reset-password',
                        arguments: user.email)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
