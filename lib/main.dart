import 'package:flutter/material.dart';
import 'package:minimal/THEMES/theme_provider.dart';
import 'package:minimal/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:minimal/services/auth/auth_gate.dart';
import 'package:provider/provider.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
     ChangeNotifierProvider(create: (context) => ThemeProvider(),
       child: MyApp(),
     ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
