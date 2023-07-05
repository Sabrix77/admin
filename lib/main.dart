import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gobid_admin/provider/auth_provider.dart';
import 'package:gobid_admin/screens/layout/home_layout.dart';
import 'package:gobid_admin/screens/login/login_screen.dart';
import 'package:gobid_admin/screens/support/messages/messages_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (_) => AuthProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeLayout.routeName: (_) => HomeLayout(),
        LoginScreen.routeName: (_) => LoginScreen(),
        MessagesScreen.routeName: (_) => MessagesScreen(),
      },
    );
  }
}
