import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technofino/data_classes/attachment_response/AttachmentsData.dart';
import 'package:technofino/data_classes/conversation_response/Conversations.dart';
import 'package:technofino/data_classes/post_response/PostsOfThreads.dart';
import 'package:html/parser.dart' show parse;
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../MyWebView.dart';
import '../ReportContent.dart';
import '../nodes_related_classes/ShowImage.dart';
import '../user_profile/UserProfile.dart';
import 'ExpandedReplyConversation.dart';
import 'ReplyToSpecificConversation.dart';
import 'package:html/parser.dart' show parse;
import 'dart:math' as math;
import 'package:html/dom.dart' as dom;
class ReplyConversation extends StatefulWidget {
  Conversations conversation;

  ReplyConversation(this.conversation, {Key? key}) : super(key: key);

  @override
  State<ReplyConversation> createState() => _ReplyConversationState();
}

class _ReplyConversationState extends State<ReplyConversation> {
  RefreshController _refreshController =RefreshController(initialRefresh: false);
  List<PostsOfThreads> messages = [];
  final _scrollControllar = ScrollController();
  List<Conversations> list = [];
  var isLoadingThreads = false;
  var isFirstLoadingConversations = true;
  int page = 1;
  Pagination? pagination;
  int prevPage = 1;
  var isDataAvailbale = false;
  var isFirstTimeOpening = true;
  List<AttachmentsData> attachmentList = [];
  String attachmentKey = "";
  var isGeneratedAttachmentKey = false;
  var _messageControllar = TextEditingController();

  @override
  initState() {
    super.initState();
    getNextData(page);
    // _scrollControllar.addListener(() {
    //   if (_scrollControllar.offset ==
    //       _scrollControllar.position.maxScrollExtent) {
    //     if (page != pagination!.last_page) {
    //       var provider = Provider.of<MyProvider>(context, listen: false);
    //       provider.setisLoadingConversationsMessages(true);
    //       page++;
    //       debugPrint(
    //           "position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
    //       getNextData(page);
    //     } else {
    //       debugPrint(
    //           "position ${pagination!.total} and ${pagination!.current_page}");
    //       var provider = Provider.of<MyProvider>(context, listen: false);
    //       provider.setisLoadingConversationsMessages(false);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    debugPrint(widget.conversation.conversation_id.toString());
    return Scaffold(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        body: SafeArea(
          child:Container(
            color: Theme.of(context).backgroundColor,
            child: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      height: 65,
                      color: Theme.of(context).bottomAppBarColor,
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
                                  backgroundImage: NetworkImage(widget
                                      .conversation.Starter!.avatar_urls.o),
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
                                  backgroundColor: Colors.blueAccent,
                                  child: Text(
                                    "${widget.conversation.Starter!.username.substring(0, 1)}",
                                    style: TextStyle(color: Colors.white),
                                  ),
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
                    Expanded(
                      child: SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: false,
                        controller: _refreshController,
                        onRefresh: () async{
                          debugPrint("refrshing...");
                          page=1;
                          getNextData(page);
                        },
                        child: SingleChildScrollView(
                          controller: _scrollControllar,
                          child: Column(
                            children: [
                              isFirstLoadingConversations||provider.isLoadingConversationsMessages?CircularProgressIndicator()
                                  :Container(
                                color: Colors.black12,
                                child: ListView.builder(
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: ListTile(
                                        leading:
                                        messages[index]
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
                                            backgroundImage:
                                            NetworkImage(
                                                messages[
                                                index]
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
                                            backgroundColor:
                                            Colors.blueAccent,
                                            child: Text(
                                              "${messages[index].User!.username.substring(0, 1)}",
                                              style: TextStyle(
                                                  color: Colors
                                                      .white),
                                            ),
                                          ),
                                        ),
                                        title: Column(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(
                                                            6)),
                                                    color: Theme.of(context)
                                                        .bottomAppBarColor),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    UserProfile(
                                                                        messages[index]
                                                                            .User!)));
                                                      },
                                                      child: Text(
                                                          "  ${messages[index].User!.username}",style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold),),
                                                    ),
                                                    Html(
                                                      data: getFilteredMessage(
                                                          messages[index]
                                                              .message_parsed,
                                                          messages[index]),
                                                      style: {
                                                        "body": Style(
                                                            fontSize:
                                                            FontSize(
                                                                14),
                                                            letterSpacing:
                                                            1),
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
                                                                color: Colors.lightBlueAccent,
                                                                width:
                                                                2.0,
                                                                style: BorderStyle
                                                                    .solid),
                                                          ),
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              left:
                                                              10,top: 4,bottom: 5),
                                                          margin:
                                                          const EdgeInsets
                                                              .only(
                                                              left:
                                                              7),
                                                          backgroundColor: provider.darkTheme?Colors.transparent:Color(0xffe5f6f4),
                                                        ),
                                                        "th": Style(
                                                          padding:
                                                          EdgeInsets
                                                              .all(6),
                                                          backgroundColor:
                                                          Colors.grey,
                                                          border: Border.all(color: Colors
                                                              .black),
                                                        ),
                                                        "td": Style(
                                                          backgroundColor: Colors.white,
                                                          padding:
                                                          EdgeInsets
                                                              .all(6),
                                                          border:  Border.all(color: Colors
                                                              .black),
                                                        ),
                                                        'h5': Style(
                                                            maxLines: 2,
                                                            textOverflow:
                                                            TextOverflow
                                                                .ellipsis),
                                                      },
                                                      customRender: {
                                                        "table": (context,
                                                            child) {
                                                          return SingleChildScrollView(
                                                            scrollDirection:
                                                            Axis.horizontal,
                                                            child: (context
                                                                .tree
                                                            as TableLayoutElement)
                                                                .toWidget(
                                                                context),
                                                          );
                                                        },
                                                      },
                                                      onLinkTap:
                                                          (url,
                                                          RenderContext context1, Map<String, String> attributes, dom.Element? element) async {
                                                        debugPrint(
                                                            "Opening ${element?.text.toString()}");
                                                        var username=element?.text.toString().replaceAll("@","");
                                                        var user =
                                                        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                                                            .findUserByName(MyDataClass.api_key,username.toString());
                                                        var userData=user.exact;
                                                        if(userData!=null){
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      UserProfile(userData
                                                                      )));
                                                        }else{
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => MyWebView(url.toString())));
                                                        }
                                                      },
                                                      onImageTap: (src, _,
                                                          __, ___) {
                                                        debugPrint(src);
                                                        var att = messages[
                                                        index]
                                                            .Attachments;
                                                        att?.forEach(
                                                                (element) {
                                                              if (src ==
                                                                  element
                                                                      .thumbnail_url) {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                            ShowImage(element.attachment_id)));
                                                              }
                                                            });
                                                      },
                                                    ),
                                                  ],
                                                )),
                                            Container(
                                              margin:
                                              EdgeInsets.only(top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    "${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(((messages[index].message_date) * 1000).toInt()))} •",
                                                    style: TextStyle(
                                                        fontSize: 13),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      var message = messages[
                                                      index]
                                                          .message_parsed;
                                                      if (message.contains(
                                                          "<blockquote class=")) {
                                                        var originalMessage =
                                                            messages[index]
                                                                .message_parsed;
                                                        message = message
                                                            .substring(message
                                                            .indexOf(
                                                            "\">") +
                                                            2);
                                                        message = message.substring(
                                                            0,
                                                            message.indexOf(
                                                                "</blockquote>"));
                                                        originalMessage =
                                                            originalMessage
                                                                .replaceAll(
                                                                message,
                                                                "");
                                                        var exactString =
                                                            originalMessage;
                                                        originalMessage =
                                                            originalMessage.substring(
                                                                originalMessage
                                                                    .indexOf(
                                                                    "<blockquote"));
                                                        originalMessage =
                                                            originalMessage.substring(
                                                                0,
                                                                originalMessage
                                                                    .indexOf(
                                                                    "</blockquote>"));
                                                        originalMessage =
                                                            originalMessage +
                                                                "</blockquote>";
                                                        exactString =
                                                            exactString
                                                                .replaceAll(
                                                                originalMessage,
                                                                "");
                                                        debugPrint(
                                                            exactString);
                                                        // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${exactString}[/QUOTE]";4
                                                        var realMessage =
                                                            "<body>${exactString}</body>";
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => ReplyToSpecificConversation(
                                                                    messages[
                                                                    index],
                                                                    realMessage))).then(
                                                                (value) {
                                                              messages.clear();
                                                              getNextData(page);
                                                            });
                                                      } else {
                                                        // var realMessage="[QUOTE=\"${posts[index].User?.username}, post: ${posts[index].post_id}, member: ${posts[index].User?.user_id}\"]${message}[/QUOTE]";
                                                        var realMessage =
                                                            "<body>${message}</body>";
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => ReplyToSpecificConversation(
                                                                    messages[
                                                                    index],
                                                                    realMessage))).then(
                                                                (value) {
                                                              messages.clear();
                                                              getNextData(page);
                                                            });
                                                      }
                                                    },
                                                    child: Text(
                                                      "reply".tr + " •",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                          Theme.of(
                                                              context)
                                                              .bottomAppBarColor,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                    10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                    10)),
                                                          ),
                                                          context: context,
                                                          builder: (context) =>
                                                              Container(
                                                                  height:
                                                                  50,
                                                                  padding:
                                                                  EdgeInsets.all(
                                                                      10),
                                                                  decoration: BoxDecoration(
                                                                      color: Theme.of(context)
                                                                          .bottomAppBarColor,
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(10),
                                                                          topLeft: Radius.circular(10))),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.spaceEvenly,
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      // InkWell(
                                                                      //     onTap: () {
                                                                      //       Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportContent()));
                                                                      //     },
                                                                      //     child: Text("report".tr)),
                                                                      InkWell(
                                                                          onTap: () {
                                                                            debugPrint("link${messages[index].view_url}");
                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyWebView(messages[index].view_url)));
                                                                          },
                                                                          child: Text("open_in_browser".tr))
                                                                    ],
                                                                  ))
                                                        //create a custom widget as you want
                                                      );
                                                    },
                                                    child: Text(
                                                      "•••",
                                                      textAlign:
                                                      TextAlign.start,
                                                    ),
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
                                ),),
                              provider.isPaginationAval ==
                                  true &&
                                  isFirstLoadingConversations == false
                                  ? Container(
                                color: provider.darkTheme
                                    ? Colors.black
                                    : Colors.black12,
                                height: 100,
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Transform.rotate(
                                        angle: 180 * math.pi / 180,
                                        child: InkWell(
                                            onTap: () {
                                              if (page == 1) {
                                                return;
                                              } else {
                                                provider
                                                    .setisLoadingConversationsMessages(
                                                    true);
                                                page = 1;
                                                getNextData(page);
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
                                              provider
                                                  .setisLoadingConversationsMessages(
                                                  true);
                                              page--;
                                              getNextData(page);
                                            }
                                          },
                                          child: const Icon(
                                              Icons
                                                  .keyboard_arrow_right_outlined,
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
                                          if (page ==
                                              pagination?.last_page) {
                                            return;
                                          } else {
                                            provider.setisLoadingConversationsMessages(
                                                true);
                                            page++;
                                            getNextData(page);
                                          }
                                        },
                                        child: const Icon(
                                            Icons
                                                .keyboard_arrow_right_outlined,
                                            size: 30)),
                                    InkWell(
                                        onTap: () {
                                          if (page ==
                                              pagination?.last_page) {
                                            return;
                                          } else {
                                            provider.setisLoadingConversationsMessages(
                                                true);
                                            page =
                                                pagination?.last_page ?? 1;
                                            getNextData(page);
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
                                  : const SizedBox(height: 60),
                              if(provider.isPaginationAval ==true)
                                SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (isGeneratedAttachmentKey)
                      Material(
                        elevation: 15,
                        child: Container(
                          height: 70,
                          color: provider.darkTheme
                              ? Colors.black54
                              : Colors.black12,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Widget cancelButton = TextButton(
                                    child: Text("cancel".tr),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                  Widget okButton = TextButton(
                                    child: Text("ok".tr),
                                    onPressed: () {
                                      attachmentList.removeAt(index);
                                      Navigator.pop(context);
                                      if (attachmentList.isEmpty) {
                                        isGeneratedAttachmentKey = false;
                                        attachmentKey = "";
                                      }
                                      setState(() {});
                                    },
                                  );
                                  AlertDialog alert = AlertDialog(
                                    title: Text("delete".tr),
                                    content: Text(
                                        "${attachmentList[index].filename}"),
                                    actions: [
                                      cancelButton,
                                      okButton,
                                    ],
                                  );

                                  // show the dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return showDialogForImage(attachmentList, index);
                                    },
                                  );
                                },
                                child: attachmentList[index]
                                            .filename
                                            .contains(".pdf") ||
                                        attachmentList[index]
                                            .filename
                                            .contains(".txt")
                                    ? Container(
                                        width: 60,
                                        height: 60,
                                        alignment: Alignment.center,
                                        color: provider.darkTheme
                                            ? Colors.white
                                            : Colors.black38,
                                        child: Expanded(
                                            child: Icon(
                                          CupertinoIcons.doc_on_clipboard_fill,
                                          size: 50,
                                        )),
                                      )
                                    : Image(
                                        image: NetworkImage(
                                            attachmentList[index]
                                                .thumbnail_url)),
                              );
                            },
                            itemCount: attachmentList.length,
                          ),
                        ),
                      ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: Material(
                          elevation: 15,
                          child: Container(
                            color: provider.darkTheme
                                ? Colors.black54
                                : Colors.black12,
                            padding: EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 2,
                                ),
                                InkWell(
                                  onTap: () {
                                    showModalBottomSheet(
                                        backgroundColor:
                                            Theme.of(context).bottomAppBarColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10))),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            height: 200,
                                            color: Theme.of(context)
                                                .bottomAppBarColor,
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                    onTap: () async {
                                                      var status =
                                                          await Permission
                                                              .photos;
                                                      if (await status
                                                          .isGranted) {
                                                        getPhoto();
                                                      } else {
                                                        status.request();
                                                      }
                                                    },
                                                    child: Text(
                                                      "photo".tr,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    )),
                                                InkWell(
                                                    onTap: () async {
                                                      var status =
                                                          await Permission
                                                              .camera;
                                                      if (await status
                                                          .isGranted) {
                                                        getPhotoFromCamera();
                                                      } else {
                                                        status.request();
                                                      }
                                                    },
                                                    child: Text(
                                                      "take_photo".tr,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    )),
                                                InkWell(
                                                    onTap: () async {
                                                      var status =
                                                          await Permission
                                                              .storage;
                                                      if (await status
                                                          .isGranted) {
                                                        getFile();
                                                      } else {
                                                        status.request();
                                                      }
                                                    },
                                                    child: Text(
                                                      "file".tr,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    )),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ExpandedReplyConversation(
                                                                    widget
                                                                        .conversation)));
                                                  },
                                                  child: Text(
                                                    "expanded_editor".tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context)
                                                            .accentColor),
                                                  ),
                                                ),
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
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 4, right: 4),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: TextField(
                                      controller: _messageControllar,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: "write_a_comment".tr + "...",
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                      ),
                                      textInputAction: TextInputAction.newline,
                                      keyboardType: TextInputType.multiline,
                                      minLines: 1,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_messageControllar.text.isNotEmpty) {
                                      showLoaderDialog(context, "sending".tr);
                                      postReply(
                                          context, _messageControllar.text);
                                    }
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    child: Icon(Icons.send,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                )
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

  void getNextData(int page) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var conversationResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getConversationMessages(
      MyDataClass.api_key,
      MyDataClass.myUserId,
      widget.conversation.conversation_id,
      page,
    );
    var pagination = conversationResponse.pagination as Pagination;
    if(_refreshController.isRefresh){
      if(conversationResponse.messages.isNotEmpty){
        messages.clear();
      }
      _refreshController.refreshCompleted();
    }
    if(isFirstTimeOpening){
      isFirstTimeOpening=false;
      this.page=pagination.last_page;
      getNextData(pagination.last_page);
    }
   else{
      debugPrint(pagination.toString());
      if (pagination != null && pagination.last_page > 1) {
        this.pagination = pagination;
        provider.setPagination(true);
      } else {
        provider.setPagination(false);
      }
      if(_refreshController.isRefresh){
        _refreshController.refreshCompleted();
      }
      messages.clear();
      messages.addAll(conversationResponse.messages);
      provider.setisLoadingConversationsMessages(false);
      setState(() {
        isFirstLoadingConversations = false;
      });
    }

  }


  getPhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Navigator.pop(context);
      showLoaderDialog(context, "Loading");
      debugPrint(image.path);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
                Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                File(image.path), attachmentKey);
        if (response1.isNotEmpty) {
          var attachment = response1["attachment"] as AttachmentsData;
          attachmentList.add(attachment);
          setState(() {
            Navigator.pop(context);
            isGeneratedAttachmentKey = true;
          });
        }
      } else {
        var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .generateAttachmentKeyForReplyConversation(
                    MyDataClass.api_key,
                    MyDataClass.myUserId,
                    widget.conversation.conversation_id,
                    "conversation_message");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          var response1 = await ApiClient(
                  Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                  File(image.path), key.toString());
          if (response1.isNotEmpty) {
            var attachment = response1["attachment"] as AttachmentsData;
            attachmentList.add(attachment);
            setState(() {
              Navigator.pop(context);
              isGeneratedAttachmentKey = true;
            });
          }
        }
      }
    }
  }

  void getPhotoFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      debugPrint(image.name);
      Navigator.pop(context);
      showLoaderDialog(context, "Loading");
      debugPrint(image.path);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
                Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                File(image.path), attachmentKey);
        if (response1.isNotEmpty) {
          var attachment = response1["attachment"] as AttachmentsData;
          attachmentList.add(attachment);
          setState(() {
            Navigator.pop(context);
            isGeneratedAttachmentKey = true;
          });
          debugPrint(attachment.toString());
        }
      } else {
        var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .generateAttachmentKeyForReplyConversation(
                    MyDataClass.api_key,
                    MyDataClass.myUserId,
                    widget.conversation.conversation_id,
                    "conversation_message");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          debugPrint(key.toString());
          var response1 = await ApiClient(
                  Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                  File(image.path), key.toString());
          if (response1.isNotEmpty) {
            var attachment = response1["attachment"] as AttachmentsData;
            attachmentList.add(attachment);
            setState(() {
              Navigator.pop(context);
              isGeneratedAttachmentKey = true;
            });
            debugPrint(attachment.toString());
          }
        }
      }
    }
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      debugPrint(file.path.toString());
      Navigator.pop(context);
      showLoaderDialog(context, "loading".tr);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
                Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                File(file.path), attachmentKey);
        if (response1.isNotEmpty) {
          var attachment = response1["attachment"] as AttachmentsData;
          attachmentList.add(attachment);
          setState(() {
            Navigator.pop(context);
            isGeneratedAttachmentKey = true;
          });
          debugPrint(attachment.toString());
        }
      } else {
        var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .generateAttachmentKeyForReplyConversation(
                    MyDataClass.api_key,
                    MyDataClass.myUserId,
                    widget.conversation.conversation_id,
                    "conversation_message");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          debugPrint(key.toString());
          var response1 = await ApiClient(
                  Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(MyDataClass.api_key, MyDataClass.myUserId,
                  File(file.path), key.toString());
          if (response1.isNotEmpty) {
            var attachment = response1["attachment"] as AttachmentsData;
            attachmentList.add(attachment);
            setState(() {
              Navigator.pop(context);
              isGeneratedAttachmentKey = true;
            });
            debugPrint(attachment.toString());
          }
        }
      }
    }
  }

  showLoaderDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text("$message...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false, //this is default method which flutter provides
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void postReply(BuildContext context, String message) async {
    // var gettedAttachmentString = "";
    // attachmentList.forEach((element) {
    //   gettedAttachmentString = gettedAttachmentString +
    //       r"""[ATTACH type="full"]""" +
    //       element.attachment_id.toString() +
    //       r"""[/ATTACH]""";
    // });

    var response =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .postConversationReply(
                MyDataClass.api_key,
                MyDataClass.myUserId,
                widget.conversation.conversation_id,
                message,
                attachmentKey);
    Navigator.pop(context);
    _messageControllar.text = "";
    attachmentList.clear();
    attachmentKey = "";
    isGeneratedAttachmentKey = false;
    setState(() {
      messages.clear();
      getNextData(page);
    });
    debugPrint(response.toString());
  }

  Dialog showDialogForImage(List<AttachmentsData> attachmentList, int index){
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              onTap: (){
                var attachmentString=r"""[ATTACH type="full"]"""+attachmentList[index].attachment_id.toString()+r"""[/ATTACH]""";
                var mess=_messageControllar.text;
                if(!mess.contains(attachmentString)){
                  _messageControllar.text=mess+attachmentString;
                  Navigator.pop(context);
                  setState((){

                  });
                }
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new,size: 14,),
                  Icon(Icons.image,size: 14),
                  Icon(Icons.arrow_forward_ios,size: 14),
                  SizedBox(width: 6,),
                  Text("Inline",style: TextStyle(color: Theme.of(context).accentColor),)
                ],
              ),
            ),
            InkWell(
              onTap: ()async{
                debugPrint(attachmentList[index].attachment_id.toString());
                var attachmentString=r"""[ATTACH type="full"]"""+attachmentList[index].attachment_id.toString()+r"""[/ATTACH]""";
                var mess=_messageControllar.text;
                _messageControllar.text=mess.replaceAll(attachmentString,"");
                attachmentList.removeAt(index);
                Navigator.pop(context);
                if (attachmentList.isEmpty) {
                  isGeneratedAttachmentKey = false;
                  attachmentKey = "";
                }
                setState(() {});
                // var deleteReponse=await http.delete(Uri.parse("https://technofino.in/community/api/attachments/${attachmentList[index].attachment_id}/"));
                // var response=jsonDecode(deleteReponse.body) as Map;
                // if(response["success"]){
                //
                // }

              },
              child: Row(
                children: [
                  SizedBox(width: 8,),
                  Icon(Icons.delete),
                  SizedBox(width: 6,),
                  Text("Delete",style: TextStyle(color: Theme.of(context).accentColor),)
                ],
              ),
            )
          ],
        ),
      ),
    );
    return errorDialog;
  }
}
