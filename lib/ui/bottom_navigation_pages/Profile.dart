import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/ui/MyWebView.dart';
import 'package:technofino/ui/conversation/ShowConversations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../display_related_classes/ChangeAppThem.dart';
import '../display_related_classes/ChangeLanguage.dart';
import '../user_profile/ChangeUsername.dart';
import '../user_profile/UserProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var darkThemeProvider=Provider.of<MyProvider>(context);
    debugPrint(darkThemeProvider.darkTheme.toString());
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "account".tr,
          style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (MyDataClass.isUserLoggedIn)
              SizedBox(
                height: 15,
              ),
            if (MyDataClass.isUserLoggedIn)
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).bottomAppBarColor,
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: Colors.white10)
                    ]),
                child: Column(
                  children: [
                    ListTile(
                      leading: MyDataClass.loginResponse!.avatar_urls.o
                              .toString()
                              .isNotEmpty
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserProfile(
                                            MyDataClass.loginResponse!)));
                              },
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "${MyDataClass.loginResponse!.avatar_urls.o}",
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              child: Text(
                                "${MyDataClass.loginResponse!.username.toString().substring(0, 1)}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                      title: Text("${MyDataClass.loginResponse!.username}"),
                      trailing: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Theme.of(context).backgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                              ),
                              context: context,
                              builder: (context) => Container(
                                height: 50,padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: Theme.of(context).backgroundColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWebView("https://www.technofino.in/community/account/account-details")));
                                      },
                                      child: Text("account_details".tr),
                                    ),
                                    // SizedBox(height: 10,),
                                    // InkWell(
                                    //     onTap: (){
                                    //       Navigator.pop(context);
                                    //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangeUsername()));
                                    //     },
                                    //     child: Text("change_username".tr))
                                  ],
                                ),
                                  )
                              //create a custom widget as you want
                              );
                        },
                        child: Image.asset(
                          "assets/icons/edit_post.png",
                          width: 24,
                          height: 24,color: darkThemeProvider.darkTheme?Colors.white:Colors.black,
                        ),
                      ),
                      subtitle:
                          Text("${MyDataClass.loginResponse!.user_title}"),
                    ),
                  ],
                ),
              ),
            if (MyDataClass.isUserLoggedIn == false)
              SizedBox(
                height: 15,
              ),
            if (MyDataClass.isUserLoggedIn == false)
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 45,
                  child: Directionality(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      icon: Icon(Icons.login),
                      label: Text(
                        "log_in".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                  )),
            SizedBox(
              height: 15,
            ),
            if (MyDataClass.isUserLoggedIn)
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).bottomAppBarColor,
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: Colors.white10)
                    ]),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowConversations()));
                      },
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            Icons.message_outlined,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("conversations".tr),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                   /* ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          CupertinoIcons.person_2,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("following_people".tr),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          Icons.person_off_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("ignoring_people".tr),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                    ListTile(
                      leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Image.asset(
                            "assets/icons/ribbon.png",
                            width: 24,
                            height: 24,
                            color: Colors.white,
                          )),
                      title: Text("watched_threads".tr),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),*/
                  ],
                ),
              ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color:Theme.of(context).bottomAppBarColor,
                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.white10)]),
              child: Column(
                children: [
                 /* InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangeLanguage()));
                    },
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("language".tr),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(
                        Icons.looks,
                        color: Colors.white,
                      ),
                    ),
                    title: Text("appearance".tr),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),*/
                  InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ChangeAppThem()));
                    },

                    child: ListTile(
                        leading: Container(
                          width: 23,
                          height: 23,
                          decoration: BoxDecoration(
                              color: Colors.purpleAccent,
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          child:Icon(
                            CupertinoIcons.moon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text("dark_mode".tr),
                        trailing:Container(
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(child: Text(darkThemeProvider.darkTheme?"on".tr:"off".tr,style: TextStyle(fontSize: 12,),)),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ),
                        )
                    ),
                  ),

                  InkWell(
                    onTap: () async{
                      var _url="http://YouTube.com/c/Technofino";
                        if (!await launch(_url)) {
                          throw 'Could not launch $_url';
                        }
                    },
                    child: ListTile(
                      leading: Image.asset("assets/icons/youtube_icon.png",width: 26,height: 26,),
                      title: Text("Youtube"),
                      trailing:Icon(Icons.keyboard_arrow_right) ,
                    ),
                  ),
                  InkWell(

                    onTap: () async{
                      var _url=Uri.parse("https://www.technofino.in/community/misc/contact");
                      if (!await launchUrl(_url)) {
                      throw 'Could not launch $_url';
                      }
                    },
                    child: ListTile(
                      leading: Image.asset("assets/icons/email.png",width: 26,height: 26,),
                      title: Text("Contact us"),
                      trailing:Icon(Icons.keyboard_arrow_right) ,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Theme.of(context).bottomAppBarColor,
                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.white10)]),
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWebView("https://www.technofino.in/community/help/terms/")));
                    },
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("terms_and_rules".tr),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWebView("https://www.technofino.in/community/help/privacy-policy")));
                    },
                    child: ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          Icons.privacy_tip_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("privacy_policy".tr),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            if (MyDataClass.isUserLoggedIn)
              InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove("isLoggedIn");
                  prefs.remove("email");
                  MyDataClass.isUserLoggedIn = false;
                  final _googleSignIn = GoogleSignIn();
                  await _googleSignIn.signOut();
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).bottomAppBarColor,
                      boxShadow: [
                        BoxShadow(blurRadius: 2, color: Colors.white10)
                      ]),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("log_out".tr),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 4,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "app_version".tr,
                    style: TextStyle(fontSize: 12, color:Theme.of(context).accentColor),
                  ),
                  Text(
                    "2022.07.23 (143)",
                    style: TextStyle(fontSize: 12, color: darkThemeProvider.darkTheme?Colors.white:Color(0xff8c8787)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

}
