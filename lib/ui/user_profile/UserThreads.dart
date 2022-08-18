import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../data_classes/login_response/UserData.dart';
import '../../data_classes/thread_response/Threads.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../nodes_related_classes/ShowPostsOfThreads.dart';
import 'UserProfile.dart';

class UserThreads extends StatefulWidget {
  UserData user;

  UserThreads(this.user, {Key? key}) : super(key: key);

  @override
  State<UserThreads> createState() => _UserThreadsState();
}

class _UserThreadsState extends State<UserThreads> {
  final _scrollControllar = ScrollController();
  RefreshController _refreshController =RefreshController(initialRefresh: false);
  List<Threads> list = [];
  var isLoadingThreads = false;
  var isFirstLoadingThreads = true;
  var isDataAvailable=false;
  int page = 1;
  Pagination? pagination;

  @override
  initState() {
    super.initState();
    getData(page);
    _scrollControllar.addListener(() {
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingThreads(true);
          page++;
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        } else {
          debugPrint(
              "position ${pagination!.total} and ${pagination!.current_page}");
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingThreads(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          "${widget.user.username}",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
        ),
      ),
      body: Column(
        children: [
          isFirstLoadingThreads == false
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
                            margin: EdgeInsets.only(left: 5,right: 5,top: 3),
                            color: Theme.of(context).bottomAppBarColor,
                            child: ListTile(
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
                                              UserProfile(list[index].User)));
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      list[index].User.avatar_urls.o),
                                ),
                              )
                                  : InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserProfile(list[index].User)));
                                },
                                child: CircleAvatar(
                                  child: Text(
                                      "${list[index].User.username.substring(0, 1)}"),
                                ),
                              ),
                              title: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ShowPostsOfThreads(
                                                list[index].Forum!=null?list[index].Forum!.breadcrumbs![0].title.toString():"",
                                                list[index].Forum!=null?list[index].Forum!.title:"",
                                                list[index],1,""
                                            )));
                                  },
                                  child: Text("${list[index].title}",style: TextStyle(fontSize: 14,color: Theme.of(context).accentColor),)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${list[index].username}",style: TextStyle(fontSize: 12)),
                                  Text(
                                      "${readTimestamp(list[index].post_date.toInt())} • ${NumberFormat.compact().format(list[index].reply_count)} replies • "
                                          "${NumberFormat.compact().format(list[index].view_count)} views",style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: list.length,
                      ),
                    )
                  ),
                )
              : isDataAvailable==false? Center(child: CircularProgressIndicator()):Center(child: Text("no_threads_found".tr)),
          if (Provider.of<MyProvider>(context).isLoadingUserThreads)
            const CircularProgressIndicator.adaptive()
        ],
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
    debugPrint("userid${widget.user.user_id} ${MyDataClass.myUserId}${page}");
    var threadResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .findAllThreadsBy(MyDataClass.api_key, MyDataClass.myUserId, page, "desc",
                "last_post_date", widget.user.user_id);
    pagination = threadResponse.pagination;
    if(_refreshController.isRefresh){
      if(threadResponse.threads.isNotEmpty){
        list.clear();
      }
      _refreshController.refreshCompleted();
    }
    var sticky = threadResponse.sticky;
    if (sticky != null) {
      list.addAll(sticky);
    }
    list.addAll(threadResponse.threads);
    if(list.isEmpty){
      isDataAvailable=true;
      isFirstLoadingThreads=true;
    }else{
      setState(() {
        isFirstLoadingThreads = false;
      });
    }
    debugPrint(list.toString());
    provider.setisLoadingUserThreads(false);

  }
}
