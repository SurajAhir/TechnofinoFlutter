import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import '../../data_classes/user_profile_posts_response/ProfilePosts.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../MyWebView.dart';
import '../ReportContent.dart';
import '../nodes_related_classes/ShowImage.dart';
import 'ReplyOnUserProfilePosts.dart';
import 'StartConversation.dart';
import 'UpdateYourStatus.dart';
import 'WriteSomething.dart';
import 'package:html/dom.dart' as dom;
class UserProfile extends StatefulWidget {
  UserData user;

  UserProfile(this.user, {Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  RefreshController _refreshController =RefreshController(initialRefresh: false);
  final _scrollControllar = ScrollController();
  Pagination? pagination;
  int page = 1;
  List<ProfilePosts> posts = [];
  bool isLoadingPosts = false;
  var isDataAvailable = false;
var  prevIndex=0;
  @override
  initState() {
    super.initState();
    if(MyDataClass.myUserId==widget.user.user_id){
      widget.user=MyDataClass.loginResponse as UserData;
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
    var provider=Provider.of<MyProvider>(context);
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.user.username}",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                              fontSize: 18)),
                      // InkWell(
                      //   onTap: () {
                      //     showModalBottomSheet(
                      //       backgroundColor: Theme.of(context).bottomAppBarColor,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.only(
                      //               topRight: Radius.circular(10),
                      //               topLeft: Radius.circular(10)),
                      //         ),
                      //         context: context,
                      //         builder: (context) => Container(
                      //           height: 50,padding: EdgeInsets.all(10),
                      //           decoration: BoxDecoration(color:Theme.of(context).bottomAppBarColor,
                      //               borderRadius: BorderRadius.only(
                      //                   topRight: Radius.circular(10),
                      //                   topLeft: Radius.circular(10))),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               // InkWell(
                      //               //   onTap: (){
                      //               //     Navigator.push(context,MaterialPageRoute(builder: (context)=>const ReportContent()));
                      //               //     },
                      //               //   child: Text("report".tr),
                      //               // ),
                      //               SizedBox(height: 10,),
                      //              if(MyDataClass.myUserId==widget.user.user_id)
                      //                InkWell(
                      //                    onTap: (){
                      //                      showModalBottomSheet(
                      //                        backgroundColor: Theme.of(context).bottomAppBarColor,
                      //                          shape: RoundedRectangleBorder(
                      //                            borderRadius: BorderRadius.only(
                      //                                topRight: Radius.circular(10),
                      //                                topLeft: Radius.circular(10)),
                      //                          ),
                      //                          context: context,
                      //                          builder: (context) => Container(
                      //                            height: 100,padding: EdgeInsets.all(10),
                      //                            decoration: BoxDecoration(color: Theme.of(context).bottomAppBarColor,
                      //                                borderRadius: BorderRadius.only(
                      //                                    topRight: Radius.circular(10),
                      //                                    topLeft: Radius.circular(10))),
                      //                            child: Column(
                      //                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                              crossAxisAlignment: CrossAxisAlignment.start,
                      //                              children: [
                      //                                InkWell(
                      //                                  onTap: ()async{
                      //                                    var status=await Permission.photos;
                      //                                    if(await status.isGranted){
                      //                                      getPhoto(context);
                      //                                    }else{
                      //                                      status.request();
                      //                                    }
                      //
                      //                                    },
                      //                                  child: Text("choose_from_gallery".tr),
                      //                                ),
                      //                                SizedBox(height: 10,),
                      //                                InkWell(
                      //                                    onTap: ()async{
                      //                                      var status=await Permission.camera;
                      //                                      if(await status.isGranted){
                      //                                        getPhotoFromCamera(context);
                      //                                      }else{
                      //                                        status.request();
                      //                                      }
                      //
                      //                                    },
                      //                                    child: Text("take_photo".tr))
                      //                              ],
                      //                            ),
                      //                          )
                      //                        //create a custom widget as you want
                      //                      );
                      //                    },
                      //                    child: Text("update_avatar".tr)
                      //                ),
                      //             if(MyDataClass.myUserId!=widget.user.user_id)
                      //               InkWell(
                      //                   onTap: (){
                      //
                      //                   },
                      //                   child: Text("block_user".tr)
                      //               )
                      //             ],
                      //           ),
                      //         )
                      //       //create a custom widget as you want
                      //     );
                      //   },
                      //   child:  Text(
                      //     "...",
                      //     style: TextStyle(
                      //         color: Theme.of(context).accentColor,
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.bold),
                      //     textAlign: TextAlign.center,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Expanded(
                child: SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    controller: _refreshController,
                    onRefresh: () async{
                      debugPrint("refrshing...");
                      page=1;
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
                                  "${widget.user.user_title} • ${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(((widget.user.register_date) * 1000).toInt()))}",
                                  style: TextStyle(fontSize: 11),
                                ),
                              ),
                              if (MyDataClass.myUserId.toString() !=
                                  widget.user.user_id.toString())
                                MyDataClass.isUserLoggedIn?Container(
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>StartConversation(widget.user))).then((value){
                                            page=1;
                                            getData(page);
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.messenger_outline_outlined,
                                                color: Theme.of(context).accentColor,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "message".tr,
                                                style:
                                                TextStyle(color: Theme.of(context).accentColor),
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
                                ):SizedBox(height: 20,)
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
                              child:  Text(
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
                                child:Text(
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
                          MyDataClass.isUserLoggedIn?InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WriteSomething(widget.user))
                              ).then((value){
                                page=1;
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
                                  widget.user.avatar_urls.o.toString().isNotEmpty
                                      ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      "${widget.user.avatar_urls.o}",
                                    ),
                                  )
                                      : CircleAvatar(
                                    backgroundColor: Colors.lightBlueAccent,
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
                                  Text("write_something".tr+"...")
                                ],
                              ),
                            ),
                          ):SizedBox(height: 20,),
                        if (MyDataClass.myUserId.toString() ==
                            widget.user.user_id.toString())
                          MyDataClass.isUserLoggedIn?InkWell(
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
                                  widget.user.avatar_urls.o.toString().isNotEmpty
                                      ? CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      "${widget.user.avatar_urls.o}",
                                    ),
                                  )
                                      : CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.lightBlueAccent,
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
                                  Text("update_your_status".tr+"...")
                                ],
                              ),
                            ),
                          ):SizedBox(height: 20,),
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
                                    ListTile(
                                      leading: posts[index]
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
                                          backgroundColor: Colors.lightBlueAccent,
                                          child: Text(
                                              "${posts[index].User!.username.substring(0, 1)}"),
                                        ),
                                      ),
                                      title:
                                      Text("${posts[index].User!.username}"),
                                      subtitle: Text(
                                          "${readTimestamp(posts[index].User!.last_activity.toInt())}"),
                                      // trailing: MyDataClass.isUserLoggedIn?Container(
                                      //   padding: EdgeInsets.all(5),
                                      //   decoration: BoxDecoration(
                                      //       color: Colors.blueAccent,
                                      //       borderRadius: BorderRadius.all(
                                      //           Radius.circular(10))),
                                      //   child:Text(
                                      //     "follow".tr,
                                      //     style: TextStyle(color: Colors.white),
                                      //   ),
                                      // ):SizedBox(),
                                    ),
                                    Html(
                                      data: getFilteredMessage(
                                          posts[index].message_parsed,
                                          posts[index]),
                                      style: {
                                        "body": Style(
                                            fontSize: FontSize(14),
                                            padding: EdgeInsets.only(left: 6),
                                            letterSpacing: 0.5),
                                        "table": Style(
                                          backgroundColor: const Color.fromARGB(
                                              0x50, 0xee, 0xee, 0xee),
                                        ),
                                        "blockquote": Style(
                                            border: const Border(
                                              left: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 2.0,
                                                  style: BorderStyle.solid),
                                            ),
                                            padding:
                                            const EdgeInsets.only(left: 10),
                                            margin:
                                            const EdgeInsets.only(left: 7)),
                                        "tr": Style(
                                          border: const Border(
                                              bottom:
                                              BorderSide(color: Colors.grey)),
                                        ),
                                        "th": Style(
                                          padding: EdgeInsets.all(6),
                                          backgroundColor: Colors.grey,
                                          border: const Border(
                                              bottom:
                                              BorderSide(color: Colors.grey)),
                                        ),
                                        "td": Style(
                                          padding: EdgeInsets.all(6),
                                          alignment: Alignment.topLeft,
                                          border: const Border(
                                              bottom:
                                              BorderSide(color: Colors.grey)),
                                        ),
                                        'h5': Style(
                                            maxLines: 2,
                                            textOverflow: TextOverflow.ellipsis),
                                      },
                                      customRender: {
                                        "table": (context, child) {
                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: (context.tree
                                            as TableLayoutElement)
                                                .toWidget(context),
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
                                      onImageTap: (src, _, __, ___) {
                                        debugPrint(src);
                                        var att = posts[index].Attachments;
                                        att?.forEach((element) {
                                          if (src == element.thumbnail_url) {
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
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MyDataClass.isUserLoggedIn?InkWell(
                                            onTap: (){
                                              prevIndex=index;
                                              react(1, posts[index].profile_post_id);
                                            },
                                            onLongPress: (){
                                              showDialogBox(context,posts[index].profile_post_id);
                                            },
                                            child:isReactedTo(context,posts[index])//*********************************************************
                                        ):SizedBox(width: 80,),
                                        MyDataClass.isUserLoggedIn?ElevatedButton.icon(
                                          onPressed: () {
                                            var message = posts[index]
                                                .message_parsed;
                                            if (message.contains(
                                                "<blockquote class=")) {
                                              var originalMessage = posts[index]
                                                  .message_parsed;
                                              message = message.substring(
                                                  message.indexOf("\">") +
                                                      2);
                                              message = message.substring(
                                                  0, message.indexOf(
                                                  "</blockquote>"));
                                              originalMessage =
                                                  originalMessage
                                                      .replaceAll(
                                                      message, "");
                                              var exactString = originalMessage;
                                              originalMessage =
                                                  originalMessage
                                                      .substring(
                                                      originalMessage
                                                          .indexOf(
                                                          "<blockquote"));
                                              originalMessage =
                                                  originalMessage
                                                      .substring(0,
                                                      originalMessage
                                                          .indexOf(
                                                          "</blockquote>"));
                                              originalMessage =
                                                  originalMessage +
                                                      "</blockquote>";
                                              exactString =
                                                  exactString.replaceAll(
                                                      originalMessage,
                                                      "");
                                              debugPrint(exactString);
                                              // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${exactString}[/QUOTE]";4
                                              var realMessage = "<body>${exactString}</body>";
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReplyOnUserProfilePosts(
                                                              posts[index],
                                                              realMessage)))
                                                  .then((value) {
                                                posts.clear();
                                                getData(page);
                                              });
                                            } else {
                                              // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${message}[/QUOTE]";
                                              var realMessage = "<body>${message}</body>";
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReplyOnUserProfilePosts(
                                                              posts[index],
                                                              realMessage)))
                                                  .then((value) {
                                                posts.clear();
                                                getData(page);
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.messenger_outline,
                                            color: Theme.of(context).accentColor,
                                            size: 20,
                                          ),
                                          label: Text(
                                            "comment".tr,
                                            style: TextStyle(color: Theme.of(context).accentColor),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Theme.of(context).bottomAppBarColor),
                                              elevation:
                                              MaterialStateProperty.all(0),
                                              alignment: Alignment.center),
                                        ):SizedBox(width: 80),
                                        ElevatedButton.icon(
                                          onPressed: ()async {
                                            await Share.share(posts[index].view_url.toString());

                                          },
                                          icon: Icon(
                                            Icons.ios_share_rounded,
                                            color: Theme.of(context).accentColor,
                                            size: 20,
                                          ),
                                          label: Text(
                                            "share".tr,
                                            style: TextStyle(color: Theme.of(context).accentColor),
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Theme.of(context).bottomAppBarColor),
                                              elevation:
                                              MaterialStateProperty.all(0),
                                              alignment: Alignment.center),
                                        )
                                      ],
                                    ),
                                    if(posts[index].comment_count>0)
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index1) {
                                          return Container(
                                            padding: EdgeInsets.all(4),
                                            margin: EdgeInsets.only(left: 18,right: 6),
                                            decoration: BoxDecoration(
                                              color: provider.darkTheme?Colors.brown:Color(0xfff4f0f0),
                                            ),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: posts[index].LatestComments![index1]
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
                                                                  UserProfile(posts[index].LatestComments![
                                                                  index1]
                                                                      .User
                                                                  as UserData)));
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          posts[index].LatestComments![index1]
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
                                                                  UserProfile(posts[index].LatestComments![index1]                                                                      .User
                                                                  as UserData)));
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.lightBlueAccent,
                                                      child: Text(
                                                          "${posts[index].LatestComments![index1].User!.username.substring(0, 1)}"),
                                                    ),
                                                  ),
                                                  title:
                                                  Text("${posts[index].LatestComments![index1].User!.username}"),
                                                  subtitle: Text(
                                                      "${readTimestamp(posts[index].LatestComments![index1].User!.last_activity.toInt())}"),
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
                                                      posts[index].LatestComments![index1].message_parsed,
                                                      posts[index].LatestComments![index1]),
                                                  style: {
                                                    "body": Style(
                                                        fontSize: FontSize(14),
                                                        padding: EdgeInsets.only(left: 6),
                                                        letterSpacing: 0.5),
                                                    "table": Style(
                                                      backgroundColor: const Color.fromARGB(
                                                          0x50, 0xee, 0xee, 0xee),
                                                    ),
                                                    "blockquote": Style(
                                                        border: const Border(
                                                          left: BorderSide(
                                                              color: Colors.lightBlueAccent,
                                                              width: 2.0,
                                                              style: BorderStyle.solid),
                                                        ),
                                                        padding:
                                                        const EdgeInsets.only(left: 10),
                                                        margin:
                                                        const EdgeInsets.only(left: 7)),
                                                    "tr": Style(
                                                      border: const Border(
                                                          bottom:
                                                          BorderSide(color: Colors.grey)),
                                                    ),
                                                    "th": Style(
                                                      padding: EdgeInsets.all(6),
                                                      backgroundColor: Colors.grey,
                                                      border: const Border(
                                                          bottom:
                                                          BorderSide(color: Colors.grey)),
                                                    ),
                                                    "td": Style(
                                                      padding: EdgeInsets.all(6),
                                                      alignment: Alignment.topLeft,
                                                      border: const Border(
                                                          bottom:
                                                          BorderSide(color: Colors.grey)),
                                                    ),
                                                    'h5': Style(
                                                        maxLines: 2,
                                                        textOverflow: TextOverflow.ellipsis),
                                                  },
                                                  customRender: {
                                                    "table": (context, child) {
                                                      return SingleChildScrollView(
                                                        scrollDirection: Axis.horizontal,
                                                        child: (context.tree
                                                        as TableLayoutElement)
                                                            .toWidget(context),
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
                                                  onImageTap: (src, _, __, ___) {
                                                    debugPrint(src);
                                                    var att = posts[index].LatestComments![index1].Attachments;
                                                    att?.forEach((element) {
                                                      if (src == element.thumbnail_url) {
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
                                                 padding:EdgeInsets.only(left: 10),
                                                 child: InkWell(
                                                     onTap: (){
                                                       prevIndex=index1;
                                                       reactOnComment(1, posts[index].LatestComments![index1].profile_post_comment_id);
                                                     },
                                                     onLongPress: (){
                                                       showDialogBox(context,posts[index].LatestComments![index1].profile_post_id);
                                                     },
                                                     child:isReactedTo(context,posts[index].LatestComments![index1])//*********************************************************
                                                 ),
                                               ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  color: Colors.black12,
                                                  height: 1,
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: posts[index].LatestComments!.length,
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
                )
              )
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
    var threadResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getProfilePosts(
                MyDataClass.api_key, MyDataClass.myUserId, widget.user.user_id);
    pagination = threadResponse.pagination;
    if(_refreshController.isRefresh){
      if(threadResponse.profile_posts.isNotEmpty){
        posts.clear();
      }
      _refreshController.refreshCompleted();
    }
    posts.clear();
    posts.addAll(threadResponse.profile_posts);
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
    if (post.message_parsed.contains("<img")) {
      if (post.attach_count > 0) {
        var document = parse(message_parsed);
        var image = post.Attachments;
        List<String> imgThumbList = [];
        image?.forEach((element) {
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

  Widget nowIsReacted(BuildContext context,int nowReactionId, int index){
    debugPrint("index "+index.toString());
    switch (nowReactionId) {
      case 0:
        return Container(
          child: Row(
            children: [
              Icon(
                CupertinoIcons
                    .hand_thumbsup,
                size: 15,
              ),
              Text(
                "like".tr+" •",
                style: TextStyle(
                    fontSize: 13, color: Theme.of(context).accentColor),
              )
            ],
          ),
        );
      case 1:
        return Container(
          child: Row(
            children: [
              Icon(
                CupertinoIcons
                    .hand_thumbsup_fill, color: Colors.blueAccent,
                size: 15,
              ),
              Text(
                "like".tr+" •",
                style: TextStyle(
                    fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );
      case 2:

        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/love_icon.png", width: 24, height: 24,),
              Text(
                "love".tr+" •",
                style: TextStyle(
                    fontSize: 13, color: Colors.redAccent),
              )
            ],
          ),
        );

      case 3:

        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/haha_icon.png", width: 24, height: 24,),
              Text(
                "Haha •",
                style: TextStyle(
                    fontSize: 13, color: Colors.yellow),
              )
            ],
          ),
        );


      case 4:

        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/wow_icon.png", width: 24, height: 24,),
              Text(
                "Wow •",
                style: TextStyle(
                    fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );


      case 5:

        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/sad_icon.png", width: 24, height: 24,),
              Text(
                "sad".tr+" •",
                style: TextStyle(
                    fontSize: 13, color: Colors.orange),
              )
            ],
          ),
        );


      case 6:

        return Container(
          child: Row(
            children: [
              Image.asset(
                "assets/icons/angry_icon.png", width: 24, height: 24,),
              Text(
                "angry".tr+" •",
                style: TextStyle(
                    fontSize: 13, color: Colors.blueAccent),
              )
            ],
          ),
        );


      default:

        return Container(
          child: Row(
            children: [
              Icon(CupertinoIcons.hand_thumbsup, size: 15,),
              Text(
                "like".tr+" •",
                style: TextStyle(
                    fontSize: 13, color: Theme.of(context).accentColor),
              )
            ],
          ),
        );

    }
  }

  void react(int reaction_id,int post_id) async {
    // var provider = Provider.of<MyProvider>(context, listen: false);
    debugPrint("profilepostid"+post_id.toString());
    var response =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .getResponseOfProfilePostsReact(MyDataClass.api_key,MyDataClass.myUserId,post_id,reaction_id);
    setState((){
      getData(page);
    });
  }

  void reactOnComment(int reaction_id,int post_id) async {
    // var provider = Provider.of<MyProvider>(context, listen: false);
    debugPrint("profilepostid"+post_id.toString());
    var response =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .getResponseOfProfilePostsOfCommentsReact(MyDataClass.api_key,MyDataClass.myUserId,post_id,reaction_id);
    setState((){
      getData(page);
    });
  }

  showDialogBox(BuildContext, int post_id){
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
          height: 50,
          width: 300.0,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  react(1, post_id);
                  Navigator.pop(context);
                },
                child: CircleAvatar(radius: 18,
                    child: Icon(CupertinoIcons.hand_thumbsup_fill,color: Colors.white,size: 22,)),
              ),
              InkWell(
                  onTap: (){
                    react(2, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/love_icon.png",width: 35,height: 35,)),
              InkWell(
                  onTap: (){
                    react(3, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/haha_icon.png",width: 35,height: 35)),
              InkWell(
                  onTap: (){
                    react(4, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/wow_icon.png",width: 35,height: 35)),
              InkWell(
                  onTap: (){
                    react(5, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/sad_icon.png",width: 35,height: 35)),
              InkWell(
                  onTap: (){
                    react(6, post_id);
                    Navigator.pop(context);
                  },
                  child: Image.asset("assets/icons/angry_icon.png",width: 35,height: 35))
            ],
          )
      ),
    );
    showDialog(context: context, builder: (context) => errorDialog);
  }

  checkUsersReaction(BuildContext context, PostsOfThreads post) {
    return Container(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: (context,index){
          return Row(
            children: [
              Row(
                children:[
                  CircleAvatar(
                    backgroundColor: Colors
                        .lightBlueAccent,
                    radius: 9,
                    backgroundImage: NetworkImage(post.tapi_reactions![index].image.toString()),
                  ),
                  Text(
                    "${post.tapi_reactions![index].total}",
                    style: TextStyle(
                        color:
                        Colors.black,
                        fontSize: 12),
                  ),
                  SizedBox(width: 3,)
                ],
              ),
            ],
          );
        },itemCount: post.tapi_reactions!.length,),
    );
  }
  Widget isReactedTo(BuildContext context,ProfilePosts post){
    debugPrint(post.is_reacted_to.toString());
    debugPrint(post.visitor_reaction_id.toString());
    if(post.is_reacted_to) {
      switch (post.visitor_reaction_id) {
        case 1:
          return Container(
            child: Row(
              children: [
                Icon(
                  CupertinoIcons
                      .hand_thumbsup_fill, color: Colors.blueAccent,
                  size: 16,
                ),
                SizedBox(width: 2,),
                Text(
                  "like".tr,
                  style: TextStyle(
                      fontSize: 16, color: Colors.blueAccent),
                )
              ],
            ),
          );
        case 2:

          return Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/love_icon.png", width: 24, height: 24,),
                SizedBox(width: 2,),
                Text(
                  "love".tr,
                  style: TextStyle(
                      fontSize: 16, color: Colors.redAccent),
                )
              ],
            ),
          );

        case 3:

          return Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/haha_icon.png", width: 24, height: 24,),
                SizedBox(width: 2,),
                Text(
                  "Haha",
                  style: TextStyle(
                      fontSize: 16, color: Colors.yellow),
                )
              ],
            ),
          );


        case 4:

          return Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/wow_icon.png", width: 24, height: 24,),
                SizedBox(width: 2,),
                Text(
                  "Wow",
                  style: TextStyle(
                      fontSize: 16, color: Colors.blueAccent),
                )
              ],
            ),
          );


        case 5:

          return Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/sad_icon.png", width: 24, height: 24,),
                Text(
                  "sad".tr,
                  style: TextStyle(
                      fontSize: 16, color: Colors.orange),
                )
              ],
            ),
          );


        case 6:

          return Container(
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/angry_icon.png", width: 24, height: 24,),
                SizedBox(width: 2,),
                Text(
                  "angry".tr,
                  style: TextStyle(
                      fontSize: 16, color: Colors.blueAccent),
                )
              ],
            ),
          );


        default:

          return Container(
            child: Row(
              children: [
                Icon(CupertinoIcons.hand_thumbsup, size: 16,),
                SizedBox(width: 2,),
                Text(
                  "like".tr,
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).accentColor),
                )
              ],
            ),
          );

      }
    }
    else{
      return Container(
        child: Row(
          children: [
            Icon(CupertinoIcons.hand_thumbsup, size: 16,),
            SizedBox(width: 2,),
            Text(
              "like".tr,
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).accentColor),
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
      showLoaderDialog(context,"loading".tr);
      debugPrint(image.path);
      var response = await ApiClient(
          Dio(BaseOptions(contentType: "multipart/form-data"))).updateUserProfileImage(MyDataClass.api_key, widget.user.user_id,File(image.path));
      if(response.success){
MyDataClass.loginResponse=response.user;
Navigator.pop(context);
Navigator.pop(context);
Navigator.pop(context);
setState((){
  widget.user=response.user;
});
      }else{
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
      showLoaderDialog(context,"loading".tr);
      debugPrint(image.path);
      var response = await ApiClient(
          Dio(BaseOptions(contentType: "multipart/form-data"))).updateUserProfileImage(MyDataClass.api_key, widget.user.user_id,File(image.path));
      if(response.success){
        MyDataClass.loginResponse=response.user;
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        setState((){
widget.user=response.user;
        });
      }else{
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }


    }
  }


  showLoaderDialog(BuildContext context,String message) {
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
}
