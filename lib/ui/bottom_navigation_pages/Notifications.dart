import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technofino/ui/nodes_related_classes/ShowPostsOfThreads.dart';

import '../../data_classes/notification_response/NotificationsData.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../user_profile/UserProfile.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  RefreshController _refreshController =RefreshController(initialRefresh: false);
  final _scrollControllar = ScrollController();
  List<NotificationsData> list = [];
  var isLoadingThreads = false;
  var isFirstLoadingConversations = true;
  int page = 1;
  Pagination? pagination;
  var isDataAvailbale = false;

  @override
  initState() {
    super.initState();
  if(MyDataClass.isUserLoggedIn){
    getData(page);
    _scrollControllar.addListener(() {
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingNotifications(true);
          page++;
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!
                  .current_page} and ${page}");
          getData(page);
        } else {
          debugPrint(
              "position ${pagination!.total} and ${pagination!.current_page}");
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingNotifications(false);
        }
      }
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "notifications".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold, color:Theme.of(context).accentColor , fontSize: 18),
          ),
          backgroundColor: Theme.of(context).bottomAppBarColor,
        ),
        body: MyDataClass.isUserLoggedIn?Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        onRefresh: () async{
                          debugPrint("refrshing...");
                          page=1;
                          getData(page);
                        },
                      child: ListView.builder(
                        controller: _scrollControllar,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Theme.of(context).bottomAppBarColor,
                            padding: EdgeInsets.only(left: 5,right: 5,top: 3),
                            child: ListTile(
                                leading: list[index].User!=null?list[index]
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
                                                UserProfile(list[index]
                                                    .User!)));
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        list[index]
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
                                                UserProfile(list[index]
                                                    .User!)));
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    child: Text(
                                      "${list[index].User!.username.substring(
                                          0, 1)}",style: TextStyle(color: Colors.white),),
                                  ),
                                ):InkWell(
                                  onTap: () {
                                    if(list[index].User!=null){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UserProfile(list[index]
                                                      .User!)));
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    child: Text(
                                      "?",style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                                title: InkWell(
                                    onTap: () {
                                      getPostFromAlerts(
                                          context, list[index].content_id);
                                      markRead(list[index].alert_id, true);
                                    },
                                    child: Text(list[index].alert_text,
                                      style: TextStyle(fontSize: 14),)),
                                subtitle: Text(
                                  "${DateFormat('MM/dd/yyyy').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          ((list[index].event_date) * 1000)
                                              .toInt()))}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                trailing: list[index].read_date>0?SizedBox(): CircleAvatar(backgroundColor: provider.darkTheme?Colors.white:Colors.black38,radius: 4,)
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
                  child: Text("no_alerts_found".tr),
                ),
                if (Provider
                    .of<MyProvider>(context)
                    .isLoadingNotifications)
                  const CircularProgressIndicator.adaptive()
              ],
            ),
          ),
        )
            :Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "you_must_log_in_to_perform_this_action".tr,
                  style: TextStyle(fontSize: 16, color: Theme.of(context).accentColor),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Text(
                      "log_in".tr,
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        )
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
    var alertsResponse =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .getAlerts(
        MyDataClass.api_key, MyDataClass.myUserId, page, "desc", "last_post_date");
    pagination = alertsResponse.pagination;
    if(_refreshController.isRefresh){
      if(alertsResponse.alerts.isNotEmpty){
        list.clear();
      }
      _refreshController.refreshCompleted();
    }
    list.addAll(alertsResponse.alerts);
    if (list.isEmpty) {
      isDataAvailbale = true;
    }
    debugPrint(list.toString());
    provider.setisLoadingNotifications(false);
    setState(() {
      isFirstLoadingConversations = false;
    });
  }

  void getPostFromAlerts(BuildContext context, int content_id) async {
    var alertsResponse = await ApiClient(
        Dio(BaseOptions(contentType: "application/json"))).getPostOfAlerts(
        MyDataClass.api_key, MyDataClass.myUserId, content_id);
    var thread = alertsResponse.post.Thread;
    int position = alertsResponse.post.position;
    debugPrint(position.toString());

    if (position < 20) {
      int page = 1;
     if(thread.Forum!.breadcrumbs!.length>1){
       Navigator.push(context, MaterialPageRoute(builder: (context) =>
           ShowPostsOfThreads(thread.Forum!.breadcrumbs![0].title,
               thread.Forum!.breadcrumbs![1].title, thread, page,
               thread.Forum!.title)));
     }else{
       Navigator.push(context, MaterialPageRoute(builder: (context) =>
           ShowPostsOfThreads(thread.Forum!.breadcrumbs![0].title,
               "", thread, page,
               thread.Forum!.title)));
     }
    }
    else {
      int page = (position ~/ 20) + 1;
      if(thread.Forum!.breadcrumbs!.length>1){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ShowPostsOfThreads(thread.Forum!.breadcrumbs![0].title,
                thread.Forum!.breadcrumbs![1].title, thread, page,
                thread.Forum!.title)));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ShowPostsOfThreads(thread.Forum!.breadcrumbs![0].title,
                "", thread, page,
                thread.Forum!.title)));
      }
    }
  }

  void markRead(int conversation_id,bool val) async {
    var conversationResponse =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .markReadAlerts(
        MyDataClass.api_key, MyDataClass.myUserId, conversation_id,val);
    setState(() {
    });
  }
}
