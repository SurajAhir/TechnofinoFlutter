import 'package:badges/badges.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreads.dart';
import 'package:technofino/data_classes/thread_response/Threads.dart';
import '../../data_classes/login_response/UserData.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import 'package:html/parser.dart' show parse;
import '../nodes_related_classes/ShowPostsOfThreads.dart';
import '../search_bar.dart';
import '../user_profile/UserProfile.dart';

class ShowHomeThreads extends StatefulWidget {
  const ShowHomeThreads({Key? key}) : super(key: key);

  @override
  State<ShowHomeThreads> createState() => _ShowHomeThreadsState();
}

class _ShowHomeThreadsState extends State<ShowHomeThreads> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _scrollControllar = ScrollController();
  List<Threads> list = [];
  List<Threads> sticky = [];
  var isLoadingThreads = false;
  var isFirstLoadingThreads = true;
  int page = 1;
  Pagination? pagination;
  int totalConversations = 0;
  var isConversationsAvail = false;

  @override
  initState() {
    super.initState();
    getData(page);
    getTotalConversationsCount();
    getCurrentTheme();
    _scrollControllar.addListener(() {
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingHomeThreads(true);
          page++;
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        } else {
          debugPrint(
              "position ${pagination!.total} and ${pagination!.current_page}");
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingHomeThreads(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: SafeArea(
        child: Container(
            color: Theme.of(context).backgroundColor,
            child: Column(
              children: [
                Container(
                  height: 45,
                  color: Theme.of(context).bottomAppBarColor,
                  padding: EdgeInsets.only(left: 5, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyDataClass.isUserLoggedIn
                          ? Text("TechnoFino Community",
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 17))
                          : Text("TechnoFino Community",
                              style: GoogleFonts.montserrat(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20)),
                      CircleAvatar(
                        backgroundColor: provider.darkTheme
                            ? Color(0xffd6d1d1)
                            : Colors.black12,
                        maxRadius: 15,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchAppBar(list)));
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                      if (MyDataClass.isUserLoggedIn == false)
                        CircleAvatar(
                          backgroundColor: provider.darkTheme
                              ? Color(0xffd6d1d1)
                              : Colors.black12,
                          maxRadius: 15,
                          child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/login");
                              },
                              child: Icon(Icons.login,
                                  color: Colors.black, size: 18)),
                        ),
                      if (MyDataClass.isUserLoggedIn)
                        CircleAvatar(
                          backgroundColor: provider.darkTheme
                              ? Color(0xffd6d1d1)
                              : Colors.black12,
                          maxRadius: 15,
                          child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/conversations");
                              },
                              child: Badge(
                                badgeContent: Text(
                                  '$totalConversations',
                                  style: TextStyle(fontSize: 9),
                                ),
                                alignment: Alignment.topRight,
                                badgeColor: Colors.orangeAccent,
                                showBadge: isConversationsAvail,
                                child: Icon(Icons.messenger_outline_sharp,
                                    color: Colors.black, size: 18),
                              )),
                        ),
                      if (MyDataClass.isUserLoggedIn)
                        CircleAvatar(
                          backgroundColor: provider.darkTheme
                              ? Color(0xffd6d1d1)
                              : Colors.black12,
                          maxRadius: 15,
                          child: MyDataClass.loginResponse!.avatar_urls.o
                                  .toString()
                                  .isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfile(
                                                        MyDataClass
                                                            .loginResponse!)))
                                        .then((value) => setState(() {}));
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(MyDataClass
                                        .loginResponse!.avatar_urls.o),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfile(
                                                        MyDataClass
                                                            .loginResponse!)))
                                        .then((value) => setState(() {}));
                                  },
                                  child: CircleAvatar(
                                    child: Text(
                                        "${MyDataClass.loginResponse!.username.substring(0, 1)}"),
                                  ),
                                ),
                        )
                    ],
                  ),
                ),
                SizedBox(height: 2,),
                if(sticky.isNotEmpty)
                  Container(
                      height: 120,
                      color: Theme.of(context).backgroundColor,
                      child:Material(
                        elevation: 15,
                        color: Theme.of(context).backgroundColor ,
                        child: ListView.builder(
                            itemBuilder: (context,index){
                              return Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Theme.of(context).bottomAppBarColor,
                                ),
                                width: 300,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    sticky[index]
                                        .User
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
                                                    UserProfile(
                                                        sticky[index].User)));
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            sticky[index].User.avatar_urls.o),
                                      ),
                                    )
                                        : InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfile(
                                                        sticky[index].User)));
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: Text(
                                          "${sticky[index].User.username.substring(
                                              0, 1)}",style: TextStyle(color: Colors.white),),
                                      ),
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              debugPrint("pressed");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ShowPostsOfThreads(
                                                              sticky[index].Forum !=
                                                                  null
                                                                  ? sticky[index]
                                                                  .Forum!
                                                                  .breadcrumbs![
                                                              0]
                                                                  .title
                                                                  .toString()
                                                                  : "",
                                                              sticky[index].Forum !=
                                                                  null
                                                                  ? sticky[index]
                                                                  .Forum!
                                                                  .title
                                                                  : "",
                                                              sticky[index],
                                                              1,
                                                              "")));
                                            },
                                            child: Container(
                                              child: Text(
                                                "${sticky[index].title}",
                                                style: TextStyle(
                                                  color: Theme.of(context).accentColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 4,),
                                          Text("${sticky[index].username}",style: TextStyle(color: provider.darkTheme?Colors.white70:Color(0xff8c8787)),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },itemCount: sticky.length,
                            scrollDirection: Axis.horizontal),
                      )
                  ),
                isFirstLoadingThreads == false
                    ? Expanded(
                        child: Scaffold(
                        backgroundColor: Colors.black12,
                        body: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: false,
                          controller: _refreshController,
                          onRefresh: () async {
                            debugPrint("refrshing...");
                            page = 1;
                            getData(page);
                          },
                          child: ListView.builder(
                            controller: _scrollControllar,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(top: 8),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).bottomAppBarColor),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: list[index]
                                              .User
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
                                                            UserProfile(
                                                                list[index]
                                                                    .User)));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    provider.darkTheme
                                                        ? Color(0xffd6d1d1)
                                                        : Colors.blueAccent,
                                                backgroundImage: NetworkImage(
                                                    list[index]
                                                        .User
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
                                                            UserProfile(
                                                                list[index]
                                                                    .User)));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    provider.darkTheme
                                                        ? Color(0xffd6d1d1)
                                                        : Colors.blueAccent,
                                                child: Text(
                                                    "${list[index].User.username.substring(0, 1)}"),
                                              ),
                                            ),
                                      title: InkWell(
                                          onTap: () {
                                            debugPrint("pressed");
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowPostsOfThreads(
                                                            list[index].Forum !=
                                                                    null
                                                                ? list[index]
                                                                    .Forum!
                                                                    .breadcrumbs![
                                                                        0]
                                                                    .title
                                                                    .toString()
                                                                : "",
                                                            list[index].Forum !=
                                                                    null
                                                                ? list[index]
                                                                    .Forum!
                                                                    .title
                                                                : "",
                                                            list[index],
                                                            1,
                                                            "")));
                                          },
                                          child: Text(list[index].username,style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold))),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${readTimestamp(list[index].post_date.toInt())} • ",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              Icon(
                                                Icons.remove_red_eye_sharp,
                                                size: 14,
                                              ),
                                              Text(
                                                "${NumberFormat.compact().format(list[index].view_count)} • ",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                              Icon(
                                                CupertinoIcons
                                                    .arrowshape_turn_up_left_fill,
                                                size: 14,
                                              ),
                                              Text(
                                                "${NumberFormat.compact().format(list[index].reply_count)}",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "${list[index].Forum!.title}",
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      trailing: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .backgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10)),
                                                ),
                                                context: context,
                                                builder: (context) => Container(
                                                    height: 60,
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .bottomAppBarColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton
                                                              .icon(
                                                            onPressed:
                                                                () async {
                                                              await Share.share(
                                                                  list[index]
                                                                      .view_url
                                                                      .toString());
                                                            },
                                                            icon: Icon(
                                                              CupertinoIcons
                                                                  .share_up,
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentColor,
                                                              size: 20,
                                                            ),
                                                            label: Text(
                                                              "share".tr,
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor),
                                                            ),
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<
                                                                        Color>(Theme.of(
                                                                            context)
                                                                        .bottomAppBarColor),
                                                                elevation:
                                                                    MaterialStateProperty
                                                                        .all(0),
                                                                alignment:
                                                                    Alignment
                                                                        .center),
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                                //create a custom widget as you want
                                                );
                                          },
                                          child: Image.asset(
                                            "assets/icons/toolbar.png",
                                            width: 20,
                                            height: 20,
                                            color:
                                                Theme.of(context).accentColor,
                                          )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        debugPrint("pressed");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowPostsOfThreads(
                                                        list[index].Forum !=
                                                                null
                                                            ? list[index]
                                                                .Forum!
                                                                .breadcrumbs![0]
                                                                .title
                                                                .toString()
                                                            : "",
                                                        list[index].Forum !=
                                                                null
                                                            ? list[index]
                                                                .Forum!
                                                                .title
                                                            : "",
                                                        list[index],
                                                        1,
                                                        "")));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 12),
                                        margin: EdgeInsets.only(top: 8,bottom: 15),
                                        child: Text(
                                          "${list[index].title}",
                                          style: TextStyle(
                                              color:
                                              Colors.blue,fontSize: 15),
                                        ),
                                      ),
                                    ),

                                    // FutureBuilder(
                                    //   builder: (ctx, snapshot) {
                                    //     if (snapshot.hasData) {
                                    //       var map = snapshot.data as Map;
                                    //       var post =
                                    //           map["post"] as PostsOfThreads;
                                    //       return Container(
                                    //         height: 80,
                                    //         child: InkWell(
                                    //           onTap: () {
                                    //             var position = post.position;
                                    //             if (position < 20) {
                                    //               int page = 1;
                                    //               if (post.Thread!.Forum!
                                    //                       .breadcrumbs!.length >
                                    //                   1) {
                                    //                 Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                         builder: (context) =>
                                    //                             ShowPostsOfThreads(
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .breadcrumbs![
                                    //                                         0]
                                    //                                     .title,
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .breadcrumbs![
                                    //                                         1]
                                    //                                     .title,
                                    //                                 post
                                    //                                     .Thread!,
                                    //                                 page,
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .title)));
                                    //               } else {
                                    //                 Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                         builder: (context) =>
                                    //                             ShowPostsOfThreads(
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .breadcrumbs![
                                    //                                         0]
                                    //                                     .title,
                                    //                                 "",
                                    //                                 post
                                    //                                     .Thread!,
                                    //                                 page,
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .title)));
                                    //               }
                                    //             } else {
                                    //               int page =
                                    //                   (position ~/ 20) + 1;
                                    //               if (post.Thread!.Forum!
                                    //                       .breadcrumbs!.length >
                                    //                   1) {
                                    //                 Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                         builder: (context) =>
                                    //                             ShowPostsOfThreads(
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .breadcrumbs![
                                    //                                         0]
                                    //                                     .title,
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .breadcrumbs![
                                    //                                         1]
                                    //                                     .title,
                                    //                                 post
                                    //                                     .Thread!,
                                    //                                 page,
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .title)));
                                    //               } else {
                                    //                 Navigator.push(
                                    //                     context,
                                    //                     MaterialPageRoute(
                                    //                         builder: (context) =>
                                    //                             ShowPostsOfThreads(
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .breadcrumbs![
                                    //                                         0]
                                    //                                     .title,
                                    //                                 "",
                                    //                                 post
                                    //                                     .Thread!,
                                    //                                 page,
                                    //                                 post
                                    //                                     .Thread!
                                    //                                     .Forum!
                                    //                                     .title)));
                                    //               }
                                    //             }
                                    //           },
                                    //           child: Html(
                                    //             data: getFilteredMessage(
                                    //                 post.message_parsed, post),
                                    //             style: {
                                    //               "body": Style(
                                    //                 fontSize: FontSize(12),
                                    //                 color: provider.darkTheme
                                    //                     ? Color(0xffe4dddd)
                                    //                     : Colors.black54,
                                    //                 letterSpacing: 1.5,
                                    //                 maxLines: 4,
                                    //               ),
                                    //               "table": Style(
                                    //                 fontFamily:
                                    //                     "arial, sans-serif",
                                    //                 backgroundColor:
                                    //                     Theme.of(context)
                                    //                         .accentColor,
                                    //               ),
                                    //               "blockquote":
                                    //                   Style(height: 0),
                                    //               "th": Style(
                                    //                 padding: EdgeInsets.all(6),
                                    //                 backgroundColor:
                                    //                     Colors.grey,
                                    //                 border: Border.all(
                                    //                     color: Theme.of(context)
                                    //                         .accentColor),
                                    //               ),
                                    //               "td": Style(
                                    //                 backgroundColor:
                                    //                     Theme.of(context)
                                    //                         .bottomAppBarColor,
                                    //                 padding: EdgeInsets.all(6),
                                    //                 border: Border.all(
                                    //                     color: Theme.of(context)
                                    //                         .accentColor),
                                    //               ),
                                    //               'h5': Style(
                                    //                   maxLines: 2,
                                    //                   textOverflow: TextOverflow
                                    //                       .ellipsis),
                                    //             },
                                    //           ),
                                    //         ),
                                    //       );
                                    //     } else {
                                    //       return Center(
                                    //         child: SizedBox(),
                                    //       );
                                    //     }
                                    //   },
                                    //   future: ApiClient(Dio(BaseOptions(
                                    //           contentType: "application/json")))
                                    //       .getPostsOfLastPostId(
                                    //           MyDataClass.api_key,
                                    //           list[index].last_post_id),
                                    // ),
                                  ],
                                ),
                              );
                            },
                            itemCount: list.length,
                          ),
                        ),
                      ))
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                if (Provider.of<MyProvider>(context).isLoadingHomeThreads)
                  const CircularProgressIndicator()
              ],
            )),
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

  getFilteredMessage(String message_parsed, PostsOfThreads post) {
    var mess = message_parsed;
    var k = parse(mess);
    return k.body?.text.toString();
  }

  void getData(int page) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var threadResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getHomeThreads(
                MyDataClass.api_key, page, "desc", "last_post_date");
    pagination = threadResponse.pagination;
    if (_refreshController.isRefresh) {
      if (threadResponse.threads.isNotEmpty) {
        list.clear();
        sticky.clear();
      }
      _refreshController.refreshCompleted();
    }
    var sticky1 = threadResponse.sticky;
    if (sticky1 != null) {
      sticky.addAll(sticky1);
    }
    list.addAll(threadResponse.threads);
    provider.setisLoadingHomeThreads(false);
    setState(() {
      isFirstLoadingThreads = false;
    });
  }

  void getTotalConversationsCount() async {
    var prefs = await SharedPreferences.getInstance();
    var isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (isLoggedIn) {
      debugPrint(
          "total ${MyDataClass.myUserId} and ${prefs.getString("email")}");
      var email = prefs.getString("email").toString();
      var response =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .findUserEmail(MyDataClass.api_key, 1, email);
      MyDataClass.loginResponse = response["user"] as UserData;
      MyDataClass.isUserLoggedIn = true;
      MyDataClass.myUserId = (response["user"] as UserData).user_id;
      var responseAlerts =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .getUnViewedConversations(
                  MyDataClass.api_key, MyDataClass.myUserId, true);
      var pagination = responseAlerts.pagination as Pagination;
      debugPrint("total ${pagination.total}${MyDataClass.myUserId}");
      if (pagination.total > 0) {
        setState(() {
          isConversationsAvail = true;
          totalConversations = pagination.total;
        });
      }
    }
  }

  void getCurrentTheme() async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var share = await provider.darkThemePreference.getTheme();
    debugPrint("dark" + share.toString());
    provider.darkTheme = share;
  }
}
