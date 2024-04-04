import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/components/my_text.dart';
import 'package:minimal/components/mybutton.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;

    LoginPage(
    this.onTap,
    );

  void login(BuildContext context) async{
    final authService = AuthServices();

    try{
      await authService.signInWithEmailPassword(
          _emailController.text,
          _pwController.text);
    }
    catch(e)
    {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message,
            size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 50,),
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 25,),

            MyTextField(
                hintext:  "Email",
               obscuretext: false,
              controller: _emailController,

            ),

            SizedBox(height: 10,),

            MyTextField(
              hintext: "Password",
                obscuretext: true,
              controller: _pwController,
            ),

            SizedBox(height: 25,),

            MyButton(
              "Login",
               () => login(context),
            ),

            SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
