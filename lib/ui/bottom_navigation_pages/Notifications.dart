import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
          ),
          backgroundColor: Colors.white,
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
                    body: ListView.builder(
                      controller: _scrollControllar,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: list[index]
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
                                child: Text(
                                    "${list[index].User!.username.substring(
                                        0, 1)}"),
                              ),
                            ),
                            title: InkWell(
                                onTap: () {
                                  getPostFromAlerts(
                                      context, list[index].content_id);
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
                          ),
                        );
                      },
                      itemCount: list.length,
                    ),
                  ),
                )
                    : isDataAvailbale == false
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(
                  child: Text("No alerts found!"),
                ),
                if (Provider
                    .of<MyProvider>(context)
                    .isLoadingNotifications)
                  const CircularProgressIndicator.adaptive()
              ],
            ),
          ),
        ):Container(
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
                  "You must log-in to perform this action.",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Text(
                      "Log in",
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
        MyDataClass.api_key, "625", page, "desc", "last_post_date");
    pagination = alertsResponse.pagination;
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
        MyDataClass.api_key, "625", content_id);
    var thread = alertsResponse.post.Thread;
    int position = alertsResponse.post.position;
    debugPrint(position.toString());

    if (position < 10) {
      int page = 1;
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ShowPostsOfThreads(thread.Forum!.breadcrumbs![0].title,
              thread.Forum!.breadcrumbs![1].title, thread, page,
              thread.Forum!.title)));
    } else {
      int page = (position ~/ 10) + 1;
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          ShowPostsOfThreads(thread.Forum!.breadcrumbs![0].title,
              thread.Forum!.breadcrumbs![1].title, thread, page,
              thread.Forum!.title)));
    }
  }
}
