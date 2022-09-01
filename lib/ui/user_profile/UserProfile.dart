import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:technofino/ui/user_profile/UserAbout.dart';
import 'package:technofino/ui/user_profile/UserThreads.dart';
import 'package:html/parser.dart' show parse;
import 'dart:math' as math;
import '../../data_classes/login_response/UserData.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../data_classes/post_response/PostsOfThreads.dart';
import '../../data_classes/thread_response/Threads.dart';
import '../../data_classes/user_profile_posts_response/ProfilePosts.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../MyWebView.dart';
import '../ReportContent.dart';
import '../nodes_related_classes/ShowImage.dart';
import '../nodes_related_classes/ShowPostsOfThreads.dart';
import 'ReplyOnUserProfilePosts.dart';
import 'StartConversation.dart';
import 'UpdateYourStatus.dart';
import 'WriteSomething.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class UserProfile extends StatefulWidget {
  UserData user;

  UserProfile(this.user, {Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandart;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _scrollControllar = ScrollController();
  Pagination? pagination;
  int page = 1;
  List<ProfilePosts> posts = [];
  bool isLoadingPosts = false;
  var isDataAvailable = false;
  var prevIndex = 0;

  @override
  initState() {
    listenDynamicLinks();
    initDeepLinkData();
    super.initState();
    if (MyDataClass.myUserId == widget.user.user_id) {
      widget.user = MyDataClass.loginResponse as UserData;
    }
    getData(page);
    _scrollControllar.addListener(() {
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingProfilePosts(true);
          page++;
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        } else {
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!.current_page}");
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingProfilePosts(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("${MyDataClass.myUserId} and ${widget.user.user_id}");
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Material(
                  elevation: 50,
                  child: Container(
                      height: 45,
                      color: Theme.of(context).bottomAppBarColor,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).accentColor,
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text("${widget.user.username}",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor,
                                fontSize: 18)),
                        if (MyDataClass.myUserId == widget.user.user_id)
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor:
                                          Theme.of(context).bottomAppBarColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                      ),
                                      context: context,
                                      builder: (context) => Container(
                                            height: 50,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .bottomAppBarColor,
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10))),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // InkWell(
                                                //   onTap: (){
                                                //     Navigator.push(context,MaterialPageRoute(builder: (context)=>const ReportContent()));
                                                //     },
                                                //   child: Text("report".tr),
                                                // ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                if (MyDataClass.myUserId ==
                                                    widget.user.user_id)
                                                  InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            backgroundColor: Theme
                                                                    .of(context)
                                                                .bottomAppBarColor,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Container(
                                                                      height:
                                                                          100,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      decoration: BoxDecoration(
                                                                          color: Theme.of(context)
                                                                              .bottomAppBarColor,
                                                                          borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(10),
                                                                              topLeft: Radius.circular(10))),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              var status = await Permission.photos;
                                                                              if (await status.isGranted) {
                                                                                getPhoto(context);
                                                                              } else {
                                                                                status.request();
                                                                              }
                                                                            },
                                                                            child:
                                                                                Text("choose_from_gallery".tr),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          InkWell(
                                                                              onTap: () async {
                                                                                var status = await Permission.camera;
                                                                                if (await status.isGranted) {
                                                                                  getPhotoFromCamera(context);
                                                                                } else {
                                                                                  status.request();
                                                                                }
                                                                              },
                                                                              child: Text("take_photo".tr))
                                                                        ],
                                                                      ),
                                                                    )
                                                            //create a custom widget as you want
                                                            );
                                                      },
                                                      child: Text(
                                                          "update_avatar".tr)),
                                              ],
                                            ),
                                          )
                                      //create a custom widget as you want
                                      );
                                },
                                child: Text(
                                  "...",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                      ]))),
              SizedBox(
                height: 1,
              ),
              Expanded(
                  child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: () async {
                  debugPrint("refrshing...");
                  page = 1;
                  getData(page);
                },
                child: SingleChildScrollView(
                  controller: _scrollControllar,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        color: Theme.of(context).bottomAppBarColor,
                        child: Column(
                          children: [
                            ListTile(
                              leading: widget.user.avatar_urls.o
                                      .toString()
                                      .isNotEmpty
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                        "${widget.user.avatar_urls.o}",
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: Text(
                                        "${widget.user.username.toString().substring(0, 1)}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 24),
                                      ),
                                    ),
                              title: Text(
                                "${widget.user.username}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "${widget.user.user_title} • ${DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(((widget.user.register_date) * 1000).toInt()))}",
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            if (MyDataClass.myUserId.toString() !=
                                widget.user.user_id.toString())
                              MyDataClass.isUserLoggedIn
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Container(
                                          //   padding: EdgeInsets.all(8),
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.blueAccent,
                                          //       borderRadius: BorderRadius.all(
                                          //           Radius.circular(20))),
                                          //   child: Row(
                                          //     children: [
                                          //       Icon(
                                          //         CupertinoIcons.heart,
                                          //         color: Colors.white,
                                          //         size: 18,
                                          //       ),
                                          //       Text(
                                          //         "follow".tr,
                                          //         style: TextStyle(
                                          //             color: Colors.white,
                                          //             fontSize: 14),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StartConversation(
                                                                  widget.user)))
                                                  .then((value) {
                                                page = 1;
                                                getData(page);
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .messenger_outline_outlined,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                  SizedBox(
                                                    width: 2,
                                                  ),
                                                  Text(
                                                    "message".tr,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 4,
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 20,
                                    )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(
                              "profile_posts".tr,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserThreads(widget.user)));
                              },
                              child: Text(
                                "threads".tr,
                                style: TextStyle(fontSize: 18),
                              )),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserAbout(widget.user)));
                              },
                              child: Text(
                                "about".tr,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (MyDataClass.myUserId.toString() !=
                          widget.user.user_id.toString())
                        MyDataClass.isUserLoggedIn
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WriteSomething(widget.user)))
                                      .then((value) {
                                    page = 1;
                                    getData(page);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Theme.of(context).bottomAppBarColor,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      widget.user.avatar_urls.o
                                              .toString()
                                              .isNotEmpty
                                          ? CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                "${widget.user.avatar_urls.o}",
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  Colors.lightBlueAccent,
                                              radius: 30,
                                              child: Text(
                                                "${widget.user.username.substring(0, 1)}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24),
                                              ),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("write_something".tr + "...")
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 20,
                              ),
                      if (MyDataClass.myUserId.toString() ==
                          widget.user.user_id.toString())
                        MyDataClass.isUserLoggedIn
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateYourStatus(widget.user)));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    color: Theme.of(context).bottomAppBarColor,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      widget.user.avatar_urls.o
                                              .toString()
                                              .isNotEmpty
                                          ? CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                "${widget.user.avatar_urls.o}",
                                              ),
                                            )
                                          : CircleAvatar(
                                              radius: 30,
                                              backgroundColor:
                                                  Colors.lightBlueAccent,
                                              child: Text(
                                                "${widget.user.username.substring(0, 1)}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24),
                                              ),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("update_your_status".tr + "...")
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 20,
                              ),
                      if (isDataAvailable)
                        SizedBox(
                          height: 10,
                        ),
                      Container(
                        color: Theme.of(context).backgroundColor,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).bottomAppBarColor,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 70,
                                    color: Theme.of(context).bottomAppBarColor,
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 5),
                                    margin: EdgeInsets.all(0),
                                    child: Row(
                                      children: [
                                        posts[index]
                                                .User!
                                                .avatar_urls
                                                .o
                                                .toString()
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserProfile(posts[
                                                                          index]
                                                                      .User
                                                                  as UserData)));
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: provider
                                                          .darkTheme
                                                      ? Colors.white
                                                      : Colors.lightBlueAccent,
                                                  backgroundImage: NetworkImage(
                                                      posts[index]
                                                          .User!
                                                          .avatar_urls
                                                          .o),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserProfile(posts[
                                                                          index]
                                                                      .User
                                                                  as UserData)));
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: provider
                                                          .darkTheme
                                                      ? Colors.white
                                                      : Colors.lightBlueAccent,
                                                  child: Text(
                                                      "${posts[index].User!.username.toString().substring(0, 1)}"),
                                                ),
                                              ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserProfile(posts[
                                                                          index]
                                                                      .User
                                                                  as UserData)));
                                                },
                                                child: Text(
                                                  posts[index].User!.username,
                                                  style: TextStyle(
                                                      color: Colors.orange,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                )),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              posts[index].User!.user_title,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Text(
                                              "Level points: " +
                                                  posts[index]
                                                      .User!
                                                      .trophy_points
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "#${index + 1} ${readTimestamp(posts[index].post_date.toInt())}",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: provider.darkTheme
                                                      ? Color(0xffe4dddd)
                                                      : Colors.black54),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          color: Theme.of(context)
                                              .bottomAppBarColor),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Html(
                                            data: getFilteredMessage(
                                                posts[index].message_parsed,
                                                posts[index]),
                                            style: {
                                              "body": Style(
                                                fontSize: FontSize(16),
                                                fontFamily: "",
                                                wordSpacing: 1.5,
                                                whiteSpace: WhiteSpace.NORMAL,
                                                lineHeight:
                                                    LineHeight.number(1.1),
                                              ),
                                              "table": Style(
                                                fontFamily: "arial, sans-serif",
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .accentColor,
                                              ),
                                              "blockquote": Style(
                                                  border: const Border(
                                                    left: BorderSide(
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        width: 2.0,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 8,
                                                          bottom: 5),
                                                  margin: const EdgeInsets.only(
                                                      left: 7, bottom: 30),
                                                  backgroundColor:
                                                      provider.darkTheme
                                                          ? Colors.transparent
                                                          : Color(0xffdcdcdc),
                                                  fontSize:
                                                      FontSize(15) //e5f6f4
                                                  ),
                                              "h5": Style(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                        color:
                                                            provider.darkTheme
                                                                ? Colors.white70
                                                                : Colors.grey,
                                                        width: 0.5),
                                                    left: BorderSide(
                                                        color: Colors
                                                            .lightBlueAccent,
                                                        width: 2.0,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          top: 5,
                                                          bottom: 5),
                                                  margin: const EdgeInsets.only(
                                                    left: 7,
                                                  ),
                                                  backgroundColor:
                                                      provider.darkTheme
                                                          ? Colors.transparent
                                                          : Color(0xffdcdcdc),
                                                  textAlign: TextAlign.left),
                                              "th": Style(
                                                padding: EdgeInsets.all(6),
                                                backgroundColor: Colors.grey,
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                              "td": Style(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .bottomAppBarColor,
                                                padding: EdgeInsets.all(6),
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                            },
                                            customRender: {
                                              "table": (context, child) {
                                                return SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: (context.tree
                                                          as TableLayoutElement)
                                                      .toWidget(context),
                                                );
                                              },
                                            },
                                            onLinkTap: (url,
                                                RenderContext context1,
                                                Map<String, String> attributes,
                                                dom.Element? element) async {
                                              debugPrint("Opening ${url}");
                                              if (url.toString().contains(
                                                  "https://www.technofino.in/community/threads/")) {
                                                var link = url
                                                    .toString()
                                                    .replaceAll(
                                                        "https://www.technofino.in/community/threads/",
                                                        "");
                                                link = link.substring(
                                                    link.indexOf(".") + 1);
                                                link = link.substring(
                                                    0, link.indexOf("/"));
                                                debugPrint(link);
                                                var threadResponse = await http.get(
                                                    Uri.parse(
                                                        "https://www.technofino.in/community/api/threads/$link/"),
                                                    headers: {
                                                      "XF-Api-Key":
                                                          MyDataClass.api_key
                                                    });
                                                var jsonResponse =
                                                    convert.jsonDecode(
                                                            threadResponse.body)
                                                        as Map<String, dynamic>;
                                                var thread = Threads.fromJson(
                                                    jsonResponse["thread"]);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ShowPostsOfThreads(
                                                                thread.Forum !=
                                                                        null
                                                                    ? thread
                                                                        .Forum!
                                                                        .breadcrumbs![
                                                                            0]
                                                                        .title
                                                                        .toString()
                                                                    : "",
                                                                thread.Forum !=
                                                                        null
                                                                    ? thread
                                                                        .Forum!
                                                                        .title
                                                                    : "",
                                                                thread,
                                                                1,
                                                                "")));
                                              } else {
                                                var username = element?.text
                                                    .toString()
                                                    .replaceAll("@", "");
                                                var user = await ApiClient(Dio(
                                                        BaseOptions(
                                                            contentType:
                                                                "application/json")))
                                                    .findUserByName(
                                                        MyDataClass.api_key,
                                                        username.toString());
                                                var userData = user.exact;
                                                if (userData != null) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UserProfile(
                                                                  userData)));
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyWebView(url
                                                                  .toString())));
                                                }
                                              }
                                            },
                                            onImageTap: (src, _, __, ___) {
                                              debugPrint(src);
                                              var att =
                                                  posts[index].Attachments;
                                              att?.forEach((element) {
                                                if (src ==
                                                    element.thumbnail_url) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ShowImage(element
                                                                  .attachment_id)));
                                                }
                                              });
                                            },
                                          )
                                        ],
                                      )),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 8, left: 10, bottom: 6),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6))),
                                    alignment: Alignment.centerRight,
                                    child: Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 4,
                                              ),
                                              if (MyDataClass.isUserLoggedIn)
                                                InkWell(
                                                    onTap: () {
                                                      prevIndex = index;
                                                      react(
                                                          1,
                                                          posts[index]
                                                              .profile_post_id,
                                                          index);
                                                    },
                                                    onLongPress: () {
                                                      showDialogBox(
                                                          context,
                                                          posts[index]
                                                              .profile_post_id,
                                                          index);
                                                    },
                                                    child: isReactedTo(
                                                        context,
                                                        posts[index],
                                                        index,
                                                        provider) //:nowIsReacted(context,newReactionId,index)
                                                    ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                " " +
                                                    posts[index]
                                                        .reaction_score
                                                        .toString(),
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              //*********************************************************** Provider.of<MyProvider>(context).isReacted==false?
                                              if (MyDataClass.isUserLoggedIn)
                                                SizedBox(
                                                  width: 8,
                                                ),
                                              InkWell(
                                                  onTap: () async {
                                                    generateLink(
                                                        context,
                                                        BranchUniversalObject(
                                                            canonicalIdentifier:
                                                                'flutter/branch',
                                                            canonicalUrl:
                                                                'https://technofino.in',
                                                            title:
                                                                'TechnoFino Cummunity',
                                                            imageUrl:
                                                                "https://www.technofino.in/community/data/assets/footer_logo/cropped-cropped-Logo-PNG-1.png",
                                                            contentMetadata:
                                                                BranchContentMetaData()
                                                                  ..addCustomMetadata(
                                                                      "isUserPost",
                                                                      "true")
                                                                  ..addCustomMetadata(
                                                                      "user",
                                                                      json.encode(
                                                                          posts[index]
                                                                              .User)),
                                                            contentDescription:
                                                                '${posts[index].view_url}',
                                                            //contentMetadata: metadata,
                                                            keywords: [
                                                              'Plugin',
                                                              'Branch',
                                                              'Flutter'
                                                            ],
                                                            publiclyIndex: true,
                                                            locallyIndex: true,
                                                            expirationDateInMilliSec:
                                                                DateTime.now()
                                                                    .add(const Duration(
                                                                        days:
                                                                            365))
                                                                    .millisecondsSinceEpoch),
                                                        BranchLinkProperties(
                                                            channel: 'facebook',
                                                            feature: 'sharing',
                                                            stage: 'new share',
                                                            campaign:
                                                                'campaign',
                                                            tags: [
                                                              'one',
                                                              'two',
                                                              'three'
                                                            ])
                                                          ..addControlParam(
                                                              '\$uri_redirect_mode',
                                                              '1')
                                                          ..addControlParam(
                                                              'referring_user_id',
                                                              'user_id'));
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.share,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text("share".tr,
                                                          style: TextStyle(
                                                              fontSize: 13))
                                                    ],
                                                  )),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              if (MyDataClass.isUserLoggedIn)
                                                Expanded(
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Icon(
                                                          Icons.reply,
                                                          size: 15,
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            var message = posts[
                                                                    index]
                                                                .message_parsed;
                                                            if (message.contains(
                                                                "<blockquote class=")) {
                                                              var originalMessage =
                                                                  posts[index]
                                                                      .message_parsed;
                                                              message = message
                                                                  .substring(
                                                                      message.indexOf(
                                                                              "\">") +
                                                                          2);
                                                              message = message
                                                                  .substring(
                                                                      0,
                                                                      message.indexOf(
                                                                          "</blockquote>"));
                                                              originalMessage =
                                                                  originalMessage
                                                                      .replaceAll(
                                                                          message,
                                                                          "");
                                                              var exactString =
                                                                  originalMessage;
                                                              originalMessage =
                                                                  originalMessage
                                                                      .substring(
                                                                          originalMessage
                                                                              .indexOf("<blockquote"));
                                                              originalMessage =
                                                                  originalMessage
                                                                      .substring(
                                                                          0,
                                                                          originalMessage
                                                                              .indexOf("</blockquote>"));
                                                              originalMessage =
                                                                  originalMessage +
                                                                      "</blockquote>";
                                                              exactString =
                                                                  exactString
                                                                      .replaceAll(
                                                                          originalMessage,
                                                                          "");
                                                              debugPrint(
                                                                  exactString);
                                                              // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${exactString}[/QUOTE]";4
                                                              var realMessage =
                                                                  "<body>${exactString}</body>";
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ReplyOnUserProfilePosts(
                                                                          posts[
                                                                              index],
                                                                          realMessage))).then(
                                                                  (value) {
                                                                posts.clear();
                                                                getData(page);
                                                              });
                                                            } else {
                                                              // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${message}[/QUOTE]";
                                                              var realMessage =
                                                                  "<body>${message}</body>";
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => ReplyOnUserProfilePosts(
                                                                          posts[
                                                                              index],
                                                                          realMessage))).then(
                                                                  (value) {
                                                                posts.clear();
                                                                getData(page);
                                                              });
                                                            }
                                                          },
                                                          child: Text(
                                                            "reply".tr,
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  if (posts[index].comment_count > 0)
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index1) {
                                        return Container(
                                          padding: EdgeInsets.all(4),
                                          margin: EdgeInsets.only(
                                              left: 18, right: 6),
                                          decoration: BoxDecoration(
                                              color: provider.darkTheme
                                                  ? Colors.brown
                                                  : Color.fromRGBO(
                                                      245, 245, 245, 97),
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: posts[index]
                                                        .LatestComments![index1]
                                                        .User!
                                                        .avatar_urls
                                                        .o
                                                        .toString()
                                                        .isNotEmpty
                                                    ? InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => UserProfile(posts[index]
                                                                      .LatestComments![
                                                                          index1]
                                                                      .User as UserData)));
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(posts[
                                                                      index]
                                                                  .LatestComments![
                                                                      index1]
                                                                  .User!
                                                                  .avatar_urls
                                                                  .o),
                                                        ),
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => UserProfile(posts[index]
                                                                      .LatestComments![
                                                                          index1]
                                                                      .User as UserData)));
                                                        },
                                                        child: CircleAvatar(
                                                          backgroundColor: Colors
                                                              .lightBlueAccent,
                                                          child: Text(
                                                              "${posts[index].LatestComments![index1].User!.username.substring(0, 1)}"),
                                                        ),
                                                      ),
                                                title: Text(
                                                    "${posts[index].LatestComments![index1].User!.username}"),
                                                subtitle: Text(
                                                    "${DateFormat('dd MMMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(((posts[index].LatestComments![index1].comment_date.toInt()) * 1000).toInt()))}",
                                                style: TextStyle(fontSize: 12),),
                                                // trailing: MyDataClass.isUserLoggedIn?Container(
                                                //   padding: EdgeInsets.all(5),
                                                //   decoration: BoxDecoration(
                                                //       color: Colors.blueAccent,
                                                //       borderRadius: BorderRadius.all(
                                                //           Radius.circular(10))),
                                                //   child:Text(
                                                //     "follow".tr,
                                                //     style: TextStyle(color: Colors.white,fontSize: 10),
                                                //   ),
                                                // ):SizedBox(),
                                              ),
                                              Html(
                                                data: getFilteredMessage(
                                                    posts[index]
                                                        .LatestComments![index1]
                                                        .message_parsed,
                                                    posts[index]
                                                            .LatestComments![
                                                        index1]),
                                                style: {
                                                  "body": Style(
                                                      fontSize: FontSize(14),
                                                      padding: EdgeInsets.only(
                                                          left: 6),
                                                      letterSpacing: 0.5),
                                                  "table": Style(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            0x50,
                                                            0xee,
                                                            0xee,
                                                            0xee),
                                                  ),
                                                  "blockquote": Style(
                                                      border: const Border(
                                                        left: BorderSide(
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            width: 2.0,
                                                            style: BorderStyle
                                                                .solid),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 7)),
                                                  "tr": Style(
                                                    border: const Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                  ),
                                                  "th": Style(
                                                    padding: EdgeInsets.all(6),
                                                    backgroundColor:
                                                        Colors.grey,
                                                    border: const Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                  ),
                                                  "td": Style(
                                                    padding: EdgeInsets.all(6),
                                                    alignment:
                                                        Alignment.topLeft,
                                                    border: const Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.grey)),
                                                  ),
                                                  'h5': Style(
                                                      maxLines: 2,
                                                      textOverflow: TextOverflow
                                                          .ellipsis),
                                                },
                                                customRender: {
                                                  "table": (context, child) {
                                                    return SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: (context.tree
                                                              as TableLayoutElement)
                                                          .toWidget(context),
                                                    );
                                                  },
                                                },
                                                onLinkTap: (url,
                                                    RenderContext context1,
                                                    Map<String, String>
                                                        attributes,
                                                    dom.Element?
                                                        element) async {
                                                  debugPrint(
                                                      "Opening ${element?.text.toString()}");
                                                  var username = element?.text
                                                      .toString()
                                                      .replaceAll("@", "");
                                                  var user = await ApiClient(
                                                          Dio(BaseOptions(
                                                              contentType:
                                                                  "application/json")))
                                                      .findUserByName(
                                                          MyDataClass.api_key,
                                                          username.toString());
                                                  var userData = user.exact;
                                                  if (userData != null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserProfile(
                                                                    userData)));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                MyWebView(url
                                                                    .toString())));
                                                  }
                                                },
                                                onImageTap: (src, _, __, ___) {
                                                  debugPrint(src);
                                                  var att = posts[index]
                                                      .LatestComments![index1]
                                                      .Attachments;
                                                  att?.forEach((element) {
                                                    if (src ==
                                                        element.thumbnail_url) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ShowImage(element
                                                                      .attachment_id)));
                                                    }
                                                  });
                                                },
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: InkWell(
                                                    onTap: () {
                                                      prevIndex = index1;
                                                      reactOnComment(
                                                          1,
                                                          posts[index]
                                                              .LatestComments![
                                                                  index1]
                                                              .profile_post_comment_id,
                                                          index,
                                                          index1);
                                                    },
                                                    onLongPress: () {
                                                      showDialogBoxForComment(
                                                          context,
                                                          posts[index]
                                                              .LatestComments![
                                                                  index1]
                                                              .profile_post_comment_id,
                                                          index,
                                                          index1);
                                                    },
                                                    child: isReactedToOnComment(
                                                        context,
                                                        posts[index]
                                                                .LatestComments![
                                                            index1],
                                                        index,
                                                        provider,
                                                        index1) //*********************************************************
                                                    ),
                                              ),
                                              // Container(
                                              //   width: MediaQuery.of(context).size.width,
                                              //   color: Colors.black12,
                                              //   height: 1,
                                              // )
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount:
                                          posts[index].LatestComments!.length,
                                    )
                                ],
                              ),
                            );
                          },
                          itemCount: posts.length,
                        ),
                      ),
                      if (Provider.of<MyProvider>(context)
                          .isLoadingProfilePosts)
                        const CircularProgressIndicator.adaptive()
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  String readTimestamp(int lastActivityData) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(lastActivityData * 1000);
    String time = "";
    if (now.year == date.year) {
      if (date.month == now.month) {
        if (date.day == now.day) {
          if (date.hour == now.hour) {
            if (now.minute - date.minute < 2) {
              time = "a moment ago";
            } else {
              time = "${now.minute - date.minute} minutes ago";
            }
          } else if (date.hour < now.hour) {
            var timeInMinuts = (now.hour - date.hour) * 60 + now.minute;
            if (timeInMinuts - date.minute < 60) {
              time = "${(timeInMinuts - date.minute).abs()} minutes ago";
            } else {
              time = "${now.hour - date.hour} hour ago";
            }
          }
        } else {
          if (now.day - date.day < 2) {
            time = "${now.day - date.day} day ago";
          } else {
            time = "${now.day - date.day} days ago";
          }
        }
      } else {
        if (now.month - date.month < 2) {
          time = "${now.month - date.month} month ago";
        } else {
          time = "${now.month - date.month} months ago";
        }
      }
    } else {
      if ((now.year - 100) - (date.year - 100) < 2) {
        time = "${(now.year - 100) - (date.year - 100)} year ago";
      } else {
        time = "${(now.year - 100) - (date.year - 100)} years ago";
      }
    }
    return time;
  }

  void getData(int page) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var threadResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getProfilePosts(
                MyDataClass.api_key, MyDataClass.myUserId, widget.user.user_id);
    pagination = threadResponse.pagination;
    if (_refreshController.isRefresh) {
      if (threadResponse.profile_posts.isNotEmpty) {
        posts.clear();
      }
      _refreshController.refreshCompleted();
    }
    posts.clear();
    posts.addAll(threadResponse.profile_posts);
    for (int i = 0; i < posts.length; i++) {
      provider.changeReaction(i, posts[i].visitor_reaction_id);
      if (posts[i].LatestComments != null &&
          posts[i].LatestComments!.isNotEmpty) {
        debugPrint("hello----------------------------------------" +
            posts.length.toString());
        var map = Map<int, int>();
        for (int j = 0; j < posts[i].LatestComments!.length; j++) {
          map.putIfAbsent(
              j, () => posts[i].LatestComments![j].visitor_reaction_id);
        }
        provider.changeReactionOfComment(i, map);
      }
    }
    if (posts.isEmpty) {
      setState(() {
        isDataAvailable = false;
      });
    } else {
      setState(() {
        isDataAvailable = true;
      });
    }
  }

  getFilteredMessage(String message_parsed, ProfilePosts post) {
    var mess = message_parsed;
    var blockquote = parse(message_parsed).querySelector("blockquote");
    var blockquoteUsername = blockquote?.attributes["data-name"].toString();
    if (post.message_parsed.contains("<img")) {
      if (post.attach_count > 0) {
        var document = parse(message_parsed);
        var imgThumbList = post.Attachments;
        var imgList = document.querySelectorAll("img");
        debugPrint(imgThumbList!.length.toString() +
            "---------------------------------");
        debugPrint(
            imgList.length.toString() + "---------------------------------");
        int prev = 0;

        if (imgThumbList?.length == imgList.length) {
          for (int i = 0; i < imgThumbList!.length; i++) {
            for (int j = 0; j < imgList.length; j++) {
              if (imgThumbList[i].filename == imgList[j].attributes["alt"]) {
                var src = imgList[j].attributes["src"];
                prev = i + 1;
                mess = mess.replaceAll(src!, imgThumbList[i].thumbnail_url);
              }
            }
          }
        } else if (imgThumbList.length < imgList.length) {
          for (int i = 0; i < imgThumbList.length; i++) {
            for (int j = 0; j < imgList.length; j++) {
              if (imgThumbList[i].filename == imgList[j].attributes["alt"]) {
                var src = imgList[j].attributes["src"];
                prev = i + 1;
                mess = mess.replaceAll(src!, imgThumbList[i].thumbnail_url);
              }
            }
          }
        } else {
          for (int i = 0; i < imgList.length; i++) {
            for (int j = 0; j < imgThumbList.length; j++) {
              if (imgThumbList[j].filename == imgList[i].attributes["alt"]) {
                var src = imgList[i].attributes["src"];
                prev = i + 1;
                mess = mess.replaceAll(src!, imgThumbList[j].thumbnail_url);
              }
            }
          }
        }

        if (post.attach_count > imgList.length) {
          for (int i = prev; i < imgThumbList.length; i++) {
            var url = "<br /><img src='${imgThumbList[i].thumbnail_url}'/>";
            mess = mess + url;
          }
        }
      }
    } else {
      if (post.attach_count > 0) {
        var image = post.Attachments;
        image?.forEach((element) {
          var url = "<br /><img src='${element.thumbnail_url}'/>";
          mess = mess + url;
        });
      }
    }
    mess = mess.replaceAll(":ROFLMAO:", "🤣");
    return mess;
  }

  void react(int reaction_id, int post_id, int index) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    if (provider.reactMap[index] == reaction_id) {
      provider.changeReaction(index, 0);
    } else {
      provider.changeReaction(index, reaction_id);
    }
    debugPrint("profilepostid" + post_id.toString());
    var response =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getResponseOfProfilePostsReact(MyDataClass.api_key,
                MyDataClass.myUserId, post_id, reaction_id);
    setState(() {
      getData(page);
    });
  }

  void reactOnComment(
      int reaction_id, int post_id, int index, int indexOfComment) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    if (provider.reactMapOfComment[index]![indexOfComment] == reaction_id) {
      var map = provider.reactMapOfComment[index];
      map?.update(indexOfComment, (value) => 0);
      provider.changeReactionOfComment(index, map!);
    } else {
      var map = provider.reactMapOfComment[index];
      map?.update(indexOfComment, (value) => reaction_id);
      provider.changeReactionOfComment(index, map!);
    }
    debugPrint("profilepostid" + post_id.toString());
    var response =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getResponseOfProfilePostsOfCommentsReact(MyDataClass.api_key,
                MyDataClass.myUserId, post_id, reaction_id);
    setState(() {
      getData(page);
    });
  }

  showDialogBox(BuildContext, int post_id, int index) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
          height: 50,
          width: 300.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  react(1, post_id, index);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                    radius: 18,
                    child: Icon(
                      CupertinoIcons.hand_thumbsup_fill,
                      color: Colors.white,
                      size: 22,
                    )),
              ),
              InkWell(
                  onTap: () {
                    react(2, post_id, index);
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icons/love_icon.png",
                    width: 35,
                    height: 35,
                  )),
              InkWell(
                  onTap: () {
                    react(3, post_id, index);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/haha_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    react(4, post_id, index);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/wow_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    react(5, post_id, index);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/sad_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    react(6, post_id, index);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/angry_icon.png",
                      width: 35, height: 35))
            ],
          )),
    );
    showDialog(context: context, builder: (context) => errorDialog);
  }

  showDialogBoxForComment(
      BuildContext, int post_id, int index, int indexOfComment) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
          height: 50,
          width: 300.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  reactOnComment(1, post_id, index, indexOfComment);
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                    radius: 18,
                    child: Icon(
                      CupertinoIcons.hand_thumbsup_fill,
                      color: Colors.white,
                      size: 22,
                    )),
              ),
              InkWell(
                  onTap: () {
                    reactOnComment(2, post_id, index, indexOfComment);
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icons/love_icon.png",
                    width: 35,
                    height: 35,
                  )),
              InkWell(
                  onTap: () {
                    reactOnComment(3, post_id, index, indexOfComment);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/haha_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    reactOnComment(4, post_id, index, indexOfComment);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/wow_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    reactOnComment(5, post_id, index, indexOfComment);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/sad_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    reactOnComment(6, post_id, index, indexOfComment);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/angry_icon.png",
                      width: 35, height: 35))
            ],
          )),
    );
    showDialog(context: context, builder: (context) => errorDialog);
  }

  Widget isReactedTo(
      BuildContext context, ProfilePosts post, int index, MyProvider provider) {
    switch (provider.reactMap[index]) {
      case 1:
        return Container(
          child: Row(
            children: [
              Icon(
                CupertinoIcons.hand_thumbsup_fill,
                color: Colors.blueAccent,
                size: 15,
              ),
              Text(
                "like".tr,
                style: TextStyle(fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );
      case 2:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/love_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "love".tr,
                style: TextStyle(fontSize: 13, color: Colors.redAccent),
              )
            ],
          ),
        );

      case 3:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/haha_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "Haha",
                style: TextStyle(fontSize: 13, color: Colors.yellow),
              )
            ],
          ),
        );

      case 4:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/wow_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "Wow",
                style: TextStyle(fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );

      case 5:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/sad_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "sad".tr,
                style: TextStyle(fontSize: 13, color: Colors.orange),
              )
            ],
          ),
        );

      case 6:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/angry_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "angry".tr,
                style: TextStyle(fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );

      default:
        return Container(
          child: Row(
            children: [
              Icon(
                CupertinoIcons.hand_thumbsup,
                size: 15,
              ),
              Text(
                "like".tr,
                style: TextStyle(
                    fontSize: 13, color: Theme.of(context).accentColor),
              )
            ],
          ),
        );
    }
  }

  Widget isReactedToOnComment(BuildContext context, ProfilePosts post,
      int index, MyProvider provider, int indexOfComment) {
    switch (provider.reactMapOfComment[index]![indexOfComment]) {
      case 1:
        return Container(
          child: Row(
            children: [
              Icon(
                CupertinoIcons.hand_thumbsup_fill,
                color: Colors.blueAccent,
                size: 15,
              ),
              Text(
                "like".tr,
                style: TextStyle(fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );
      case 2:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/love_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "love".tr,
                style: TextStyle(fontSize: 13, color: Colors.redAccent),
              )
            ],
          ),
        );

      case 3:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/haha_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "Haha",
                style: TextStyle(fontSize: 13, color: Colors.yellow),
              )
            ],
          ),
        );

      case 4:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/wow_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "Wow",
                style: TextStyle(fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );

      case 5:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/sad_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "sad".tr,
                style: TextStyle(fontSize: 13, color: Colors.orange),
              )
            ],
          ),
        );

      case 6:
        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/angry_icon.png",
                width: 24,
                height: 24,
              ),
              Text(
                "angry".tr,
                style: TextStyle(fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );

      default:
        return Container(
          child: Row(
            children: [
              Icon(
                CupertinoIcons.hand_thumbsup,
                size: 15,
              ),
              Text(
                "like".tr,
                style: TextStyle(
                    fontSize: 13, color: Theme.of(context).accentColor),
              )
            ],
          ),
        );
    }
  }

  getPhoto(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      showLoaderDialog(context, "loading".tr);
      debugPrint(image.path);
      var response =
          await ApiClient(Dio(BaseOptions(contentType: "multipart/form-data")))
              .updateUserProfileImage(
                  MyDataClass.api_key, widget.user.user_id, File(image.path));
      if (response.success) {
        MyDataClass.loginResponse = response.user;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {
          widget.user = response.user;
        });
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
  }

  void getPhotoFromCamera(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      debugPrint(image.name);
      showLoaderDialog(context, "loading".tr);
      debugPrint(image.path);
      var response =
          await ApiClient(Dio(BaseOptions(contentType: "multipart/form-data")))
              .updateUserProfileImage(
                  MyDataClass.api_key, widget.user.user_id, File(image.path));
      if (response.success) {
        MyDataClass.loginResponse = response.user;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        setState(() {
          widget.user = response.user;
        });
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }
    }
  }

  showLoaderDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text("$message...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false, //this is default method which flutter provides
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void generateLink(BuildContext context, BranchUniversalObject buo,
      BranchLinkProperties lp) async {
    BranchResponse response =
        await FlutterBranchSdk.getShortUrl(buo: buo!, linkProperties: lp);
    if (response.success) {
      debugPrint(response.result);
      await Share.share(response.result);
    } else {
      debugPrint('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  void listenDynamicLinks() async {
    streamSubscription = FlutterBranchSdk.initSession().listen((data) async {
      print('listenDynamicLinks - DeepLink Data: $data');
      controllerData.sink.add((data.toString()));
      if (data.containsKey('+clicked_branch_link') &&
          data['+clicked_branch_link'] == true) {
        print(
            '------------------------------------Link clicked----------------------------------------------');
        print('Custom list number: ${data['custom_list_number']}');
        print(
            '------------------------------------------------------------------------------------------------');
        if (data["isUserPost"] == "true") {
          var decodedResponse = json.decode(data["user"]);
          var user = UserData.fromJson(decodedResponse);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserProfile(user)));
        }
      }
    }, onError: (error) {
      print('InitSesseion error: ${error.toString()}');
    });
  }

  void initDeepLinkData() {
    metadata = BranchContentMetaData()
      ..addCustomMetadata('custom_string', 'abc')
      ..addCustomMetadata('custom_number', 12345)
      ..addCustomMetadata('custom_bool', true)
      ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
      ..addCustomMetadata('custom_list_string', ['a', 'b', 'c'])
      //--optional Custom Metadata
      ..contentSchema = BranchContentSchema.COMMERCE_PRODUCT
      ..price = 50.99
      ..currencyType = BranchCurrencyType.BRL
      ..quantity = 50
      ..sku = 'sku'
      ..productName = 'productName'
      ..productBrand = 'productBrand'
      ..productCategory = BranchProductCategory.ELECTRONICS
      ..productVariant = 'productVariant'
      ..condition = BranchCondition.NEW
      ..rating = 100
      ..ratingAverage = 50
      ..ratingMax = 100
      ..ratingCount = 2
      ..setAddress(
          street: 'street',
          city: 'city',
          region: 'ES',
          country: 'Brazil',
          postalCode: '99999-987')
      ..setLocation(31.4521685, -114.7352207);

    buo = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        //parameter canonicalUrl
        //If your content lives both on the web and in the app, make sure you set its canonical URL
        // (i.e. the URL of this piece of content on the web) when building any BUO.
        // By doing so, we’ll attribute clicks on the links that you generate back to their original web page,
        // even if the user goes to the app instead of your website! This will help your SEO efforts.
        canonicalUrl: 'https://flutter.dev',
        title: 'Flutter Branch Plugin',
        imageUrl: "",
        contentDescription: 'Flutter Branch Description',
        /*
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('custom_string', 'abc')
          ..addCustomMetadata('custom_number', 12345)
          ..addCustomMetadata('custom_bool', true)
          ..addCustomMetadata('custom_list_number', [1, 2, 3, 4, 5])
          ..addCustomMetadata('custom_list_string', ['a', 'b', 'c']),
         */
        //contentMetadata: metadata,
        keywords: ['Plugin', 'Branch', 'Flutter'],
        publiclyIndex: true,
        locallyIndex: true,
        expirationDateInMilliSec: DateTime.now()
            .add(const Duration(days: 365))
            .millisecondsSinceEpoch);

    lp = BranchLinkProperties(
        channel: 'facebook',
        feature: 'sharing',
        //parameter alias
        //Instead of our standard encoded short url, you can specify the vanity alias.
        // For example, instead of a random string of characters/integers, you can set the vanity alias as *.app.link/devonaustin.
        // Aliases are enforced to be unique** and immutable per domain, and per link - they cannot be reused unless deleted.
        //alias: 'https://branch.io' //define link url,
        stage: 'new share',
        campaign: 'campaign',
        tags: ['one', 'two', 'three'])
      ..addControlParam('\$uri_redirect_mode', '1')
      ..addControlParam('referring_user_id', 'user_id');

    eventStandart = BranchEvent.standardEvent(BranchStandardEvent.ADD_TO_CART)
      //--optional Event data
      ..transactionID = '12344555'
      ..currency = BranchCurrencyType.BRL
      ..revenue = 1.5
      ..shipping = 10.2
      ..tax = 12.3
      ..coupon = 'test_coupon'
      ..affiliation = 'test_affiliation'
      ..eventDescription = 'Event_description'
      ..searchQuery = 'item 123'
      ..adType = BranchEventAdType.BANNER
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');

    eventCustom = BranchEvent.customEvent('Custom_event')
      ..addCustomData(
          'Custom_Event_Property_Key1', 'Custom_Event_Property_val1')
      ..addCustomData(
          'Custom_Event_Property_Key2', 'Custom_Event_Property_val2');
  }

  @override
  void dispose() {
    super.dispose();
    controllerData.close();
    controllerInitSession.close();
    streamSubscription?.cancel();
  }
}
