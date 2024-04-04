import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/components/my_text.dart';
import 'package:minimal/components/mybutton.dart';

import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {

  final void Function()? onTap;

  RegisterPage(
      this.onTap,
      );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _cwController = TextEditingController();


  void register(BuildContext context){
    final _auth = AuthServices();

    if(_pwController.text == _cwController.text)
      {
        try{
          _auth.signUpWithEmailPassword(
              _emailController.text,
              _pwController.text
          );
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
    else
      {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Passwords don't match!"),
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
              "Let's create an account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 25,),

            MyTextField(
              hintext: "Email",
              obscuretext: false,
              controller: _emailController,
            ),

            SizedBox(height: 10,),

            MyTextField(
              hintext: "Password",
              obscuretext: true,
              controller: _pwController,
            ),

            SizedBox(height: 10,),

            MyTextField(
              hintext: "Confirm Password",
              obscuretext: true,
              controller: _cwController,
            ),



            SizedBox(height: 25,),

            MyButton(
              "Register",
              () => register(context),
            ),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
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
