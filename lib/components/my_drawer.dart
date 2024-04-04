import 'package:flutter/material.dart';
import 'package:minimal/pages/settingspage.dart';

import '../services/auth/auth_service.dart';


class MyWidget extends StatelessWidget {


  void logout(){
    final _auth = AuthServices();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Center(
                    child: Icon(Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                      size: 40,
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("H O M E"),
                  leading: Icon(Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  } ,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, bottom: 25),
                child: ListTile(
                  title: Text("S E T T I N G S"),
                  leading: Icon(Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()
                        ));
                  } ,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: logout
            ),
          ),
        ],
      ),
    );
  }
}
