import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:technofino/data_classes/thread_response/Threads.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/user_profile/UserProfile.dart';
import 'package:html/parser.dart' show parse;
import '../data_classes/post_response/PostsOfThreads.dart';
import '../main_data_class/MyDataClass.dart';
import '../services/ApiClient.dart';
import 'nodes_related_classes/ShowPostsOfThreads.dart';

class SearchAppBar extends StatefulWidget {
  List<Threads> list;

  SearchAppBar(this.list, {Key? key}) : super(key: key);

  @override
  _SearchAppBarState createState() => new _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
var threads=[];
@override
  initState(){
  threads=widget.list;
  super.initState();
}
  onItemChanged(String value) {
    setState(() {
      threads=widget.list.where((element) => element.title.contains(value)||element.username.contains(value)).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
  var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
       onChanged: (value){
         onItemChanged(value);
       },
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
          decoration: InputDecoration(
              prefixIcon:
                  Icon(Icons.search, color: Theme.of(context).accentColor),
              hintText: "Search...",
              hintStyle: TextStyle(color: Theme.of(context).accentColor)),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        elevation: 15,
        iconTheme: IconThemeData(color:Theme.of(context).accentColor ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return  Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Theme.of(context).bottomAppBarColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: threads[index]
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
                                            threads[index].User)));
                          },
                          child: CircleAvatar(
                            backgroundColor: provider.darkTheme?Color(0xffd6d1d1):Colors.blueAccent,
                            backgroundImage: NetworkImage(
                                threads[index].User.avatar_urls.o),
                          ),
                        )
                            : InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfile(
                                            threads[index].User)));
                          },
                          child: CircleAvatar(
                            backgroundColor: provider.darkTheme?Color(0xffd6d1d1):Colors.blueAccent,
                            child: Text(
                                "${threads[index].User.username.substring(0, 1)}"),
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
                                              threads[index].Forum !=
                                                  null
                                                  ? threads[index]
                                                  .Forum!
                                                  .breadcrumbs![0]
                                                  .title
                                                  .toString()
                                                  : "",
                                              threads[index].Forum !=
                                                  null
                                                  ? threads[index]
                                                  .Forum!
                                                  .title
                                                  : "",
                                              threads[index],
                                              1,
                                              "")));
                            },
                            child: Text(threads[index].username,style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold),)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 2,),
                            Row(
                              children: [
                                Text(
                                  "${readTimestamp(
                                      threads[index].last_post_date.toInt())} • ",style: TextStyle(fontSize: 10),),
                                Icon(Icons.remove_red_eye_sharp,size: 14,),
                                Text("${NumberFormat.compact().format(threads[index].view_count)} • ",style: TextStyle(fontSize: 10),),

                                Icon(CupertinoIcons.arrowshape_turn_up_left_fill,size: 14,),
                                Text("${NumberFormat.compact().format(threads[index].reply_count)}",style: TextStyle(fontSize: 10),),
                              ],
                            ),
                            SizedBox(height: 2,),
                            Text("${threads[index].Forum!.title}",style: TextStyle(fontSize: 10),),
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
                                                await Share.share(threads[index].view_url.toString());
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
                            child: Image.asset("assets/icons/toolbar.png",width: 20,height: 20,color:Theme.of(context).accentColor,)),
                      ),
                      InkWell(
                        onTap: () {
                          debugPrint("pressed");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShowPostsOfThreads(
                                          threads[index].Forum !=
                                              null
                                              ? threads[index]
                                              .Forum!
                                              .breadcrumbs![0]
                                              .title
                                              .toString()
                                              : "",
                                          threads[index].Forum !=
                                              null
                                              ? threads[index]
                                              .Forum!
                                              .title
                                              : "",
                                          threads[index],
                                          1,
                                          "")));
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 12),
                          margin: EdgeInsets.only(top: 8,bottom: 15),
                          child: Text(
                            "${threads[index].title}",
                            style: TextStyle(
                                color:
                                provider.darkTheme?Color(0xfff0efef):Colors.blue,fontSize: 15,fontWeight: FontWeight.bold
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
                      //       MyDataClass.api_key,threads[index].last_post_id),
                      // ),
                    ],
                  ),
                );
              },
              itemCount: threads.length,
            )
          )
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

getFilteredMessage(String message_parsed, PostsOfThreads post) {
  var mess = message_parsed;
  var k=parse(mess);
  return k.body?.text.toString();
}
}
