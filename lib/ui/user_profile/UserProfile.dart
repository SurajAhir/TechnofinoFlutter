import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technofino/data_classes/UserData.dart';
import 'package:technofino/ui/user_profile/UserAbout.dart';
import 'package:technofino/ui/user_profile/UserThreads.dart';
import 'package:html/parser.dart' show parse;
import 'dart:math' as math;
import '../../data_classes/pagination/Pagination.dart';
import '../../data_classes/post_response/PostsOfThreads.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../nodes_related_classes/ShowImage.dart';

class UserProfile extends StatefulWidget {
  UserData user;

  UserProfile(this.user, {Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _scrollControllar = ScrollController();
  Pagination? pagination;
  int page = 1;
  List<PostsOfThreads> posts = [];
  bool isLoadingPosts = false;
  var isDataAvailable = false;

  @override
  initState() {
    super.initState();
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
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black12,
          child: Column(
            children: [
              Material(
                elevation: 50,
                child: Container(
                  height: 45,
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.user?.username}",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18)),
                      const Text(
                        "...",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 1,),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollControllar,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              leading:
                                  widget.user.avatar_urls.o.toString().isNotEmpty
                                      ? CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                            "${widget.user.avatar_urls.o}",
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 30,
                                          child: Text(
                                            "${widget.user.username.toString().substring(0, 1)}",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                              title: Text(
                                "${widget.user.username}",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  "${widget.user.user_title} • ${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(((widget.user?.register_date)! * 1000).toInt()))}"),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.topRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.heart,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Follow",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.messenger_outline_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Message",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  )
                                ],
                              ),
                            )
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
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Text(
                              "Profile posts",
                              style: TextStyle(color: Colors.white, fontSize: 18),
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
                              child: const Text(
                                "Threads",
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
                              child: const Text(
                                "About",
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
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
                                    child: Text(
                                      "${widget.user.username.substring(0, 1)}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Write something...")
                          ],
                        ),
                      ),
                      if (isDataAvailable)
                        SizedBox(height: 10,),
                        Container(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                                child: Text(
                                                    "${posts[index].User!.username.substring(0, 1)}"),
                                              ),
                                            ),
                                      title: Text("${posts[index].User!.username}"),
                                      subtitle: Text("${readTimestamp(posts[index].User!.last_activity.toInt())}"),
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
                                    Html(
                                      data: getFilteredMessage(
                                          posts[index]
                                              .message_parsed,
                                          posts[index]),
                                      style: {
                                        "body": Style(
                                            fontSize:
                                            FontSize(14),
                                            padding: EdgeInsets.only(left: 6),
                                        letterSpacing: 0.5),
                                        "table": Style(
                                          backgroundColor:
                                          const Color
                                              .fromARGB(
                                              0x50,
                                              0xee,
                                              0xee,
                                              0xee),
                                        ),
                                        "blockquote": Style(
                                            border:
                                            const Border(
                                              left: BorderSide(
                                                  color: Colors
                                                      .black12,
                                                  width: 2.0,
                                                  style:
                                                  BorderStyle
                                                      .solid),
                                            ),
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 10),
                                            margin:
                                            const EdgeInsets
                                                .only(
                                                left: 7)),
                                        "tr": Style(
                                          border: const Border(
                                              bottom: BorderSide(
                                                  color: Colors
                                                      .grey)),
                                        ),
                                        "th": Style(
                                          padding:
                                          EdgeInsets.all(6),
                                          backgroundColor:
                                          Colors.grey,
                                          border: const Border(
                                              bottom: BorderSide(
                                                  color: Colors
                                                      .grey)),
                                        ),
                                        "td": Style(
                                          padding:
                                          EdgeInsets.all(6),
                                          alignment:
                                          Alignment.topLeft,
                                          border: const Border(
                                              bottom: BorderSide(
                                                  color: Colors
                                                      .grey)),
                                        ),
                                        'h5': Style(
                                            maxLines: 2,
                                            textOverflow:
                                            TextOverflow
                                                .ellipsis),
                                      },
                                      customRender: {
                                        "table":
                                            (context, child) {
                                          return SingleChildScrollView(
                                            scrollDirection:
                                            Axis.horizontal,
                                            child: (context.tree
                                            as TableLayoutElement)
                                                .toWidget(
                                                context),
                                          );
                                        },
                                      },
                                      onLinkTap:
                                          (url, _, __, ___) {
                                        debugPrint(
                                            "Opening $url...");
                                      },
                                      onImageTap:
                                          (src, _, __, ___) {
                                        debugPrint(src);
                                        var att= posts[index].Attachments;
                                        att?.forEach((element) {
                                          if(src==element.thumbnail_url){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowImage(element.attachment_id)));
                                          }
                                        });
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.thumb_up_alt_outlined,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          label: Text(
                                            "Like",
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
                                            Icons.ios_share_rounded,
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
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: posts.length,
                          ),
                        ),
                      if (Provider.of<MyProvider>(context).isLoadingProfilePosts)
                        const CircularProgressIndicator.adaptive()
                    ],
                  ),
                ),
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
            .getProfilePosts(MyDataClass.api_key, "625", widget.user.user_id);
    pagination = threadResponse.pagination;
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
  getFilteredMessage(String message_parsed, PostsOfThreads post) {
    var mess=message_parsed;
    if (post.message_parsed.contains("<img")) {
      if (post.attach_count > 0) {
        var document = parse(message_parsed);
        var image=post.Attachments;
        List<String> imgThumbList=[];
        image?.forEach((element) {
          debugPrint(element.thumbnail_url);
          imgThumbList.add(element.thumbnail_url);
        });
        var imgList = document.querySelectorAll("img");
        int prev=0;
        for(int i=0;i<imgList.length;i++){
          var src=imgList[i].attributes["src"];
          prev=i+1;
          mess=mess.replaceAll(src!, imgThumbList[i]);
        }

        if(post.attach_count>imgList.length){
          for(int i=prev;i<imgThumbList.length;i++){
            var url="<br /><img src='${imgThumbList[i]}'/>";
            mess=mess+url;
          }
        }
      }
    }else{
      if(post.attach_count>0){
        var image=post.Attachments;
        image?.forEach((element) {
          var url="<br /><img src='${element.thumbnail_url}'/>";
          mess=mess+url;
        });
      }
    }
    return mess;
  }
}
