import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/language_change/LocalString.dart';

import '../../provider/MyProvider.dart';
class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "language".tr,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Scaffold(
          backgroundColor: Colors.black12,
          body: Container(
            height: 350,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).bottomAppBarColor
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () async{
                      var provider=Provider.of<MyProvider>(context,listen: false);
                      provider.setLanguage("English");
                      var prefs=await SharedPreferences.getInstance();
                      prefs.setString("language", "English");
                      prefs.setBool("isChangedLanguage", true);
                      var local=LocalString.locale["English"] as Locale;
                      updateLanguage(local);
                    },
                    child: ListTile(
                      leading:Provider.of<MyProvider>(context).language=="English"?Icon(Icons.check):SizedBox(),
                      title: Text("English"),
                      subtitle: Text("English"),
                    ),
                  ),
                  InkWell(
                    onTap: () async{
                      var provider=Provider.of<MyProvider>(context,listen: false);
                      provider.setLanguage("Polish");
                      var prefs=await SharedPreferences.getInstance();
                      prefs.setString("language", "Polish");
                      prefs.setBool("isChangedLanguage", true);
                      var local=LocalString.locale["Polish"] as Locale;
                      updateLanguage(local);
                    },
                    child: ListTile(
                      leading: Provider.of<MyProvider>(context).language=="Polish"?Icon(Icons.check):SizedBox(),
                      title: Text("Polish"),
                      subtitle: Text("Polski"),
                    ),
                  ),
                  InkWell(
                    onTap: () async{
                      var provider=Provider.of<MyProvider>(context,listen: false);
                      provider.setLanguage("Vietnamese");
                      var prefs=await SharedPreferences.getInstance();
                      prefs.setString("language", "Vietnamese");
                      prefs.setBool("isChangedLanguage", true);
                      var local=LocalString.locale["Vietnamese"] as Locale;
                      updateLanguage(local);
                    },
                    child: ListTile(
                      leading: Provider.of<MyProvider>(context).language=="Vietnamese"?Icon(Icons.check):SizedBox(),
                      title: Text("Vietnamese"),
                      subtitle: Text("Tiếng Việt"),
                    ),
                  ),
                  InkWell(
                    onTap: () async{
                      var provider=Provider.of<MyProvider>(context,listen: false);
                      provider.setLanguage("Russian");
                      var prefs=await SharedPreferences.getInstance();
                      prefs.setString("language", "Russian");
                      prefs.setBool("isChangedLanguage", true);
                      var local=LocalString.locale["Russian"] as Locale;
                      updateLanguage(local);
                    },
                    child: ListTile(
                      leading: Provider.of<MyProvider>(context).language=="Russian"?Icon(Icons.check):SizedBox(),
                      title: Text("Russian"),
                      subtitle: Text("Русский"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }
}
