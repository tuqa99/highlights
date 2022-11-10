import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'Widget/icon_widget.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  static const KeyLocation = 'key-Location';
  static const Keypassword = 'key-password';
  static const keyAbout = 'key-About';
  Widget build(BuildContext context) {
    return SimpleSettingsTile(
      leading: IconWidget(
        icon: Icons.person,
        color: Colors.black,
      ),
      title: 'Account settings',
      child: SettingsScreen(
        title: 'Account Settings',
        children: <Widget>[buildLocation(), buildAbout(), buildpassword()],
      ),
      subtitle: '',
      onTap: () {},
    );
  }

  Widget buildAccountInfo() => SimpleSettingsTile(
        leading: IconWidget(
          icon: Icons.person,
          color: Colors.green,
        ),
        title: 'Account settings',
        child: Container(),
        subtitle: '',
        onTap: () {},
      );

  Widget buildLocation() => DropDownSettingsTile(
        title: 'Location',
        settingKey: KeyLocation,
        selected: 1,
        values: <int, String>{
          1: "Amman",
          2: "Irbid",
          3: "Aqaba",
          4: "Jarash",
          5: "Al-Zarqaa",
        },
        onChange: (location) {/*NOOP */},
      );
  Widget buildAbout() => TextInputSettingsTile(
        settingKey: keyAbout,
        title: 'About Section',
        initialValue: "Enter an about section",
        onChange: (About) {},
      );

  Widget buildpassword() => TextInputSettingsTile(
        settingKey: Keypassword,
        title: 'Change Password',
        obscureText: true,
        validator: (password) => password != null && password.length >= 6
            ? null
            : 'Enter more than 6 characters',
        onChange: (About) {},
      );
}
