import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/main_data_class/MyDataClass.dart';
import 'package:technofino/ui/bottom_navigation_pages/CreateNewThread.dart';
import 'package:technofino/ui/bottom_navigation_pages/Notifications.dart';
import 'package:technofino/ui/bottom_navigation_pages/Profile.dart';
import 'package:technofino/ui/bottom_navigation_pages/ShowNodes.dart';
import 'package:technofino/ui/bottom_navigation_pages/ShowHomeThreads.dart';
import 'package:badges/badges.dart';
import '../data_classes/login_response/UserData.dart';
import '../data_classes/pagination/Pagination.dart';
import '../provider/MyProvider.dart';
import '../services/ApiClient.dart';
import 'no_network_ui/NoNetwork.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  var isNetworkAvail=true;
  final pages = [
    const ShowHomeThreads(),
    const ShowNodes(),
    const CreateNewThread(),
    const Notifications(),
    const Profile(),
  ];

  late StreamSubscription<ConnectivityResult> subscription;

  @override
  initState() {
    super.initState();
    checkConnectivity();
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return isNetworkAvail?Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).bottomAppBarColor,
            boxShadow: [BoxShadow(blurRadius: 0.5,color: Theme.of(context).bottomAppBarColor)]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                icon:pageIndex==0?  Icon(
                  Icons.home_outlined,
                  color: Theme.of(context).indicatorColor,
                  size: 30,
                ): Icon(
                  Icons.home_outlined,
                  color: Theme.of(context).buttonColor,
                  size: 30,
                )
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex==1? Icon(
                Icons.folder_outlined,
                color: Theme.of(context).indicatorColor,
                size: 30,
              ):Icon(
                Icons.folder_outlined,
                color: Theme.of(context).buttonColor,
                size: 30,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).indicatorColor,radius: 25,
                child: const Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                  size:30,
                ),
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon:pageIndex==3? Badge(
                showBadge: provider.isAlertsAvail,
                badgeContent: Text('${provider.totalAlerts}'),
                child: Icon(
                  Icons.notifications_none,
                  color: Theme.of(context).indicatorColor,
                  size: 30,
                ),
              )
                  :Badge(
                showBadge: provider.isAlertsAvail,
                alignment: Alignment.topRight,
                badgeColor: Colors.orangeAccent,
                badgeContent: Text('${provider.totalAlerts}'),
                child: Icon(
                  Icons.notifications_none,
                  color: Theme.of(context).buttonColor,
                  size: 30,
                ),
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () async{
                var provider=Provider.of<MyProvider>(context,listen: false);
                var prefs=await SharedPreferences.getInstance();
                var language= prefs.getString("language");
                provider.setLanguage(language??"English");
                setState(() {
                  pageIndex = 4;
                });
              },
              icon: pageIndex==4? Icon(
                Icons.person_outline_sharp,
                color: Theme.of(context).indicatorColor,
                size: 30,
              ): Icon(
                Icons.person_outline_sharp,
                color: Theme.of(context).buttonColor,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: pages[pageIndex],
    ):NoNetwork();
  }

  void checkConnectivity(){
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        isNetworkAvail=true;
      } else if (result == ConnectivityResult.wifi) {
        isNetworkAvail=true;
      }else{
        isNetworkAvail=false;
      }
      setState((){});
    });
  }
  @override
  dispose() {
    super.dispose();
    subscription.cancel();
  }
}
