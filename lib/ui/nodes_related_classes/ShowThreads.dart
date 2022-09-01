import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:technofino/data_classes/thread_response/Threads.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/nodes_related_classes/ShowPostsOfThreads.dart';
import '../../data_classes/login_response/TypeData.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../data_classes/post_response/PostsOfThreads.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../services/ApiClient.dart';
import '../user_profile/UserProfile.dart';
import 'package:html/parser.dart' show parse;
class ShowThreads extends StatefulWidget {
  String title;
  String appBarTitle;
  String description;
  int node_id;
  TypeData type_data;

  ShowThreads(this.title, this.appBarTitle, this.description, this.node_id,
      this.type_data,
      {Key? key})
      : super(key: key);

  @override
  State<ShowThreads> createState() => _ShowThreadsState();
}

class _ShowThreadsState extends State<ShowThreads> {
  BranchContentMetaData metadata = BranchContentMetaData();
  BranchUniversalObject? buo;
  BranchLinkProperties lp = BranchLinkProperties();
  BranchEvent? eventStandart;
  BranchEvent? eventCustom;

  StreamSubscription<Map>? streamSubscription;
  StreamController<String> controllerData = StreamController<String>();
  StreamController<String> controllerInitSession = StreamController<String>();

  RefreshController _refreshController =RefreshController(initialRefresh: false);

  final _scrollControllar = ScrollController();
  var _usernameControllar = TextEditingController();
  List<Threads> list = [];
  List<Threads> sticky = [];
  var isLoadingThreads = false;
  var isFirstLoadingThreads = true;
  int page = 1;
  Pagination? pagination;
 var isDataFound=true;
  String LastUpdateValue = 'Any time';
  String LastMessageValue = 'Last message';
  String AscOrDescValue = 'Descending';
var isFilterDataAvail=false;
  List<String> listForLastUpdate = [
    "Any time",
    "7 days",
    "14 days",
    "30 days",
    "2 months",
    "3 months",
    "6 months",
    "1 year"
  ];

  List<String> listForLastMessage = [
    "Last message",
    "First message",
    "Title",
    "Replies",
    "Views",
    "First message reaction score"
  ];
  List<String> listForAscOrDesc = ["Descending", "Ascending"];
  @override
  initState() {
    super.initState();
    listenDynamicLinks();
    initDeepLinkData();
    getData(page);
    _scrollControllar.addListener(() {
      debugPrint("scrooled");
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingThreads(true);
          page++;
          getData(page);
        } else {
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
      // backgroundColor: Theme.of(context).bottomAppBarColor,
        appBar: AppBar(
          backgroundColor:Theme.of(context).bottomAppBarColor ,
          shadowColor: Colors.black12,
          iconTheme: IconThemeData(color:Theme.of(context).accentColor ),
          title:  Text(
            "${widget.appBarTitle}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor,
                fontSize: 18),
            maxLines: 1,
          ),
          actions: [
            InkWell(
              onTap: () {
                isFilterDataAvail=false;
                _usernameControllar.text="";
                showModalBottomSheetForFilter(context);
              },
              child: Image.asset(
                "assets/icons/filter.png",
                width: 20,
                height: 20,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(width: 8,)
          ],
        ),
        body: isDataFound?Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children:<Widget> [
         Expanded(
           child: Column(
             children: [
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
                                                             widget.title,
                                                             widget.appBarTitle,
                                                             sticky[index],
                                                             1,
                                                             "")
                                                 ));
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
                                         Text("${sticky[index].username}",style: TextStyle(color: provider.darkTheme?Colors.white70:Color(0xff8c8787)))
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
               Expanded(
                 child: Container(
                   child: isFirstLoadingThreads == false
                       ?ListView.builder(
                     shrinkWrap: true,
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
                                                   list[index].User)));
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
                                               UserProfile(
                                                   list[index].User)));
                                 },
                                 child: CircleAvatar(
                                   backgroundColor: Colors.blueAccent,
                                   child: Text(
                                     "${list[index].User.username.substring(
                                         0, 1)}",style: TextStyle(color: Colors.white),),
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
                                                     widget.title,
                                                     widget.appBarTitle,
                                                     list[index],
                                                     1,
                                                     "")));
                                   },
                                   child: Text("${list[index].username}",style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold)),),
                               subtitle: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(height: 2,),
                                   Row(
                                     children: [
                                       Text(
                                         "${readTimestamp(
                                             list[index].last_post_date.toInt())} • ",style: TextStyle(fontSize: 10),),
                                       Icon(Icons.remove_red_eye_sharp,size: 14,),
                                       Text("${NumberFormat.compact().format(list[index].view_count)} • ",style: TextStyle(fontSize: 10),),

                                       Icon(CupertinoIcons.arrowshape_turn_up_left_fill,size: 14,),
                                       Text("${NumberFormat.compact().format(list[index].reply_count)}",style: TextStyle(fontSize: 10),),
                                     ],
                                   ),
                                   SizedBox(height: 2,),
                                   Text("${widget.appBarTitle}",style: TextStyle(fontSize: 10),),
                                 ],
                               ),
                               trailing: InkWell(
                                   onTap: (){
                                     showModalBottomSheet(
                                         backgroundColor:
                                         Theme.of(context).backgroundColor,
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.only(
                                               topRight: Radius.circular(10),
                                               topLeft: Radius.circular(10)),
                                         ),
                                         context: context,
                                         builder: (context) => Container(
                                             height: 60,
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
                                                 Expanded(
                                                   child: ElevatedButton.icon(
                                                     onPressed: ()async {
                                                       generateLink(context,
                                                           BranchUniversalObject(
                                                               canonicalIdentifier: 'flutter/branch',
                                                               canonicalUrl: 'https://technofino.in',
                                                               title: 'TechnoFino Cummunity',
                                                               imageUrl:"https://www.technofino.in/community/data/assets/footer_logo/cropped-cropped-Logo-PNG-1.png",
                                                               contentMetadata: BranchContentMetaData()..addCustomMetadata("Thread",list[index].thread_id)
                                                                 ..addCustomMetadata("thread_id", "1")
                                                                 ..addCustomMetadata("title", widget.title)
                                                                 ..addCustomMetadata("title1", widget.appBarTitle)
                                                                 ..addCustomMetadata("threads", json.encode(list[index]))
                                                                 ..addCustomMetadata("page", 1)
                                                                 ..addCustomMetadata("title2", ""),
                                                               contentDescription: '${list[index].view_url}',
                                                               //contentMetadata: metadata,
                                                               keywords: ['Plugin', 'Branch', 'Flutter'],
                                                               publiclyIndex: true,
                                                               locallyIndex: true,
                                                               expirationDateInMilliSec: DateTime.now()
                                                                   .add(const Duration(days: 365))
                                                                   .millisecondsSinceEpoch),

                                                           BranchLinkProperties(
                                                               channel: 'facebook',
                                                               feature: 'sharing',
                                                               stage: 'new share',
                                                               campaign: 'campaign',
                                                               tags: ['one', 'two', 'three'])
                                                             ..addControlParam('\$uri_redirect_mode', '1')
                                                             ..addControlParam('referring_user_id', 'user_id'));
                                                     },
                                                     icon: Icon(
                                                       CupertinoIcons.share_up,
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
                                                   ),
                                                 )
                                               ],
                                             ))
                                       //create a custom widget as you want
                                     );
                                   },
                                   child: Image.asset("assets/icons/toolbar.png",width: 20,height: 20,color:Theme.of(context).accentColor)),
                               // trailing: MyDataClass.isUserLoggedIn
                               //     ? Container(
                               //   padding: EdgeInsets.all(5),
                               //   decoration: BoxDecoration(
                               //       color: Colors.blueAccent,
                               //       borderRadius: BorderRadius.all(
                               //           Radius.circular(10))),
                               //   child: Text(
                               //     "follow".tr,
                               //     style:
                               //     TextStyle(color: Colors.white),
                               //   ),
                               // )
                               //     : SizedBox(),
                             ),
                             InkWell(
                               onTap: () {
                                 debugPrint("pressed");
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) =>
                                             ShowPostsOfThreads(
                                                 widget.title,
                                                 widget.appBarTitle,
                                                 list[index],
                                                 1,
                                                 "")
                                     ));
                               },
                               child: Container(
                                 padding: EdgeInsets.only(left: 12),
                                 margin: EdgeInsets.only(top: 8,bottom: 15),
                                 child: Text(
                                   "${list[index].title}",
                                   style: TextStyle(
                                       color: provider.darkTheme?Color(0xfff0efef):Colors.blue,fontSize: 15,fontWeight: FontWeight.bold
                                   ),
                                 ),
                               ),
                             ),

                             // FutureBuilder(
                             //   builder: (ctx, snapshot) {
                             //     if(snapshot.hasData){
                             //       var map=snapshot.data as Map;
                             //       var post=map["post"] as PostsOfThreads;
                             //       return    Container(
                             //         height: 80,
                             //         child:  InkWell(
                             //           onTap: (){
                             //             var position=post.position;
                             //             if (position < 20) {
                             //               int page = 1;
                             //               if(post.Thread!.Forum!.breadcrumbs!.length>1){
                             //                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                             //                     ShowPostsOfThreads(post.Thread!.Forum!.breadcrumbs![0].title,
                             //                         post.Thread!.Forum!.breadcrumbs![1].title, post.Thread!, page,
                             //                         post.Thread!.Forum!.title)));
                             //               }else{
                             //                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                             //                     ShowPostsOfThreads(post.Thread!.Forum!.breadcrumbs![0].title,
                             //                         "", post.Thread!, page,
                             //                         post.Thread!.Forum!.title)));
                             //               }
                             //             }
                             //             else {
                             //               int page = (position ~/ 20) + 1;
                             //               if(post.Thread!.Forum!.breadcrumbs!.length>1){
                             //                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                             //                     ShowPostsOfThreads(post.Thread!.Forum!.breadcrumbs![0].title,
                             //                         post.Thread!.Forum!.breadcrumbs![1].title, post.Thread!, page,
                             //                         post.Thread!.Forum!.title)));
                             //               }else{
                             //                 Navigator.push(context, MaterialPageRoute(builder: (context) =>
                             //                     ShowPostsOfThreads(post.Thread!.Forum!.breadcrumbs![0].title,
                             //                         "", post.Thread!, page,
                             //                         post.Thread!.Forum!.title)));
                             //               }
                             //             }
                             //           },
                             //           child: Html(
                             //             data: getFilteredMessage(post
                             //                 .message_parsed,post
                             //             ),
                             //             style: {
                             //               "body": Style(
                             //                 fontSize:
                             //                 FontSize(
                             //                     12),
                             //                 color: provider.darkTheme?Color(0xffe4dddd):Colors.black54,
                             //                 letterSpacing:
                             //                 1.5,
                             //                 maxLines: 4,
                             //               ),
                             //               "table": Style(
                             //                 fontFamily: "arial, sans-serif",
                             //                 backgroundColor:Theme.of(context).accentColor,
                             //               ),
                             //               "blockquote": Style(
                             //                   height: 0
                             //               ),
                             //               "th": Style(
                             //                 padding:
                             //                 EdgeInsets
                             //                     .all(6),
                             //                 backgroundColor:
                             //                 Colors.grey,
                             //                 border: Border.all(color: Theme.of(context).accentColor
                             //                 ),
                             //               ),
                             //               "td": Style(
                             //                 backgroundColor: Theme.of(context).bottomAppBarColor,
                             //                 padding:
                             //                 EdgeInsets
                             //                     .all(6),
                             //                 border:  Border.all(color: Theme.of(context).accentColor),
                             //               ),
                             //               'h5': Style(
                             //                   maxLines: 2,
                             //                   textOverflow:
                             //                   TextOverflow
                             //                       .ellipsis),
                             //             },
                             //           ),
                             //         ),
                             //       );
                             //     }else{
                             //       return Center(
                             //         child: SizedBox(),
                             //       );
                             //     }
                             //
                             //   },
                             //   future: ApiClient(Dio(BaseOptions(contentType: "application/json")))
                             //       .getPostsOfLastPostId(
                             //       MyDataClass.api_key,list[index].last_post_id),
                             // ),

                           ],
                         ),
                       );
                     },
                     itemCount: list.length,
                   )
                       : const Center(child: CircularProgressIndicator()),
                 ),
               ),
               if (Provider
                   .of<MyProvider>(context)
                   .isLoadingThreads)
                 const CircularProgressIndicator.adaptive()
             ],
           ),
         )
            ],
          ),
        ):Center(
          child: Text("There are no threads in this forum.",style: TextStyle(color: Theme.of(context).accentColor,fontSize: 18),),
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

  void getData(int page) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    debugPrint(widget.node_id.toString());
    var threadResponse =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .getThreads(MyDataClass.api_key, MyDataClass.myUserId,
        widget.node_id, page, "desc", "last_post_date");
    pagination = threadResponse.pagination;
    if(_refreshController.isRefresh){
      if(threadResponse.threads.isNotEmpty){
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
    provider.setisLoadingThreads(false);
    setState(() {
      isFirstLoadingThreads = false;
    });
    if(list.isEmpty){
      setState(() {
        isDataFound = false;
      });
    }
  }

  getFilteredMessage(String message_parsed, PostsOfThreads post) {
    var mess = message_parsed;
    var k=parse(mess);
    return k.body?.text.toString();
  }

  void showModalBottomSheetForFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.75,
              decoration:  BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0),
                ),
              ),
              child: isFilterDataAvail==false?Container(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 18,),
                    Text("Started by:",
                        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 14)),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: _usernameControllar,
                        decoration:  InputDecoration(
                            hintText: "Enter username",
                            hintStyle: TextStyle(color: Theme.of(context).accentColor),
                            border: InputBorder.none,
                          fillColor: Theme.of(context).bottomAppBarColor,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).bottomAppBarColor),
                            borderRadius: BorderRadius.circular(25.7),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).bottomAppBarColor),
                            borderRadius: BorderRadius.circular(25.7),
                          ),),
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        style: TextStyle(color: Theme.of(context).accentColor),

                      ),
                    ),
                    SizedBox(height: 18,),
                    Text("Last updated:",
                        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 14)),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Container(
                        width: 200,
                        child: DropdownButton<String>(
                          value: LastUpdateValue,
                          dropdownColor: Theme.of(context).bottomAppBarColor,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Theme.of(context).accentColor, fontSize: 14),
                          onChanged: (value) {
                            setState((() {
                              LastUpdateValue = value ?? "";
                              Navigator.pop(context);
                              showModalBottomSheetForFilter(context);
                            }));
                          },
                          items: listForLastUpdate
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 18,),
                    Text("Sort by:",
                        style: TextStyle(color: Theme.of(context).accentColor, fontSize: 14)),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: DropdownButton<String>(
                              value: LastMessageValue,
                              dropdownColor: Theme.of(context).bottomAppBarColor,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor, fontSize: 14),
                              // underline: Container(
                              //   height: 2,
                              //   width: 100,
                              //   color: Colors.black38,
                              // ),
                              onChanged: (value) {
                                setState((() {
                                  LastMessageValue = value ?? "";
                                  Navigator.pop(context);
                                  showModalBottomSheetForFilter(context);
                                }));
                              },
                              items: listForLastMessage
                                  .map<DropdownMenuItem<String>>((
                                  String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width: 150,
                                      child: Text(
                                        value, maxLines: 1,
                                        style: TextStyle(fontSize: 12),)),
                                );
                              }).toList(),
                            ),
                          ),
                          DropdownButton<String>(
                            value: AscOrDescValue,
                            dropdownColor: Theme.of(context).bottomAppBarColor,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                                color: Theme.of(context).accentColor, fontSize: 14),
                            onChanged: (value) {
                              setState((() {
                                AscOrDescValue = value ?? "";
                                Navigator.pop(context);
                                showModalBottomSheetForFilter(context);
                              }));
                            },
                            items: listForAscOrDesc
                                .map<DropdownMenuItem<String>>((
                                String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, maxLines: 1,
                                  style: TextStyle(fontSize: 12),),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_usernameControllar.text.isEmpty) {
                            Navigator.pop(context);
                          } else {
                            findThreadsByFilter();
                          }
                        },
                        child: Text(
                          "FILTER", style: TextStyle(color: Colors.white),),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.black)),
                      ),
                    )
                  ],
                ),
              ):Center(child: Text("No data found!",style: TextStyle(color: Theme.of(context).accentColor),),)
          ),
    );
  }

  void findThreadsByFilter() async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var users =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .findUserByName(MyDataClass.api_key, _usernameControllar.text);

    var exactUser = users.exact;
    // var recommendeUser = users.recommendations;
    if (exactUser != null ) {
      var threadResponse = await ApiClient(
          Dio(BaseOptions(contentType: "application/json")))
          .getForumsResponseByFilter(
          MyDataClass.api_key, widget.node_id, AscOrDescValue, LastMessageValue, exactUser.user_id, LastUpdateValue);

      pagination = threadResponse.pagination;
      var sticky = threadResponse.sticky;
      if (sticky != null) {
        list.clear();
        list.addAll(sticky);
      }
      if(threadResponse.threads!=null){
        if(sticky==null){
          list.clear();
        }
        list.addAll(threadResponse.threads);
        if(list.isNotEmpty){
          debugPrint(list.toString());
          provider.setisLoadingThreads(false);
          Navigator.pop(context);
          setState(() {
            isFirstLoadingThreads = false;
          });
        }else{
          setState(() {
            isFilterDataAvail=true;
            Navigator.pop(context);
            showModalBottomSheetForFilter(context);
          });
        }
      }

    } else {
      setState(() {
        isFilterDataAvail=true;
        Navigator.pop(context);
        showModalBottomSheetForFilter(context);
      });
    }
  }

  void generateLink(BuildContext context, BranchUniversalObject buo,BranchLinkProperties lp) async {
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
        if(data["thread_id"]=="1"){
          var threads=json.decode(data["threads"]);
          var th=Threads.fromJson(threads);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ShowPostsOfThreads(
                          data["title"],
                          data["title1"],
                          th,
                          1,
                          data["title2"])));
          debugPrint(threads["view_url"].toString());

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
        imageUrl:"",
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
