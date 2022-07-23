import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/ui/conversation/ShowConversations.dart';

import '../../main_data_class/MyDataClass.dart';
import '../user_profile/UserProfile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text(
          "Account",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
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
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 2, color: Colors.white10)
                    ]),
                child: Column(
                  children: [
                    ListTile(
                      leading: MyDataClass.loginResponse!.avatar_urls.o.toString().isNotEmpty
                          ? InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(MyDataClass.loginResponse!)));
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
                      trailing: Image.asset(
                        "assets/icons/edit_post.png",
                        width: 24,
                        height: 24,
                      ),
                      subtitle: Text("${MyDataClass.loginResponse!.user_title}"),
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
                        "Log in",
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
                    color: Colors.white,
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
                        title: Text("Conversations"),
                        trailing: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          CupertinoIcons.person_2,
                          color: Colors.white,
                        ),
                      ),
                      title: Text("Following people"),
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
                      title: Text("Ignoring people"),
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
                      title: Text("Watched threads"),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
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
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.white10)]),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(
                        Icons.language,
                        color: Colors.white,
                      ),
                    ),
                    title: Text("Language"),
                    trailing: Icon(Icons.keyboard_arrow_right),
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
                    title: Text("Appearance"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                      leading: Container(
                        width: 23,
                        height: 23,
                        decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          CupertinoIcons.moon,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      title: Text("Dark Mode"),
                      trailing: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.moon,
                            color: Colors.white,
                          ),
                          label: Text("Off"))),
                  ListTile(
                    leading: Container(
                      width: 23,
                      height: 23,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(
                        Icons.star_border_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text("Rate us on Store"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(
                        Icons.open_in_new,
                        color: Colors.white,
                      ),
                    ),
                    title: Text("Open Links in"),
                    trailing: Container(
                      width: 95,
                      height: 23,
                      child: Row(
                        children: [
                          Text(
                            "In-app Chrome",
                            style: TextStyle(fontSize: 9),
                          ),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
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
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 2, color: Colors.white10)]),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                      ),
                    ),
                    title: Text("Terms and rules"),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                  ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: Text("Privacy policy"),
                    trailing: Icon(Icons.keyboard_arrow_right),
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
                  MyDataClass.isUserLoggedIn=false;
                  Navigator.pushReplacementNamed(context, "/login");
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 2, color: Colors.white10)
                      ]),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        title: Text("Log out"),
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
                    "App version",
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  Text(
                    "2022.07.23 (143)",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
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
