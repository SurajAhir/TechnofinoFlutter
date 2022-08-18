
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/conversation/ShowConversations.dart';
import 'package:technofino/ui/HomePage.dart';
import 'package:technofino/ui/login.dart';
import 'package:technofino/ui/splash.dart';

import 'dark_them/Styles.dart';
import 'language_change/LocalString.dart';
void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // MyProvider themeChangeProvider = MyProvider();
  @override
  initState(){
    super.initState();
    getLanguage();
    // getCurrentTheme();
  }
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider<MyProvider>(create: (context)=>MyProvider(),
      child: Consumer<MyProvider>(
          builder: (BuildContext context,MyProvider provider,Widget? child){
            return GetMaterialApp(
              translations: LocalString(),
              locale: Locale('en','US'),
              title: 'technofino_community'.tr,
              debugShowCheckedModeBanner: false,
              theme:     Styles.themeData(provider.darkTheme, context),                                /*ThemeData(
                                                        primarySwatch: Colors.blue,
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                      ),*/
              home: const SplashScreen(),
              routes: {
                "/login":(context)=>const Login(),
                "/home":(context)=>const HomePage(),
                "/conversations":(context)=>const ShowConversations(),
              },
            );
          }
      ),);

  }

  void getLanguage()async {
    var prefs=await SharedPreferences.getInstance();
    var language= prefs.getString("language")??"English";
    var local=LocalString.locale[language] as Locale;
    updateLanguage(local);
  }
  updateLanguage(Locale locale){
    debugPrint("local"+locale.toString());
    Get.updateLocale(locale);
  }

// void getCurrentTheme()async {
//   themeChangeProvider.darkTheme =
//       await themeChangeProvider.darkThemePreference.getTheme();
// }
}


