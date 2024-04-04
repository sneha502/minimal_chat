import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintext;
  final bool obscuretext;
  final TextEditingController controller;
  final FocusNode? focusNode;

   const MyTextField({
     super.key,
     required this.hintext,
     required this.obscuretext,
     required this.controller,
     this.focusNode,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        obscureText: obscuretext,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.tertiary,
          filled: true,
          hintText: hintext,
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
