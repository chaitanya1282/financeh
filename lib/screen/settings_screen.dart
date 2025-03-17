import 'package:flutter/material.dart';
import '/screen/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(child: Text('U')),
            title: Text('User Name'),
            subtitle: Text('user@example.com'),
            trailing: Icon(Icons.edit),
          ),
          Divider(),
          ListTile(title: Text('Change Password'), onTap: () {}),
          SwitchListTile(
            title: Text('Biometric Login'),
            value: true,
            onChanged: (value) {},
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginScreen())),
          ),
          Divider(),
          ListTile(title: Text('Notifications'), trailing: Icon(Icons.arrow_forward)),
          ListTile(title: Text('Currency'), subtitle: Text('USD')),
          ListTile(title: Text('Theme'), subtitle: Text('Light')),
          Divider(),
          ListTile(title: Text('Privacy Policy')),
          ListTile(title: Text('Terms of Service')),
          Divider(),
          ListTile(title: Text('FAQs')),
          ListTile(title: Text('Contact Support')),
          Divider(),
          ListTile(title: Text('About'), subtitle: Text('Version 1.0.0')),
        ],
      ),
    );
  }
}