import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technofino/data_classes/conversation_response/Conversations.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreads.dart';
import 'package:html/parser.dart' show parse;
import 'dart:math' as math;
import '../../data_classes/conversation_response/ConversationMessages.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../nodes_related_classes/ShowImage.dart';
import '../user_profile/UserProfile.dart';

class ReplyConversation extends StatefulWidget {
  Conversations conversation;

  ReplyConversation(this.conversation, {Key? key}) : super(key: key);

  @override
  State<ReplyConversation> createState() => _ReplyConversationState();
}

class _ReplyConversationState extends State<ReplyConversation> {
  List<PostsOfThreads> messages = [];

  final _scrollControllar = ScrollController();
  List<Conversations> list = [];
  var isLoadingThreads = false;
  var isFirstLoadingConversations = true;
  int page = 1;
  Pagination? pagination;
  var isDataAvailbale = false;

  @override
  initState() {
    super.initState();
    getData(page);
    _scrollControllar.addListener(() {
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingConversationsMessages(true);
          page++;
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        } else {
          debugPrint(
              "position ${pagination!.total} and ${pagination!.current_page}");
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingConversationsMessages(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.conversation.conversation_id.toString());
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
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: ListTile(
                  leading: widget.conversation.Starter!.avatar_urls.o
                          .toString()
                          .isNotEmpty
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile(
                                        widget.conversation.Starter!)));
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                widget.conversation.Starter!.avatar_urls.o),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile(
                                        widget.conversation.Starter!)));
                          },
                          child: CircleAvatar(
                            child: Text(
                                "${widget.conversation.Starter!.username.substring(0, 1)}"),
                          ),
                        ),
                  title: Text(
                    "${widget.conversation.username}",
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    "${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(((widget.conversation.start_date) * 1000).toInt()))}",
                    maxLines: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              isFirstLoadingConversations == false
                  ? Expanded(
                      child: SingleChildScrollView(
                        controller: _scrollControllar,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.black12,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: ListTile(
                                      leading: messages[index]
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
                                                            UserProfile(
                                                                messages[index]
                                                                    .User!)));
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    messages[index]
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
                                                            UserProfile(
                                                                messages[index]
                                                                    .User!)));
                                              },
                                              child: CircleAvatar(
                                                child: Text(
                                                    "${messages[index].User!.username.substring(0, 1)}"),
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
                                                      "  ${messages[index].User!.username}"),
                                                  Html(
                                                    data: getFilteredMessage(
                                                        messages[index]
                                                            .message_parsed,
                                                        messages[index]),
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
                                                      var att = messages[index]
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
                                                  ),
                                                ],
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(((messages[index].message_date) * 1000).toInt()))} •",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
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
                                itemCount: messages.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : isDataAvailbale == false
                      ? const Center(child: CircularProgressIndicator())
                      : const Center(
                          child: Text("No Conversations found!"),
                        ),
              if (Provider.of<MyProvider>(context)
                  .isLoadingConversationsMessages)
                const CircularProgressIndicator.adaptive(),
              SizedBox(
                height: 55,
              )
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
                      Icon(
                        Icons.link,
                        size: 25,
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
                      CircleAvatar(
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
    var conversationResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getConversationMessages(
      MyDataClass.api_key,
      625,
      widget.conversation.conversation_id,
      page,
    );
    pagination = conversationResponse.pagination;
    messages.addAll(conversationResponse.messages);
    if (messages.isEmpty) {
      isDataAvailbale = true;
    }
    debugPrint(messages.toString());
    provider.setisLoadingConversationsMessages(false);
    setState(() {
      isFirstLoadingConversations = false;
    });
  }
}
