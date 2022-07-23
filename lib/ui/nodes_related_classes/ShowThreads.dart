import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technofino/data_classes/Threads.dart';
import 'package:technofino/data_classes/TypeData.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/nodes_related_classes/ShowPostsOfThreads.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../services/ApiClient.dart';
import '../user_profile/UserProfile.dart';

class ShowThreads extends StatefulWidget {
  String title;
  String appBarTitle;
  String description;
  int node_id;
  TypeData type_data;

  ShowThreads( this.title,  this.appBarTitle,
       this.description, this.node_id, this.type_data,
      {Key? key})
      : super(key: key);

  @override
  State<ShowThreads> createState() => _ShowThreadsState();
}

class _ShowThreadsState extends State<ShowThreads> {
  final _scrollControllar = ScrollController();
  List<Threads> list=[];
  var isLoadingThreads=false;
  var isFirstLoadingThreads=true;
  int page=1;
  Pagination? pagination;
  @override
  initState(){
    super.initState();
    getData(page);
    _scrollControllar.addListener(() {
      if(_scrollControllar.offset==_scrollControllar.position.maxScrollExtent){
        if(page!=pagination!.last_page){
          var provider=Provider.of<MyProvider>(context,listen: false);
          provider.setisLoadingThreads(true);
          page++;
          debugPrint("position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        }else{
          debugPrint("position ${pagination!.total} and ${pagination!.current_page}");
          var provider=Provider.of<MyProvider>(context,listen: false);
          provider.setisLoadingThreads(false);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Text("${widget.appBarTitle}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),maxLines: 1,),
                  ),
                  Image.asset(
                    "assets/icons/ribbon.png",
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 6,),
                  Image.asset(
                    "assets/icons/filter.png",
                    width: 20,
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            isFirstLoadingThreads==false?Expanded(
              child: Scaffold(
                body: ListView.builder(
                  controller: _scrollControllar,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading:list[index].User.avatar_urls.o.toString().isNotEmpty?InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(list[index].User)));
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(list[index].User.avatar_urls.o),
                              ),
                            ):InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserProfile(list[index].User)));
                              },
                              child: CircleAvatar(
                                child: Text(
                                    "${list[index].User.username.substring(0, 1)}"),
                              ),
                            ),
                            title: InkWell(
                                onTap: (){
                                  debugPrint("pressed");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShowPostsOfThreads(
                                              widget.title,
                                              widget.appBarTitle,
                                              list[index],1,""
                                          )));
                                },
                                child: Text("${list[index].username}")),
                            subtitle: Text(
                                "${readTimestamp(list[index].post_date.toInt())}"),
                            trailing: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))),
                              child: Text(
                                "Follow",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12),
                            child: Text(
                              "${list[index].title}",
                              style: TextStyle(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.messenger_outline,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  label: Text(
                                    "Comment",
                                    style:
                                    TextStyle(color: Colors.black),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(Colors.white),
                                      elevation:
                                      MaterialStateProperty.all(0),
                                      alignment: Alignment.center),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.share_up,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  label: Text(
                                    "Share",
                                    style:
                                    TextStyle(color: Colors.black),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<
                                          Color>(Colors.white),
                                      elevation:
                                      MaterialStateProperty.all(0),
                                      alignment: Alignment.center),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: list.length,
                ),
              ),
            ):const Center(child: CircularProgressIndicator()),
            if(Provider.of<MyProvider>(context).isLoadingThreads)
              const CircularProgressIndicator.adaptive()
          ],
        ),
      ),
    ));
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

  void getData(int page) async{
    var provider=Provider.of<MyProvider>(context,listen: false);
   var threadResponse=await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .getThreads(MyDataClass.api_key, 625, widget.node_id, page,
        "desc", "last_post_date");
   pagination=threadResponse.pagination;
   var sticky=threadResponse.sticky;
   if(sticky!=null){
     list.addAll(sticky);
   }
    list.addAll(threadResponse.threads);
    debugPrint(list.toString());
   provider.setisLoadingThreads(false);
   setState(() {
     isFirstLoadingThreads=false;
   });
  }
}
