import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreads.dart';
import 'package:technofino/provider/MyProvider.dart';
import 'package:technofino/ui/nodes_related_classes/ShowImage.dart';
import '../../data_classes/Posts.dart';
import '../../data_classes/Threads.dart';
import '../../data_classes/UserData.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../services/ApiClient.dart';
import 'package:html/parser.dart' show parse;
import 'dart:math' as math;
import 'package:image_picker/image_picker.dart';
import '../bottom_navigation_pages/Profile.dart';
import '../user_profile/UserProfile.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
class ShowPostsOfThreads extends StatefulWidget {
  String title;
  String appBarTitle;
  Threads threads;
  int page = 1;
  String anotherTitle;
  ShowPostsOfThreads(
      this.title, this.appBarTitle, this.threads, this.page, this.anotherTitle,
      {Key? key})
      : super(key: key);

  @override
  State<ShowPostsOfThreads> createState() => _ShowPostsOfThreadsState();
}

class _ShowPostsOfThreadsState extends State<ShowPostsOfThreads> {
  Pagination? pagination;
  int page = 1;
  List<PostsOfThreads> posts = [];
  var firsLoading = true;
var isReacted=false;
int newReactionId=1;
  int prevIndex=0;
  @override
  initState() {
    super.initState();
    if (widget.anotherTitle.isNotEmpty) {
      getData(widget.page);
    } else {
      getData(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 65,
                color: Colors.white,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 4, right: 4),
                child: ListTile(
                  leading: widget.threads.User.avatar_urls.o
                          .toString()
                          .isNotEmpty
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfile(widget.threads.User)));
                          },
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.threads.User.avatar_urls.o),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserProfile(widget.threads.User)));
                          },
                          child: CircleAvatar(
                            child: Text(
                                "${widget.threads.User.username.substring(0, 1)}"),
                          ),
                        ),
                  title: Text(
                    "${widget.threads.username}",
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    "${readTimestamp(widget.threads.post_date.toInt())}",
                    maxLines: 1,
                  ),
                  trailing: Container(
                      width: 80,
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            "assets/icons/ribbon.png",
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "...",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(5),
                        color: Colors.black12,
                        child: Row(
                          children: [
                            Text(
                              "${widget.title} ",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 15,
                            ),
                            Text(
                              " ${widget.appBarTitle}",
                              style: TextStyle(fontSize: 12),
                            ),
                            if (widget.anotherTitle.isNotEmpty)
                              Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: 15,
                              ),
                            Text(
                              " ${widget.anotherTitle}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.threads.title}"),
                            SizedBox(
                              height: 6,
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
                                      CupertinoIcons.hand_thumbsup,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "Like",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        elevation: MaterialStateProperty.all(0),
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
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                        elevation: MaterialStateProperty.all(0),
                                        alignment: Alignment.center),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black12,
                        child: Provider.of<MyProvider>(context)
                                        .isFirstLoadingPosts ==
                                    true ||
                                firsLoading == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ListTile(
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
                                                    "${posts[index].User!.username.toString().substring(0, 1)}"),
                                              ),
                                            ),
                                      title: Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(6)),
                                                  color: Colors.white),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "  ${posts[index].User!.username}"),
                                                  Html(
                                                    data: getFilteredMessage(
                                                        posts[index]
                                                            .message_parsed,
                                                        posts[index]),
                                                    style: {
                                                      "body": Style(
                                                          fontSize:
                                                              FontSize(14),
                                                          letterSpacing: 1),
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
                                                          border: const Border(
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
                                                      var att = posts[index]
                                                          .Attachments;
                                                      att?.forEach((element) {
                                                        if (src ==
                                                            element
                                                                .thumbnail_url) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      ShowImage(
                                                                          element
                                                                              .attachment_id)));
                                                        }
                                                      });
                                                    },
                                                  )
                                                ],
                                              )),
                                          if(posts[index].tapi_reactions!.length>0)
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(6))),
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom: 5, left: 5, right: 5),
                                                transform:
                                                Matrix4.translationValues(
                                                    0.0, -20.0, 0.0),
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        bottomRight:
                                                        Radius.circular(
                                                            20),
                                                        bottomLeft:
                                                        Radius.circular(
                                                            20)),
                                                    color: Colors.white),
                                                child:checkUsersReaction(context,posts[index]),//***********************************************************
                                              ),
                                            ),
                                          if(posts[index].tapi_reactions!.isEmpty)
                                            SizedBox(height: 25,),
                                          Container(
                                            transform:
                                                Matrix4.translationValues(
                                                    0, -12, 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${readTimestamp(posts[index].post_date.toInt())} •",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                InkWell(
                                                    onTap: (){
                                                      prevIndex=index;
                                                      react(1, posts[index].post_id);
                                                    },
                                                    onLongPress: (){
                                                      showDialogBox(context,posts[index].post_id);
                                                    },
                                                    child: Provider.of<MyProvider>(context).isReacted==false?isReactedTo(context,posts[index]):nowIsReacted(context,newReactionId,index)
                                                ),//***********************************************************

                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "Reply •",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "•••",
                                                  textAlign: TextAlign.start,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: posts.length,
                              ),
                      ),
                      Provider.of<MyProvider>(context).isPaginationAval ==
                                  true &&
                              firsLoading == false
                          ? Container(
                              color: Colors.black12,
                              height: 100,
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Transform.rotate(
                                      angle: 180 * math.pi / 180,
                                      child: InkWell(
                                          onTap: () {
                                            if (page == 1) {
                                              return;
                                            } else {
                                              Provider.of<MyProvider>(context,
                                                      listen: false)
                                                  .setisFirstLoadingPosts(true);
                                              page = 1;
                                              getData(page);
                                            }
                                          },
                                          child: const Icon(
                                            Icons.double_arrow_rounded,
                                            size: 30,
                                          ))),
                                  Transform.rotate(
                                    angle: 180 * math.pi / 180,
                                    child: InkWell(
                                        onTap: () {
                                          if (page == 1) {
                                            return;
                                          } else {
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .setisFirstLoadingPosts(true);
                                            page--;
                                            getData(page);
                                          }
                                        },
                                        child: const Icon(
                                            Icons.keyboard_arrow_right_outlined,
                                            size: 30)),
                                  ),
                                  Text("${pagination?.current_page}",
                                      style: TextStyle(fontSize: 16)),
                                  const Text(
                                    "/",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text("${pagination?.last_page}",
                                      style: TextStyle(fontSize: 16)),
                                  InkWell(
                                      onTap: () {
                                        if (page == pagination?.last_page) {
                                          return;
                                        } else {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .setisFirstLoadingPosts(true);
                                          page++;
                                          getData(page);
                                        }
                                      },
                                      child: const Icon(
                                          Icons.keyboard_arrow_right_outlined,
                                          size: 30)),
                                  InkWell(
                                      onTap: () {
                                        if (page == pagination?.last_page) {
                                          return;
                                        } else {
                                          Provider.of<MyProvider>(context,
                                                  listen: false)
                                              .setisFirstLoadingPosts(true);
                                          page = pagination?.last_page ?? 1;
                                          getData(page);
                                        }
                                      },
                                      child: const Icon(
                                          Icons.double_arrow_rounded,
                                          size: 30)),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 15,
                child: Container(
                  color: Colors.black12,
                  padding: EdgeInsets.all(6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 2,),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                              context: context, builder: (context){
                            return Container(
                              height: 200,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () async{
                                       var status=await Permission.photos;
                                       if(await status.isGranted){
                                                  getPhoto();
                                       }else{
                                         status.request();
                                       }
                                        },
                                      child: Text("Photo",style: TextStyle(fontSize: 16,color: Colors.black),)),
                                  InkWell(
                                      onTap: () async{
                                        var status=await Permission.camera;
                                        if(await status.isGranted){
                                          getPhotoFromCamera();
                                        }else{
                                          status.request();
                                        }
                                      },
                                      child: Text("Take photo",style: TextStyle(fontSize: 16,color: Colors.black),)),
                                  InkWell(
                                onTap: () async{
                                  var status=await Permission.storage;
                                  if(await status.isGranted){
                                    getFile();
                                  }else{
                                    status.request();
                                  }
                                },
                                      child: Text("File",style: TextStyle(fontSize: 16,color: Colors.black),)),
                                  Text("Expanded editor",style: TextStyle(fontSize: 16,color: Colors.black),),
                                ],
                              ),
                            );
                          });
                        },
                        child: Icon(
                          Icons.link,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: 4,),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Write a comment...',
                                border: InputBorder.none),
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: null,
                          ),
                        ),
                      ),
                      SizedBox(width: 4,),
                      const CircleAvatar(
                        child: Icon(Icons.send),
                      )
                    ],
                  ),
                ),
              ))
        ],
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

  getFilteredMessage(String message_parsed, PostsOfThreads post) {
    var mess = message_parsed;
    if (post.message_parsed.contains("<img")) {
      if (post.attach_count > 0) {
        var document = parse(message_parsed);
        var image = post.Attachments;
        List<String> imgThumbList = [];
        image?.forEach((element) {
          debugPrint(element.thumbnail_url);
          imgThumbList.add(element.thumbnail_url);
        });
        var imgList = document.querySelectorAll("img");
        int prev = 0;
        for (int i = 0; i < imgList.length; i++) {
          var src = imgList[i].attributes["src"];
          prev = i + 1;
          mess = mess.replaceAll(src!, imgThumbList[i]);
        }

        if (post.attach_count > imgList.length) {
          for (int i = prev; i < imgThumbList.length; i++) {
            var url = "<br /><img src='${imgThumbList[i]}'/>";
            mess = mess + url;
          }
        }
      }
    } else {
      if (post.attach_count > 0) {
        var image = post.Attachments;
        image?.forEach((element) {
          var url = "<br /><img src='${element.thumbnail_url}'/>";
          mess = mess + url;
        });
      }
    }
    return mess;
  }

  void getData(int page) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var threadResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getPostsOfThreads(MyDataClass.api_key, 625,
                widget.threads.thread_id, page, "desc", "last_post_date");
    var pagination = threadResponse.pagination;
    if (pagination != null && pagination.last_page > 1) {
      this.pagination = pagination;
      provider.setPagination(true);
    } else {
      provider.setPagination(false);
    }
    posts.addAll(threadResponse.posts);
    provider.setisFirstLoadingPosts(false);
    setState(() {
      firsLoading = false;
    });
  }

  Widget isReactedTo(BuildContext context,PostsOfThreads post){
    if(post.is_reacted_to) {
      debugPrint(post.visitor_reaction_id.toString());
      switch (post.visitor_reaction_id) {
        case 1:
            return Container(
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons
                        .hand_thumbsup_fill, color: Colors.blueAccent,
                    size: 15,
                  ),
                  Text(
                    "Like •",
                    style: TextStyle(
                        fontSize: 13, color: Colors.blueAccent),
                  )
                ],
              ),
            );
        case 2:

            return Container(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/love_icon.png", width: 24, height: 24,),
                  Text(
                    "Love •",
                    style: TextStyle(
                        fontSize: 13, color: Colors.redAccent),
                  )
                ],
              ),
            );

        case 3:

            return Container(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/haha_icon.png", width: 24, height: 24,),
                  Text(
                    "Haha •",
                    style: TextStyle(
                        fontSize: 13, color: Colors.yellow),
                  )
                ],
              ),
            );


        case 4:

            return Container(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/wow_icon.png", width: 24, height: 24,),
                  Text(
                    "Wow •",
                    style: TextStyle(
                        fontSize: 13, color: Colors.blueAccent),
                  )
                ],
              ),
            );


        case 5:

            return Container(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/sad_icon.png", width: 24, height: 24,),
                  Text(
                    "Sad •",
                    style: TextStyle(
                        fontSize: 13, color: Colors.orange),
                  )
                ],
              ),
            );


        case 6:

            return Container(
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/angry_icon.png", width: 24, height: 24,),
                  Text(
                    "Angry •",
                    style: TextStyle(
                        fontSize: 13, color: Colors.blueAccent),
                  )
                ],
              ),
            );


        default:

            return Container(
              child: Row(
                children: [
                  Icon(CupertinoIcons.hand_thumbsup, size: 15,),
                  Text(
                    "Like •",
                    style: TextStyle(
                        fontSize: 13, color: Colors.black),
                  )
                ],
              ),
            );

      }
    }
    else{
      return Container(
        child: Row(
          children: [
            Icon(CupertinoIcons.hand_thumbsup, size: 15,),
            Text(
              "Like •",
              style: TextStyle(
                  fontSize: 13, color: Colors.black),
            )
          ],
        ),
      );
    }
  }

  checkUsersReaction(BuildContext context, PostsOfThreads post) {
    return Container(
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        itemBuilder: (context,index){
          return Row(
            children: [
              Row(
                children:[
                  CircleAvatar(
                    backgroundColor: Colors
                        .lightBlueAccent,
                    radius: 9,
                    backgroundImage: NetworkImage(post.tapi_reactions![index].image.toString()),
                  ),
                  Text(
                    "${post.tapi_reactions![index].total}",
                    style: TextStyle(
                        color:
                        Colors.black,
                        fontSize: 12),
                  ),
                  SizedBox(width: 3,)
                ],
              ),
            ],
          );
        },itemCount: post.tapi_reactions!.length,),
    );
  }

  void react(int reaction_id,int post_id) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var response =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .getReaponseOfReact(MyDataClass.api_key,"625",post_id,reaction_id);
  if(response.success){
    debugPrint("success"+response.action);
   if(response.action=="insert"){
     provider.setIsReacted(true);
     newReactionId=reaction_id;
     // setState((){
     //   isReacted=true;
     //   newReactionId=reaction_id;
     // });
   }else{
     provider.setIsReacted(true);
     newReactionId=0;
     // setState((){
     //   isReacted=true;
     //   newReactionId=0;
     // });
   }
  }
  }

  showDialogBox(BuildContext, int post_id){
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 50,
        width: 300.0,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                react(1, post_id);
                Navigator.pop(context);
              },
              child: CircleAvatar(radius: 18,
                  child: Icon(CupertinoIcons.hand_thumbsup_fill,color: Colors.white,size: 22,)),
            ),
            InkWell(
                onTap: (){
                  react(2, post_id);
                  Navigator.pop(context);
                },
                child: Image.asset("assets/icons/love_icon.png",width: 35,height: 35,)),
            InkWell(
                onTap: (){
                  react(3, post_id);
                  Navigator.pop(context);
                },
                child: Image.asset("assets/icons/haha_icon.png",width: 35,height: 35)),
            InkWell(
                onTap: (){
                  react(4, post_id);
                  Navigator.pop(context);
                },
                child: Image.asset("assets/icons/wow_icon.png",width: 35,height: 35)),
            InkWell(
                onTap: (){
                  react(5, post_id);
                  Navigator.pop(context);
                },
                child: Image.asset("assets/icons/sad_icon.png",width: 35,height: 35)),
            InkWell(
                onTap: (){
                  react(6, post_id);
                  Navigator.pop(context);
                },
                child: Image.asset("assets/icons/angry_icon.png",width: 35,height: 35))
          ],
        )
      ),
    );
    showDialog(context: context, builder: (context) => errorDialog);
  }


Widget nowIsReacted(BuildContext context,int nowReactionId, int index){
    debugPrint("index "+index.toString());
  switch (nowReactionId) {
    case 0:
      return Container(
        child: Row(
          children: [
            Icon(
              CupertinoIcons
                  .hand_thumbsup,
              size: 15,
            ),
            Text(
              "Like •",
              style: TextStyle(
                  fontSize: 13, color: Colors.black),
            )
          ],
        ),
      );
    case 1:
      return Container(
        child: Row(
          children: [
            Icon(
              CupertinoIcons
                  .hand_thumbsup_fill, color: Colors.blueAccent,
              size: 15,
            ),
            Text(
              "Like •",
              style: TextStyle(
                  fontSize: 13, color: Colors.blueAccent),
            )
          ],
        ),
      );
    case 2:

      return Container(
        child: Row(
          children: [
            Image.asset(
              "assets/icons/love_icon.png", width: 24, height: 24,),
            Text(
              "Love •",
              style: TextStyle(
                  fontSize: 13, color: Colors.redAccent),
            )
          ],
        ),
      );

    case 3:

      return Container(
        child: Row(
          children: [
            Image.asset(
              "assets/icons/haha_icon.png", width: 24, height: 24,),
            Text(
              "Haha •",
              style: TextStyle(
                  fontSize: 13, color: Colors.yellow),
            )
          ],
        ),
      );


    case 4:

      return Container(
        child: Row(
          children: [
            Image.asset(
              "assets/icons/wow_icon.png", width: 24, height: 24,),
            Text(
              "Wow •",
              style: TextStyle(
                  fontSize: 13, color: Colors.blueAccent),
            )
          ],
        ),
      );


    case 5:

      return Container(
        child: Row(
          children: [
            Image.asset(
              "assets/icons/sad_icon.png", width: 24, height: 24,),
            Text(
              "Sad •",
              style: TextStyle(
                  fontSize: 13, color: Colors.orange),
            )
          ],
        ),
      );


    case 6:

      return Container(
        child: Row(
          children: [
            Image.asset(
              "assets/icons/angry_icon.png", width: 24, height: 24,),
            Text(
              "Angry •",
              style: TextStyle(
                  fontSize: 13, color: Colors.blueAccent),
            )
          ],
        ),
      );


    default:

      return Container(
        child: Row(
          children: [
            Icon(CupertinoIcons.hand_thumbsup, size: 15,),
            Text(
              "Like •",
              style: TextStyle(
                  fontSize: 13, color: Colors.black),
            )
          ],
        ),
      );

}
  }

  getPhoto() async{
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      debugPrint(image.name);
    }
  }

  void getPhotoFromCamera()async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      debugPrint(image.name);
    }
  }

  getFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      debugPrint(file.path.toString());
    }
  }
}
