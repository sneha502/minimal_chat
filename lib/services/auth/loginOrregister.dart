import 'package:flutter/material.dart';
import 'package:minimal/pages/loginpage.dart';
import 'package:minimal/pages/registerpage.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({Key? key}) : super(key: key);

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLoginPage = true;

  void togglePages()
  {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage)
      return LoginPage(
        togglePages,
      );
    else
      return RegisterPage(
        togglePages,
      );
  }
}
