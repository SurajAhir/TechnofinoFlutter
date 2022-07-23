import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technofino/ui/bottom_navigation_pages/CreateNewThread.dart';
import 'package:technofino/ui/bottom_navigation_pages/Notifications.dart';
import 'package:technofino/ui/bottom_navigation_pages/Profile.dart';
import 'package:technofino/ui/bottom_navigation_pages/ShowNodes.dart';
import 'package:technofino/ui/bottom_navigation_pages/ShowHomeThreads.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    const ShowHomeThreads(),
    const ShowNodes(),
    const CreateNewThread(),
    const Notifications(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,boxShadow: [BoxShadow(blurRadius: 0.5,color: Colors.black12)]
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
            icon:pageIndex==0? const Icon(
              Icons.home_outlined,
              color: Colors.orangeAccent,
              size: 30,
            ):const Icon(
              Icons.home_outlined,
              color: Colors.black38,
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
            icon: pageIndex==1?const Icon(
              Icons.folder_outlined,
              color: Colors.orangeAccent,
              size: 30,
            ):const Icon(
              Icons.folder_outlined,
              color: Colors.black38,
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
            icon: CircleAvatar(backgroundColor: Colors.orangeAccent,radius: 25,
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
            icon:pageIndex==3? const Icon(
              Icons.notifications_none,
              color: Colors.orangeAccent,
              size: 30,
            ):const Icon(
              Icons.notifications_none,
              color: Colors.black38,
              size: 30,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 4;
              });
            },
            icon: pageIndex==4?const Icon(
              Icons.person_outline_sharp,
              color: Colors.orangeAccent,
              size: 30,
            ):const Icon(
              Icons.person_outline_sharp,
              color: Colors.black38,
              size: 30,
            ),
          ),
        ],
      ),
    ),
      body: pages[pageIndex],
    );
  }
}
