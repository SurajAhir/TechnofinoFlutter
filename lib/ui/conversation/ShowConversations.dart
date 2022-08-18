import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technofino/ui/conversation/ReplyConversation.dart';
import 'package:technofino/ui/user_profile/UserProfile.dart';

import '../../data_classes/conversation_response/Conversations.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShowConversations extends StatefulWidget {
  const ShowConversations({Key? key}) : super(key: key);

  @override
  State<ShowConversations> createState() => _ShowConversationsState();
}

class _ShowConversationsState extends State<ShowConversations> {
  final _scrollControllar = ScrollController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Conversations> list = [];
  var isLoadingThreads = false;
  var isFirstLoadingConversations = true;
  int page = 1;
  Pagination? pagination;
  var isDataAvailbale = false;
  var isStared=false;
  @override
  initState() {
    super.initState();
    getData(page);
    _scrollControllar.addListener(() {
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingConversations(true);
          page++;
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        } else {
          debugPrint(
              "position ${pagination!.total} and ${pagination!.current_page}");
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingConversations(false);
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
              Material(
                elevation: 15,
                child: Container(
                  height: 45,
                  color: Theme.of(context).bottomAppBarColor,
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("conversations".tr,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                              fontSize: 18)),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Icon(
                      //         Icons.filter_alt_outlined,
                      //         color: Theme.of(context).accentColor,
                      //         size: 24,
                      //       ),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Image.asset(
                      //         "assets/icons/edit_post.png",
                      //         height: 20,
                      //         width: 20,
                      //         color: Theme.of(context).accentColor,
                      //       ),
                      //       SizedBox(
                      //         width: 6,
                      //       )
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              isFirstLoadingConversations == false
                  ? Expanded(
                      child: Scaffold(
                        backgroundColor: Theme.of(context).backgroundColor,
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
                              return Slidable(
                                key: const ValueKey(0),

                                // The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        starConversation(
                                            list,index);
                                      },
                                      spacing: 2,
                                      backgroundColor: Colors.orangeAccent,
                                      foregroundColor: Colors.white,
                                      icon: list[index].is_starred?Icons.star:Icons.star_border_outlined,
                                      label: list[index].is_starred?'Unstar':"Star",
                                    ),
                                    SlidableAction(
                                      onPressed: (context) {
                                        deleteConversation(
                                            list,index);
                                      },
                                      spacing: 2,
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 5, right: 5, top: 3),
                                  color: Theme.of(context).bottomAppBarColor,
                                  child: ListTile(
                                    leading: list[index]
                                            .Starter!
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
                                                                  .Starter!)));
                                            },
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  list[index]
                                                      .Starter!
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
                                                                  .Starter!)));
                                            },
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              child: Text(
                                                "${list[index].Starter!.username.substring(0, 1)}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                    title: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ReplyConversation(
                                                          list[index])));
                                          markRead(list[index].conversation_id);
                                        },
                                        child: Text("${list[index].title}")),
                                    trailing: Container(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${readTimestamp(list[index].last_message_date.toInt())}",
                                            style: TextStyle(fontSize: 11),
                                          ),
                                          if (list[index].is_unread)
                                            SizedBox(
                                              width: 3,
                                            ),
                                          if (list[index].is_unread)
                                            CircleAvatar(
                                              backgroundColor:
                                                  provider.darkTheme
                                                      ? Colors.white
                                                      : Colors.black38,
                                              radius: 4,
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: list.length,
                          ),
                        ),
                      ),
                    )
                  : isDataAvailbale == false
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: Text(
                            "no_conversation_found".tr,
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                          ),
                        ),
              if (Provider.of<MyProvider>(context).isLoadingConversations)
                const CircularProgressIndicator.adaptive()
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
    var conversationResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getConversations(MyDataClass.api_key, MyDataClass.myUserId, page,
                "desc", "last_post_date");
    pagination = conversationResponse.pagination;
    if (_refreshController.isRefresh) {
      if (conversationResponse.conversations.isNotEmpty) {
        list.clear();
      }
      _refreshController.refreshCompleted();
    }
    if(isStared){
      list.clear();
      isStared=false;
    }
    list.addAll(conversationResponse.conversations);
    if (list.isEmpty) {
      isDataAvailbale = true;
    }
    debugPrint(list.toString());
    provider.setisLoadingConversations(false);
    setState(() {
      isFirstLoadingConversations = false;
    });
  }

  void markRead(int conversation_id) async {
    var conversationResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .markReadConversation(
                MyDataClass.api_key, MyDataClass.myUserId, conversation_id);
    setState(() {});
  }

  void starConversation(List<Conversations> list, int index) async {
    var starResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .starConversation(
                MyDataClass.api_key, MyDataClass.myUserId, list[index].conversation_id);
    if(starResponse["success"]==true){
      setState(() {
        isStared=true;
        getData(page);
      });
    }
  }

  void deleteConversation(List<Conversations> list,int index) async {
    var deleteResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .deleteConversation(
                MyDataClass.api_key, MyDataClass.myUserId, list[index].conversation_id);
    if(deleteResponse["success"]==true){
      list.removeAt(index);
    }
    setState(() {});
  }
}
