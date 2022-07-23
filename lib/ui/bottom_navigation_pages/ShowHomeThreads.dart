import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/data_classes/Threads.dart';
import 'package:technofino/data_classes/UserData.dart';

import '../../data_classes/pagination/Pagination.dart';
import '../../data_classes/thread_response/ThreadResponse.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../nodes_related_classes/ShowPostsOfThreads.dart';
import '../user_profile/UserProfile.dart';

class ShowHomeThreads extends StatefulWidget {
const ShowHomeThreads({Key? key}) : super(key: key);

  @override
  State<ShowHomeThreads> createState() => _ShowHomeThreadsState();
}

class _ShowHomeThreadsState extends State<ShowHomeThreads> {
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
          provider.setisLoadingHomeThreads(true);
          page++;
          debugPrint("position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        }else{
          debugPrint("position ${pagination!.total} and ${pagination!.current_page}");
          var provider=Provider.of<MyProvider>(context,listen: false);
          provider.setisLoadingHomeThreads(false);
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
                height: 45,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("TechnoFino Community",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue,
                            fontSize: 18)),
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      maxRadius: 15,
                      child: InkWell(onTap:(){} ,
                        child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 18,
                        ),
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: Colors.black12,
                    //   maxRadius: 15,
                    //   child: InkWell(onTap: (){Navigator.pushNamed(context, "/login");
                    //
                    //   },
                    //       child:
                    //           Icon(Icons.login, color: Colors.black, size: 18)),
                    // ),
                    CircleAvatar(
                      backgroundColor: Colors.black12,
                      maxRadius: 15,
                      child: InkWell(onTap: (){Navigator.pushNamed(context, "/conversations");

                      },
                          child:
                          Icon(Icons.messenger_outline_sharp, color: Colors.black, size: 18)),
                    )
                  ],
                ),
              ),
              isFirstLoadingThreads==false?Expanded(child: Scaffold(
              backgroundColor: Colors.black12,
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
                          ): InkWell(
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
                                            list[index].Forum!=null?list[index].Forum!.breadcrumbs![0].title.toString():"",
                                            list[index].Forum!=null?list[index].Forum!.title:"",
                                            list[index],1,""
                                        )));
                              },
                              child: Text(list[index].username)),
                          subtitle: Text(
                              readTimestamp(list[index].post_date.toInt())),
                          trailing: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
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
                                icon: const Icon(
                                  CupertinoIcons.share_up,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                label: const Text(
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
            )):const Center(child: CircularProgressIndicator(),),
              if(Provider.of<MyProvider>(context).isLoadingHomeThreads)
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

  void getData(int page) async{
    final prefs = await SharedPreferences.getInstance();
   var isLoggedIn= prefs.getBool("isLoggedIn")?? false;
   if(isLoggedIn){
     var email=prefs.getString("email").toString();
     var response=await ApiClient(Dio(BaseOptions(contentType: "application/json")))
         .findUserEmail(MyDataClass.api_key,"1",email);
     MyDataClass.loginResponse=response["user"] as UserData;
     MyDataClass.isUserLoggedIn=true;
   }
    var provider=Provider.of<MyProvider>(context,listen: false);
    var threadResponse=await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .getHomeThreads(MyDataClass.api_key, page,
        "desc", "last_post_date");
    pagination=threadResponse.pagination;
    var sticky=threadResponse.sticky;
    if(sticky!=null){
      list.addAll(sticky);
    }
    list.addAll(threadResponse.threads);
    debugPrint(list.toString());
    provider.setisLoadingHomeThreads(false);
    setState(() {
      isFirstLoadingThreads=false;
    });
  }

}
