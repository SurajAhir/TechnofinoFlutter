import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreads.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/nodes_related_classes/ShowImage.dart';
import '../../data_classes/login_response/UserData.dart';
import '../../data_classes/thread_response/Threads.dart';
import '../../data_classes/attachment_response/AttachmentsData.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../services/ApiClient.dart';
import 'package:html/parser.dart' show parse;
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import '../MyWebView.dart';
import '../ReportContent.dart';
import '../user_profile/UserProfile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import 'ExpandedReplyForPostsOfThreads.dart';
import 'ReplyOnPostsOfThreads.dart';
import 'package:html/dom.dart' as dom;
class ShowPostsOfThreads extends StatefulWidget {
  String title;
  String appBarTitle;
  Threads threads;
  int page = 1;
  String anotherTitle;

  ShowPostsOfThreads(
      this.title, this.appBarTitle, this.threads, this.page, this.anotherTitle,
      {Key? key})
      : super(key: key);

  @override
  State<ShowPostsOfThreads> createState() => _ShowPostsOfThreadsState();
}

class _ShowPostsOfThreadsState extends State<ShowPostsOfThreads> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Pagination? pagination;
  int page = 1;
  List<PostsOfThreads> posts = [];
  var firsLoading = true;
  var isReacted = false;
  int newReactionId = 1;
  int prevIndex = 0;
  List<AttachmentsData> attachmentList = [];
  String attachmentKey = "";
  var isGeneratedAttachmentKey = false;
  var _messageControllar = TextEditingController();
  var focusNode = FocusNode();

  @override
  initState() {
    super.initState();
    if (widget.anotherTitle.isNotEmpty) {
      getData(widget.page);
    } else {
      getData(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
        // backgroundColor: Theme.of(context).bottomAppBarColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          title: Text(
            "${widget.threads.title}",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          actions: [
            InkWell(
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
                          height: 50,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).bottomAppBarColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // InkWell(
                              //     onTap: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //               builder: (context) =>
                              //               const ReportContent()));
                              //     },
                              //     child: Text("report".tr)),
                              InkWell(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyWebView(
                                                widget.threads.view_url)));
                                  },
                                  child: Text("open_in_browser".tr))
                            ],
                          ))
                      //create a custom widget as you want
                      );
                },
                child: Image.asset("assets/icons/toolbar.png",
                    width: 24,
                    height: 24,
                    color: Theme.of(context).accentColor))
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Stack(
            children: [
              Column(
                children: <Widget>[
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
                            child: Column(
                              children: [
                                Container(
                                  height: 30,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.all(6),
                                    children: [
                                      Icon(
                                        Icons.home,
                                        size: 15,
                                      ),
                                      Text(
                                        "${widget.title} ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      if (widget.appBarTitle.isNotEmpty)
                                        Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          size: 15,
                                        ),
                                      Text(
                                        " ${widget.appBarTitle}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      if (widget.anotherTitle.isNotEmpty)
                                        Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          size: 15,
                                        ),
                                      Text(
                                        " ${widget.anotherTitle}",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 8),
                                    color: Theme.of(context).bottomAppBarColor,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 60,
                                          color: Theme.of(context)
                                              .bottomAppBarColor,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10, bottom: 5),
                                          margin: EdgeInsets.all(0),
                                          child: Row(
                                            children: [
                                              widget.threads.User!.avatar_urls.o
                                                      .toString()
                                                      .isNotEmpty
                                                  ? InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    UserProfile(widget
                                                                            .threads
                                                                            .User
                                                                        as UserData)));
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: provider
                                                                .darkTheme
                                                            ? Colors.white
                                                            : Colors
                                                                .lightBlueAccent,
                                                        backgroundImage:
                                                            NetworkImage(widget
                                                                .threads
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
                                                                    UserProfile(widget
                                                                            .threads
                                                                            .User
                                                                        as UserData)));
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: provider
                                                                .darkTheme
                                                            ? Colors.white
                                                            : Colors
                                                                .lightBlueAccent,
                                                        child: Text(
                                                            "${widget.threads.User!.username.toString().substring(0, 1)}"),
                                                      ),
                                                    ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserProfile(widget
                                                                        .threads
                                                                        .User
                                                                    as UserData)));
                                                  },
                                                  child: Text(
                                                    widget
                                                        .threads.User!.username,
                                                    style: TextStyle(
                                                        color: Theme.of(context).accentColor,fontWeight: FontWeight.bold),
                                                  )),
                                              Expanded(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "#${1} ${readTimestamp(widget.threads.post_date.toInt())}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: provider
                                                                .darkTheme
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
                                            margin: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                                color: Theme.of(context)
                                                    .bottomAppBarColor),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(widget.threads.title,style: TextStyle(
                                                    color: Theme.of(context).accentColor,
                                                    fontWeight: FontWeight.bold
                                                ),),
                                                SizedBox(height: 8,),
                                                // Text(widget.thread)
                                              ],
                                            )),
                                      ],
                                    )),
                                Container(
                                  color: provider.darkTheme
                                      ? Colors.black
                                      : Colors.black12,
                                  child:
                                      Provider.of<MyProvider>(context)
                                                  .isFirstLoadingPosts ||
                                              firsLoading
                                          ? Center(
                                              child: CircularProgressIndicator(
                                                  color: Colors.red),
                                            )
                                          : ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                if (posts[index]
                                                        .message_state ==
                                                    "visible") {
                                                  return Container(
                                                      margin: EdgeInsets.only(
                                                          top: 8),
                                                      color: Theme.of(context)
                                                          .bottomAppBarColor,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            height: 60,
                                                            color: Theme.of(
                                                                    context)
                                                                .bottomAppBarColor,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    bottom: 5),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0),
                                                            child: Row(
                                                              children: [
                                                                posts[index]
                                                                        .User!
                                                                        .avatar_urls
                                                                        .o
                                                                        .toString()
                                                                        .isNotEmpty
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => UserProfile(posts[index].User as UserData)));
                                                                        },
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor: provider.darkTheme
                                                                              ? Colors.white
                                                                              : Colors.lightBlueAccent,
                                                                          backgroundImage: NetworkImage(posts[index]
                                                                              .User!
                                                                              .avatar_urls
                                                                              .o),
                                                                        ),
                                                                      )
                                                                    : InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => UserProfile(posts[index].User as UserData)));
                                                                        },
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor: provider.darkTheme
                                                                              ? Colors.white
                                                                              : Colors.lightBlueAccent,
                                                                          child:
                                                                              Text("${posts[index].User!.username.toString().substring(0, 1)}"),
                                                                        ),
                                                                      ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                InkWell(
                                                                    onTap: () {
                                                                      Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => UserProfile(posts[index].User as UserData)));
                                                                    },
                                                                    child: Text(
                                                                      posts[index]
                                                                          .User!
                                                                          .username,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Theme.of(context).accentColor,fontWeight: FontWeight.bold),
                                                                    )),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    child: Text(
                                                                      "#${index + 2} ${readTimestamp(posts[index].post_date.toInt())}",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color: provider.darkTheme
                                                                              ? Color(0xffe4dddd)
                                                                              : Colors.black54),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          // Container(
                                                          //   height:60,
                                                          //   color: Theme.of(context).bottomAppBarColor,
                                                          //   child: ListTile(
                                                          //     leading:
                                                          //     posts[index]
                                                          //         .User!
                                                          //         .avatar_urls
                                                          //         .o
                                                          //         .toString()
                                                          //         .isNotEmpty
                                                          //         ? InkWell(
                                                          //       onTap: () {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) =>
                                                          //                     UserProfile(
                                                          //                         posts[index].User
                                                          //                         as UserData)));
                                                          //       },
                                                          //       child: CircleAvatar(
                                                          //         backgroundColor: provider
                                                          //             .darkTheme
                                                          //             ? Colors.white
                                                          //             : Colors
                                                          //             .lightBlueAccent,
                                                          //         backgroundImage:
                                                          //         NetworkImage(posts[
                                                          //         index]
                                                          //             .User!
                                                          //             .avatar_urls
                                                          //             .o),
                                                          //       ),
                                                          //     )
                                                          //         : InkWell(
                                                          //       onTap: () {
                                                          //         Navigator.push(
                                                          //             context,
                                                          //             MaterialPageRoute(
                                                          //                 builder: (context) =>
                                                          //                     UserProfile(
                                                          //                         posts[index].User
                                                          //                         as UserData)));
                                                          //       },
                                                          //       child: CircleAvatar(
                                                          //         backgroundColor: provider
                                                          //             .darkTheme
                                                          //             ? Colors.white
                                                          //             : Colors
                                                          //             .lightBlueAccent,
                                                          //         child: Text(
                                                          //             "${posts[index].User!.username.toString().substring(0, 1)}"),
                                                          //       ),
                                                          //     ),
                                                          //     title: InkWell(
                                                          //         onTap: (){
                                                          //           Navigator.push(
                                                          //               context,
                                                          //               MaterialPageRoute(
                                                          //                   builder: (context) =>
                                                          //                       UserProfile(
                                                          //                           posts[index].User
                                                          //                           as UserData)));
                                                          //         },
                                                          //         child: Text(posts[index].User!.username,style: TextStyle(color: Colors.red),)),
                                                          //     trailing: Expanded(
                                                          //       child: Text(
                                                          //           "#${index+1} ${readTimestamp(posts[index].post_date.toInt())}"
                                                          //               ,style: TextStyle(fontSize: 10,color: provider.darkTheme?Color(0xffe4dddd):Colors.black54),
                                                          //       ),
                                                          //     ),
                                                          //   ),
                                                          // ),
                                                          Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5),
                                                              margin: EdgeInsets
                                                                  .all(0),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6)),
                                                                  color: Theme.of(
                                                                          context)
                                                                      .bottomAppBarColor),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Html(
                                                                    data: getFilteredMessage(
                                                                        posts[index]
                                                                            .message_parsed,
                                                                        posts[
                                                                            index]),
                                                                    style: {
                                                                      "body":
                                                                          Style(
                                                                        fontSize:
                                                                            FontSize(16),
                                                                      ),
                                                                      "table":
                                                                          Style(
                                                                        fontFamily:
                                                                            "arial, sans-serif",
                                                                        backgroundColor:
                                                                            Theme.of(context).accentColor,
                                                                      ),
                                                                      "blockquote":
                                                                          Style(
                                                                        border:
                                                                            const Border(
                                                                          left: BorderSide(
                                                                              color: Colors.lightBlueAccent,
                                                                              width: 2.0,
                                                                              style: BorderStyle.solid),
                                                                        ),
                                                                        padding: const EdgeInsets.only(
                                                                            left:
                                                                                10,
                                                                            top:
                                                                                4,
                                                                            bottom:
                                                                                5),
                                                                        margin: const EdgeInsets.only(
                                                                            left:
                                                                                7,
                                                                            bottom:
                                                                                30),
                                                                        backgroundColor: provider.darkTheme
                                                                            ? Colors.transparent
                                                                            : Color(0xffe5f6f4),
                                                                      ),
                                                                      // "tr": Style(
                                                                      //   border: const Border(
                                                                      //       bottom: BorderSide(
                                                                      //           color: Colors
                                                                      //               .grey)),
                                                                      // ),
                                                                      "th":
                                                                          Style(
                                                                        padding:
                                                                            EdgeInsets.all(6),
                                                                        backgroundColor:
                                                                            Colors.grey,
                                                                        border: Border.all(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      "td":
                                                                          Style(
                                                                        backgroundColor:
                                                                            Theme.of(context).bottomAppBarColor,
                                                                        padding:
                                                                            EdgeInsets.all(6),
                                                                        border: Border.all(
                                                                            color:
                                                                                Theme.of(context).accentColor),
                                                                      ),
                                                                      'h5': Style(
                                                                          maxLines:
                                                                              2,
                                                                          textOverflow:
                                                                              TextOverflow.ellipsis),
                                                                    },
                                                                    customRender: {
                                                                      "table":
                                                                          (context,
                                                                              child) {
                                                                        return SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          child:
                                                                              (context.tree as TableLayoutElement).toWidget(context),
                                                                        );
                                                                      },
                                                                    },
                                                                    onLinkTap:
                                                                        (url,
                                                                        RenderContext context1, Map<String, String> attributes, dom.Element? element) async {
                                                                      debugPrint(
                                                                          "Opening ${element?.text.toString()}");
                                                                      var username=element?.text.toString().replaceAll("@","");
                                                                      var user =
                                                                          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                                                                          .findUserByName(MyDataClass.api_key,username.toString());
                                                                      var userData=user.exact;
                                                                      if(userData!=null){
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) =>
                                                                                    UserProfile(userData
                                                                                    )));
                                                                      }else{
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                                builder: (context) => MyWebView(url.toString())));
                                                                      }
                                                                    },
                                                                    onImageTap:
                                                                        (src,
                                                                            _,
                                                                            __,
                                                                            ___) {
                                                                      debugPrint(
                                                                          src);
                                                                      var att =
                                                                          posts[index]
                                                                              .Attachments;
                                                                      att?.forEach(
                                                                          (element) {
                                                                        if (src ==
                                                                            element.thumbnail_url) {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => ShowImage(element.attachment_id)));
                                                                        }
                                                                      });
                                                                    },
                                                                  )
                                                                ],
                                                              )),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8,
                                                                    left: 10,
                                                                    bottom: 6),
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            6))),
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Stack(
                                                              children: [
                                                                // if (posts[index]
                                                                //     .tapi_reactions !=
                                                                //     null &&
                                                                //     posts[index]
                                                                //         .tapi_reactions!
                                                                //         .length >
                                                                //         0)
                                                                //   Container(
                                                                //     width:
                                                                //     MediaQuery.of(context)
                                                                //         .size
                                                                //         .width,
                                                                //     decoration: BoxDecoration(
                                                                //         borderRadius:
                                                                //         BorderRadius.all(
                                                                //             Radius.circular(
                                                                //                 6))),
                                                                //     alignment:
                                                                //     Alignment.centerRight,
                                                                //     child: Container(
                                                                //       color: Colors.white,
                                                                //       padding: EdgeInsets.only(
                                                                //           bottom: 5,
                                                                //           left: 5,
                                                                //           right: 5),
                                                                //       transform: Matrix4
                                                                //           .translationValues(
                                                                //           0.0, -20.0, 0.0),
                                                                //       decoration: const BoxDecoration(
                                                                //           borderRadius:
                                                                //           BorderRadius.only(
                                                                //               bottomRight: Radius
                                                                //                   .circular(
                                                                //                   20),
                                                                //               bottomLeft: Radius
                                                                //                   .circular(
                                                                //                   20)),
                                                                //           color: Colors.white),
                                                                //       child: checkUsersReaction(
                                                                //           context,
                                                                //           posts[
                                                                //           index]), //***********************************************************
                                                                //     ),
                                                                //   ),
                                                                // if (posts[index]
                                                                //     .tapi_reactions ==
                                                                //     null &&
                                                                //     posts[index]
                                                                //         .reaction_score >
                                                                //         1)
                                                                //   Container(
                                                                //     transform: Matrix4
                                                                //         .translationValues(
                                                                //         0.0, -20.0, 0.0),
                                                                //     width:
                                                                //     MediaQuery.of(context)
                                                                //         .size
                                                                //         .width,
                                                                //     decoration: BoxDecoration(
                                                                //         borderRadius:
                                                                //         BorderRadius.all(
                                                                //             Radius.circular(
                                                                //                 6))),
                                                                //     alignment:
                                                                //     Alignment.centerRight,
                                                                //     child: Container(
                                                                //       width: 30,
                                                                //       height: 30,
                                                                //       decoration: BoxDecoration(
                                                                //         color: Colors.white,
                                                                //         borderRadius:
                                                                //         BorderRadius.all(
                                                                //             Radius.circular(
                                                                //                 50)),
                                                                //       ),
                                                                //       child: Row(
                                                                //         children: [
                                                                //           CircleAvatar(
                                                                //             backgroundColor:
                                                                //             Colors.white,
                                                                //             radius: 7,
                                                                //             child: Icon(
                                                                //               CupertinoIcons
                                                                //                   .hand_thumbsup,
                                                                //               color: Colors
                                                                //                   .blueAccent,
                                                                //               size: 10,
                                                                //             ),
                                                                //           ),
                                                                //           Text(
                                                                //             "${posts[index].reaction_score}",
                                                                //             style: TextStyle(
                                                                //                 color: Colors
                                                                //                     .blueAccent,
                                                                //                 fontSize: 10),
                                                                //           ),
                                                                //           SizedBox(
                                                                //             width: 2,
                                                                //           )
                                                                //         ],
                                                                //       ), //***********************************************************
                                                                //     ),
                                                                //   ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              5),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            4,
                                                                      ),
                                                                      if (MyDataClass
                                                                          .isUserLoggedIn)
                                                                        InkWell(
                                                                            onTap:
                                                                                () {
                                                                              prevIndex = index;
                                                                              react(1, posts[index].post_id);
                                                                            },
                                                                            onLongPress:
                                                                                () {
                                                                              showDialogBox(context, posts[index].post_id);
                                                                            },
                                                                            child:
                                                                                isReactedTo(context, posts[index]) //:nowIsReacted(context,newReactionId,index)
                                                                            ),
                                                                      Text(
                                                                        " " +
                                                                            posts[index].reaction_score.toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12),
                                                                      ),
                                                                      //*********************************************************** Provider.of<MyProvider>(context).isReacted==false?
                                                                      if (MyDataClass
                                                                          .isUserLoggedIn)
                                                                        SizedBox(
                                                                          width:
                                                                              4,
                                                                        ),
                                                                      InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            await Share.share(posts[index].view_url.toString());
                                                                          },
                                                                          child: Text(
                                                                              " • " + "share".tr,
                                                                              style: TextStyle(fontSize: 13))),
                                                                      if (MyDataClass
                                                                          .isUserLoggedIn)
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            var message =
                                                                                posts[index].message_parsed;
                                                                            if (message.contains("<blockquote class=")) {
                                                                              var originalMessage = posts[index].message_parsed;
                                                                              message = message.substring(message.indexOf("\">") + 2);
                                                                              message = message.substring(0, message.indexOf("</blockquote>"));
                                                                              originalMessage = originalMessage.replaceAll(message, "");
                                                                              var exactString = originalMessage;
                                                                              originalMessage = originalMessage.substring(originalMessage.indexOf("<blockquote"));
                                                                              originalMessage = originalMessage.substring(0, originalMessage.indexOf("</blockquote>"));
                                                                              originalMessage = originalMessage + "</blockquote>";
                                                                              exactString = exactString.replaceAll(originalMessage, "");
                                                                              debugPrint(exactString);
                                                                              // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${exactString}[/QUOTE]";4
                                                                              var realMessage = "<body>${exactString}</body>";
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ReplyOnPostsOfThreads(posts[index], realMessage))).then((value) {
                                                                                getData(page);
                                                                              });
                                                                            } else {
                                                                              // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${message}[/QUOTE]";
                                                                              var realMessage = "<body>${message}</body>";
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ReplyOnPostsOfThreads(posts[index], realMessage))).then((value) {
                                                                                getData(page);
                                                                              });
                                                                            }
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            " • " +
                                                                                "reply".tr,
                                                                            style:
                                                                                TextStyle(fontSize: 13),
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ));
                                                } else {
                                                  return SizedBox();
                                                }
                                              },
                                              itemCount: posts.length,
                                            ),
                                ),
                                provider.isPaginationAval == true &&
                                        firsLoading == false
                                    ? Container(
                                        color: provider.darkTheme
                                            ? Colors.black
                                            : Colors.black12,
                                        height: 100,
                                        alignment: Alignment.topCenter,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Transform.rotate(
                                                angle: 180 * math.pi / 180,
                                                child: InkWell(
                                                    onTap: () {
                                                      if (page == 1) {
                                                        return;
                                                      } else {
                                                        provider
                                                            .setisFirstLoadingPosts(
                                                                true);
                                                        // setState((){
                                                        //   firsLoading=true;
                                                        // });
                                                        page = 1;
                                                        getData(page);
                                                      }
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .double_arrow_rounded,
                                                      size: 30,
                                                    ))),
                                            Transform.rotate(
                                              angle: 180 * math.pi / 180,
                                              child: InkWell(
                                                  onTap: () {
                                                    if (page == 1) {
                                                      return;
                                                    } else {
                                                      provider
                                                          .setisFirstLoadingPosts(
                                                              true);
                                                      // setState((){
                                                      //   firsLoading=true;
                                                      // });
                                                      page--;
                                                      getData(page);
                                                    }
                                                  },
                                                  child: const Icon(
                                                      Icons
                                                          .keyboard_arrow_right_outlined,
                                                      size: 30)),
                                            ),
                                            Text("${pagination?.current_page}",
                                                style: TextStyle(fontSize: 16)),
                                            const Text(
                                              "/",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text("${pagination?.last_page}",
                                                style: TextStyle(fontSize: 16)),
                                            InkWell(
                                                onTap: () {
                                                  if (page ==
                                                      pagination?.last_page) {
                                                    return;
                                                  } else {
                                                    // setState((){
                                                    //   firsLoading=true;
                                                    // });
                                                    provider
                                                        .setisFirstLoadingPosts(
                                                            true);
                                                    // Provider.of<MyProvider>(context,
                                                    //         listen: false)
                                                    //     .setisFirstLoadingPosts(true);
                                                    page++;
                                                    getData(page);
                                                  }
                                                },
                                                child: const Icon(
                                                    Icons
                                                        .keyboard_arrow_right_outlined,
                                                    size: 30)),
                                            InkWell(
                                                onTap: () {
                                                  if (page ==
                                                      pagination?.last_page) {
                                                    return;
                                                  } else {
                                                    provider
                                                        .setisFirstLoadingPosts(
                                                            true);
                                                    // setState((){
                                                    //   firsLoading=true;
                                                    // });
                                                    page =
                                                        pagination?.last_page ??
                                                            1;
                                                    getData(page);
                                                  }
                                                },
                                                child: const Icon(
                                                    Icons.double_arrow_rounded,
                                                    size: 30)),
                                            const SizedBox(
                                              height: 50,
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(height: 60),
                                if (provider.isPaginationAval == true)
                                  SizedBox(
                                    height: 8,
                                  )
                              ],
                            ),
                          ))),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (isGeneratedAttachmentKey)
                    Material(
                      elevation: 15,
                      child: Container(
                        height: 70,
                        color: provider.darkTheme
                            ? Colors.black54
                            : Colors.black12,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Widget cancelButton = TextButton(
                                  child: Text("cancel".tr),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                );
                                Widget okButton = TextButton(
                                  child: Text("ok".tr),
                                  onPressed: () {
                                    attachmentList.removeAt(index);
                                    Navigator.pop(context);
                                    if (attachmentList.isEmpty) {
                                      isGeneratedAttachmentKey = false;
                                      attachmentKey = "";
                                    }
                                    setState(() {});
                                  },
                                );
                                AlertDialog alert = AlertDialog(
                                  title: Text("delete".tr),
                                  content:
                                      Text("${attachmentList[index].filename}"),
                                  actions: [
                                    cancelButton,
                                    okButton,
                                  ],
                                );

                                // show the dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return showDialogForImage(
                                        attachmentList, index);
                                  },
                                );
                              },
                              child: attachmentList[index]
                                          .filename
                                          .contains(".pdf") ||
                                      attachmentList[index]
                                          .filename
                                          .contains(".txt")
                                  ? Container(
                                      width: 60,
                                      height: 60,
                                      alignment: Alignment.center,
                                      color: provider.darkTheme
                                          ? Colors.white
                                          : Colors.black38,
                                      child: Expanded(
                                          child: Icon(
                                        CupertinoIcons.doc_on_clipboard_fill,
                                        size: 50,
                                      )),
                                    )
                                  : Image(
                                      image: NetworkImage(
                                          attachmentList[index].thumbnail_url)),
                            );
                          },
                          itemCount: attachmentList.length,
                        ),
                      ),
                    ),
                  MyDataClass.isUserLoggedIn
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          child: Material(
                            elevation: 15,
                            child: Container(
                              color: provider.darkTheme
                                  ? Colors.black54
                                  : Colors.black12,
                              padding: EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 2,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: Theme.of(context)
                                              .bottomAppBarColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10))),
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: 200,
                                              color: Theme.of(context)
                                                  .bottomAppBarColor,
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                      onTap: () async {
                                                        var status =
                                                            await Permission
                                                                .photos;
                                                        if (await status
                                                            .isGranted) {
                                                          getPhoto();
                                                        } else {
                                                          status.request();
                                                        }
                                                      },
                                                      child: Text(
                                                        "photo".tr,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor),
                                                      )),
                                                  InkWell(
                                                      onTap: () async {
                                                        var status =
                                                            await Permission
                                                                .camera;
                                                        if (await status
                                                            .isGranted) {
                                                          getPhotoFromCamera();
                                                        } else {
                                                          status.request();
                                                        }
                                                      },
                                                      child: Text(
                                                        "take_photo".tr,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor),
                                                      )),
                                                  InkWell(
                                                      onTap: () async {
                                                        var status =
                                                            await Permission
                                                                .storage;
                                                        if (await status
                                                            .isGranted) {
                                                          getFile();
                                                        } else {
                                                          status.request();
                                                        }
                                                      },
                                                      child: Text(
                                                        "file".tr,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor),
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ExpandedReplyForPostsOfThreads(
                                                                        widget
                                                                            .threads)));
                                                      },
                                                      child: Text(
                                                        "expanded_editor".tr,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor),
                                                      )),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.link,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 4, right: 4),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: TextField(
                                        controller: _messageControllar,
                                        focusNode: focusNode,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                            hintText:
                                                "write_a_comment".tr + "...",
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none),
                                        textInputAction:
                                            TextInputAction.newline,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 1,
                                        maxLines: null,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_messageControllar.text.isNotEmpty) {
                                        postReply(
                                            context, _messageControllar.text);
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.orange,
                                      child: Icon(Icons.send,
                                          color:Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 2, right: 2, bottom: 2),
                          height: 45,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, "/login");
                            },
                            icon: Icon(Icons.login),
                            label: Text(
                              "Log in",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                ],
              )
            ],
          ),
        ));
  }

  String readTimestamp(int lastActivityData) {
    debugPrint("time");
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(lastActivityData * 1000);
    String time = "";
    if (now.year == date.year) {
      if (date.month == now.month) {
        if (date.day == now.day) {
          if (date.hour == now.hour) {
            if (now.minute - date.minute < 2) {
              time = "a moment";
            } else {
              time = "${now.minute - date.minute} m";
            }
          } else if (date.hour < now.hour) {
            var timeInMinuts = (now.hour - date.hour) * 60 + now.minute;
            if (timeInMinuts - date.minute < 60) {
              time = "${(timeInMinuts - date.minute).abs()} m";
            } else {
              time = "${now.hour - date.hour} h";
            }
          }
        } else {
          if (now.day - date.day < 2) {
            time = "${now.day - date.day} day";
          } else {
            time = "${now.day - date.day} day";
          }
        }
      } else {
        if (now.month - date.month < 2) {
          time = "${now.month - date.month} month";
        } else {
          time = "${now.month - date.month} month";
        }
      }
    } else {
      if ((now.year - 100) - (date.year - 100) < 2) {
        time = "${(now.year - 100) - (date.year - 100)} year";
      } else {
        time = "${(now.year - 100) - (date.year - 100)} year";
      }
    }
    return time;
  }

  getFilteredMessage(String message_parsed, PostsOfThreads post) {
    var mess = message_parsed;
    if (post.message_parsed.contains("<img")) {
      if (post.attach_count > 0) {
        var document = parse(message_parsed);
        var image = post.Attachments;
        List<String> imgThumbList = [];
        image?.forEach((element) {
          debugPrint(element.thumbnail_url);
          imgThumbList.add(element.thumbnail_url);
        });
        var imgList = document.querySelectorAll("img");
        int prev = 0;
        for (int i = 0; i < imgList.length; i++) {
          var src = imgList[i].attributes["src"];
          prev = i + 1;
          mess = mess.replaceAll(src!, imgThumbList[i]);
        }

        if (post.attach_count > imgList.length) {
          for (int i = prev; i < imgThumbList.length; i++) {
            var url = "<br /><img src='${imgThumbList[i]}'/>";
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
    return mess;
  }

  void getData(int page) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    debugPrint("getData" + widget.threads.thread_id.toString());
    try {
      var threadResponse =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .getPostsOfThreads(MyDataClass.api_key, MyDataClass.myUserId,
                  widget.threads.thread_id, page, "desc", "last_post_date");
      var pagination = threadResponse.pagination;
      if (pagination != null && pagination.last_page > 1) {
        this.pagination = pagination;
        provider.setPagination(true);
      } else {
        provider.setPagination(false);
      }
      if (_refreshController.isRefresh) {
        _refreshController.refreshCompleted();
      }
      posts.clear();
      var isMatched = false;
      if (threadResponse.pinned_post != null) {
        threadResponse.posts.forEach((element) {
          if (element.position == threadResponse.pinned_post?.position) {
            isMatched = true;
          }
        });
        if (isMatched == false) {
          posts.add(threadResponse.pinned_post as PostsOfThreads);
        }
      }
      posts.addAll(threadResponse.posts);
      provider.setisFirstLoadingPosts(false);
      setState(() {
        firsLoading = false;
      });
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.response:
          var message = "Server Error";
          break;
      }
    }
  }

  Widget isReactedTo(BuildContext context, PostsOfThreads post) {
    if (post.is_reacted_to) {
      switch (post.visitor_reaction_id) {
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
    } else {
      return Container(
        child: Row(
          children: [
            Icon(
              CupertinoIcons.hand_thumbsup,
              size: 15,
            ),
            Text(
              "like".tr,
              style:
                  TextStyle(fontSize: 13, color: Theme.of(context).accentColor),
            )
          ],
        ),
      );
    }
  }

  checkUsersReaction(BuildContext context, PostsOfThreads post) {
    return Container(
      height: 30,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 9,
                    backgroundImage: NetworkImage(
                        post.tapi_reactions![index].image.toString()),
                  ),
                  Text(
                    "${post.tapi_reactions![index].total}",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 12),
                  ),
                  SizedBox(
                    width: 3,
                  )
                ],
              ),
            ],
          );
        },
        itemCount: post.tapi_reactions!.length,
      ),
    );
  }

  void react(int reaction_id, int post_id) async {
    // var provider = Provider.of<MyProvider>(context, listen: false);
    var response =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getReaponseOfReact(MyDataClass.api_key, MyDataClass.myUserId,
                post_id, reaction_id);
    setState(() {
      getData(page);
    });
  }

  showDialogBox(BuildContext, int post_id) {
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
                  react(1, post_id);
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
                    react(2, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    "assets/icons/love_icon.png",
                    width: 35,
                    height: 35,
                  )),
              InkWell(
                  onTap: () {
                    react(3, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/haha_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    react(4, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/wow_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    react(5, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/sad_icon.png",
                      width: 35, height: 35)),
              InkWell(
                  onTap: () {
                    react(6, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/angry_icon.png",
                      width: 35, height: 35))
            ],
          )),
    );
    showDialog(context: context, builder: (context) => errorDialog);
  }

  getPhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Navigator.pop(context);
      showLoaderDialog(context, "loading".tr);
      debugPrint(image.path);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
                Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                File(image.path), attachmentKey);
        if (response1.isNotEmpty) {
          var attachment = response1["attachment"] as AttachmentsData;
          attachmentList.add(attachment);
          setState(() {
            Navigator.pop(context);
            isGeneratedAttachmentKey = true;
          });
        }
      } else {
        var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .generateAttachmentKeyForPostsOfThreads(MyDataClass.api_key,
                    MyDataClass.myUserId, widget.threads.thread_id, "post");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          var response1 = await ApiClient(
                  Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                  File(image.path), key.toString());
          if (response1.isNotEmpty) {
            var attachment = response1["attachment"] as AttachmentsData;
            attachmentList.add(attachment);
            setState(() {
              Navigator.pop(context);
              isGeneratedAttachmentKey = true;
            });
          }
        }
      }
    }
  }

  void getPhotoFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      debugPrint(image.name);
      Navigator.pop(context);
      showLoaderDialog(context, "loading".tr);
      debugPrint(image.path);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
                Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                File(image.path), attachmentKey);
        if (response1.isNotEmpty) {
          var attachment = response1["attachment"] as AttachmentsData;
          attachmentList.add(attachment);
          setState(() {
            Navigator.pop(context);
            isGeneratedAttachmentKey = true;
          });
          debugPrint(attachment.toString());
        }
      } else {
        var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .generateAttachmentKeyForPostsOfThreads(MyDataClass.api_key,
                    MyDataClass.myUserId, widget.threads.thread_id, "post");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          debugPrint(key.toString());
          var response1 = await ApiClient(
                  Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                  File(image.path), key.toString());
          if (response1.isNotEmpty) {
            var attachment = response1["attachment"] as AttachmentsData;
            attachmentList.add(attachment);
            setState(() {
              Navigator.pop(context);
              isGeneratedAttachmentKey = true;
            });
            debugPrint(attachment.toString());
          }
        }
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

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      debugPrint(file.path.toString());
      Navigator.pop(context);
      showLoaderDialog(context, "loading".tr);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
                Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                File(file.path), attachmentKey);
        if (response1.isNotEmpty) {
          var attachment = response1["attachment"] as AttachmentsData;
          attachmentList.add(attachment);
          setState(() {
            Navigator.pop(context);
            isGeneratedAttachmentKey = true;
          });
          debugPrint(attachment.toString());
        }
      } else {
        var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .generateAttachmentKeyForPostsOfThreads(MyDataClass.api_key,
                    MyDataClass.myUserId, widget.threads.thread_id, "post");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          debugPrint(key.toString());
          var response1 = await ApiClient(
                  Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                  File(file.path), key.toString());
          if (response1.isNotEmpty) {
            var attachment = response1["attachment"] as AttachmentsData;
            attachmentList.add(attachment);
            setState(() {
              Navigator.pop(context);
              isGeneratedAttachmentKey = true;
            });
            debugPrint(attachment.toString());
          }
        }
      }
    }
  }

  void postReply(BuildContext context, String message) async {
    showLoaderDialog(context, "sending".tr);
    // var gettedAttachmentString = "";
    // attachmentList.forEach((element) {
    //   gettedAttachmentString = gettedAttachmentString +
    //       r"""[ATTACH type="full"]""" +
    //       element.attachment_id.toString() +
    //       r"""[/ATTACH]""";
    // });

    var response =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getResponseOfPostsOfThreadsComments(
                MyDataClass.api_key,
                MyDataClass.myUserId,
                widget.threads.thread_id,
                message,
                attachmentKey);
    Navigator.pop(context);
    _messageControllar.text = "";
    attachmentList.clear();
    attachmentKey = "";
    isGeneratedAttachmentKey = false;
    setState(() {
      getData(page);
    });
    debugPrint(response.toString());
  }

  Dialog showDialogForImage(List<AttachmentsData> attachmentList, int index) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: () {
                var attachmentString = r"""[ATTACH type="full"]""" +
                    attachmentList[index].attachment_id.toString() +
                    r"""[/ATTACH]""";
                var mess = _messageControllar.text;
                if (!mess.contains(attachmentString)) {
                  _messageControllar.text = mess + attachmentString;
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    size: 14,
                  ),
                  Icon(Icons.image, size: 14),
                  Icon(Icons.arrow_forward_ios, size: 14),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Inline",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                debugPrint(attachmentList[index].attachment_id.toString());
                var attachmentString = r"""[ATTACH type="full"]""" +
                    attachmentList[index].attachment_id.toString() +
                    r"""[/ATTACH]""";
                var mess = _messageControllar.text;
                _messageControllar.text = mess.replaceAll(attachmentString, "");
                attachmentList.removeAt(index);
                Navigator.pop(context);
                if (attachmentList.isEmpty) {
                  isGeneratedAttachmentKey = false;
                  attachmentKey = "";
                }
                setState(() {});
                // var deleteReponse=await http.delete(Uri.parse("https://technofino.in/community/api/attachments/${attachmentList[index].attachment_id}/"));
                // var response=jsonDecode(deleteReponse.body) as Map;
                // if(response["success"]){
                //
                // }
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.delete),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Delete",
                    style: TextStyle(color: Theme.of(context).accentColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    return errorDialog;
  }
}
