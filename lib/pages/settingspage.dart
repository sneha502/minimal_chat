import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/THEMES/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
     appBar: AppBar(
       title: Text("Settings"),
       backgroundColor: Colors.transparent,
       elevation: 0,
       foregroundColor: Colors.grey,
     ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dark Mode"),

            CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
