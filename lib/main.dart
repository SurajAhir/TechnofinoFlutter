
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/conversation/ShowConversations.dart';
import 'package:technofino/ui/HomePage.dart';
import 'package:technofino/ui/login.dart';
import 'package:technofino/ui/splash.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>MyProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        home: const SplashScreen(),
        routes: {
          "/login":(context)=>const Login(),
          "/home":(context)=>const HomePage(),
          "/conversations":(context)=>const ShowConversations(),
        },
      ) ,);
  }
}


