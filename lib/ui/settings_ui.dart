import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:authapp/models/models.dart';
import 'package:authapp/ui/components/components.dart';
import 'package:authapp/services/services.dart';

class SettingsUI extends StatelessWidget {
  String systemValue = "system";
  String lightValue = "light";
  String darkValue = "dark";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Settings"),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: systemValue, icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light", value: lightValue, icon: Icons.brightness_low),
      MenuOptionsModel(key: "dark", value: darkValue, icon: Icons.brightness_3)
    ];
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("Theme"),
          trailing: SegmentedSelector(
            selectedOption: Provider.of<ThemeProvider>(context).getTheme,
            menuOptions: themeOptions,
            onValueChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(value);
            },
          ),
        ),
        ListTile(
            title: Text("Update Profile"),
            trailing: RaisedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/update-profile');
              },
              child: Text(
                "Update",
              ),
            )),
        ListTile(
            title: Text("Sign Out"),
            trailing: RaisedButton(
              onPressed: () {
                AuthService _auth = AuthService();
                _auth.signOut();
                Navigator.of(context).pushNamed('/signin');
                //Navigator.pushReplacementNamed(context, '/signin');
              },
              child: Text("Sign Out"),
            ))

        /*  ListTile(
          title: Text(labels.settings.theme),
          trailing: DropdownPickerWithIcon(
            menuOptions: themeOptions,
            selectedOption: Provider.of<ThemeProvider>(context).getTheme,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(value);
            },
          ),
        ),*/
        /*    
        ListTile(
          title: Text(labels.settings.theme),
          trailing: CupertinoSlidingSegmentedControl(
            groupValue: Provider.of<ThemeProvider>(context).getTheme,
            children: myTabs,
            onValueChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(value);
            },
          ),
        ),*/
      ],
    );
  }
}
