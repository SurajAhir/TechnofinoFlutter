import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:technofino/provider/MyProvider.dart';

import '../../data_classes/attachment_response/AttachmentsData.dart';
import '../../data_classes/user_profile_posts_response/ProfilePosts.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../services/ApiClient.dart';
import '../bottom_modal_sheet_work/ShowNodesForCreateNew.dart';
import 'package:html/parser.dart' show parse;

class ReplyOnUserProfilePosts extends StatefulWidget {
  ProfilePosts conversation;
  String receivedMessage="";
  ReplyOnUserProfilePosts(this.conversation, this.receivedMessage, {Key? key}) : super(key: key);

  @override
  State<ReplyOnUserProfilePosts> createState() => _ReplyOnUserProfilePostsState();
}

class _ReplyOnUserProfilePostsState extends State<ReplyOnUserProfilePosts> {
  var _firstMessageControllar = TextEditingController();
  var _lastMessageControllar = TextEditingController();
  List<AttachmentsData> attachmentList = [];
  String attachmentKey = "";
  var isGeneratedAttachmentKey = false;
  var firstTextField=false;
  var lastTextField=false;
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Card(
                elevation: 2,shadowColor:Theme.of(context).bottomAppBarColor,
                child: SizedBox(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(

                        onTap: (){
                          Widget cancelButton = TextButton(
                            child: Text("cancel".tr),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          Widget okButton = TextButton(
                            child: Text("ok".tr),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          );
                          AlertDialog alert = AlertDialog(
                            title: Text("are_you_sure_you_want_to_discard_changes".tr),
                            actions: [
                              cancelButton,
                              okButton,
                            ],
                          );

                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: Text(
                          "cancel".tr,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        "post_reply".tr,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          InkWell(
                              onTap: (){
                                if(_firstMessageControllar.text.isNotEmpty||_lastMessageControllar.text.isNotEmpty){
                                  var message=widget.conversation.message;
                                  if(message.contains("[/QUOTE]")){
                                    var originalMessage=widget.conversation.message;
                                    message = message.substring(message.indexOf("\"]") + 2);
                                    message = message.substring(0, message.indexOf("[/QUOTE]"));
                                    originalMessage=originalMessage.replaceAll(message, "");
                                    var exactString=originalMessage;
                                    originalMessage=originalMessage.substring(originalMessage.indexOf("[QUOTE"));
                                    originalMessage=originalMessage.substring(0, originalMessage.indexOf("[/QUOTE]"));
                                    originalMessage=originalMessage+"[/QUOTE]";
                                    exactString=exactString.replaceAll(originalMessage,"");
                                    debugPrint(exactString);
                                    var realMessage="[QUOTE=\"${widget.conversation.User?.username}, post: ${widget.conversation.profile_post_id}, member: ${widget.conversation.User?.user_id}\"]${exactString}[/QUOTE]";
                                    postReply(context, _firstMessageControllar.text+realMessage+_lastMessageControllar.text);
                                  }else{
                                    var realMessage="[QUOTE=\"${widget.conversation.User?.username}, post: ${widget.conversation.profile_post_id}, member: ${widget.conversation.User?.user_id}\"]${message}[/QUOTE]";
                                    postReply(context, _firstMessageControllar.text+realMessage+_lastMessageControllar.text);
                                  }
                                }
                              },
                              child: Icon(Icons.send_rounded,color: Theme.of(context).accentColor,)),
                          SizedBox(width: 8,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        TextField(
                          controller: _firstMessageControllar,
                          onTap: (){
                            firstTextField=true;
                            lastTextField=false;
                          },
                          style: TextStyle(color: Theme.of(context).accentColor),
                          decoration:  InputDecoration(
                              hintText: "message".tr, border: InputBorder.none,contentPadding: EdgeInsets.only(left: 8),
                          hintStyle: TextStyle(color: Theme.of(context).accentColor)),
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: null,
                        ),
                        Html(
                          data: getFilteredMessage(
                              widget.receivedMessage,
                              widget.conversation),
                          style: {
                            "body": Style(
                                backgroundColor: provider.darkTheme?Colors.transparent:Color(0xffe5f6f4),
                                fontSize:
                                FontSize(14),
                                letterSpacing: 1,
                                border:  Border(
                                  left: BorderSide(
                                      color: Colors.lightBlueAccent,
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
                                    left: 20,right: 8)),
                            "table": Style(
                              backgroundColor:
                              const Color
                                  .fromARGB(
                                  0x50,
                                  0xee,
                                  0xee,
                                  0xee),
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
                        ),
                        Container(
                          padding: EdgeInsets.all(6),
                          child: TextField(
                            controller: _lastMessageControllar,
                            onTap: (){
                              firstTextField=false;
                              lastTextField=true;
                            },
                            style: TextStyle(color: Theme.of(context).accentColor),
                            decoration:  InputDecoration(
                                hintText: "message".tr, border: InputBorder.none,
                            hintStyle: TextStyle(color: Theme.of(context).accentColor)),
                            keyboardType: TextInputType.multiline,
                            minLines: 10,
                            maxLines: null,
                          ),
                        ),
                        SizedBox(height: 100,),
                        const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text("Photos, Files",style: TextStyle(fontSize: 15),)),
                        Container(
                          height: 100,
                          padding: EdgeInsets.only(left: 8),
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              if (isGeneratedAttachmentKey)
                                ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
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
                                          content:
                                          Text("${attachmentList[index].filename}"),
                                          actions: [
                                            cancelButton,
                                            okButton,
                                          ],
                                        );

                                        // show the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return showDialogForImage(attachmentList,index);
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
                                        color: Colors.black38,
                                        child: Expanded(
                                            child: Icon(CupertinoIcons.doc_on_clipboard_fill,size: 50,)
                                        ),
                                      )
                                          : Image(
                                          image: NetworkImage(
                                              attachmentList[index].thumbnail_url)),
                                    );
                                  },
                                  itemCount: attachmentList.length,
                                ),
                              InkWell(
                                onTap: (){
                                  showModalBottomSheet(
                                      backgroundColor: Theme.of(context).bottomAppBarColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10))),
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 200,
                                          color: Theme.of(context).bottomAppBarColor,
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
                                                    await Permission.photos;
                                                    if (await status.isGranted) {
                                                      getPhoto();
                                                    } else {
                                                      status.request();
                                                    }
                                                  },
                                                  child: Text(
                                                    "photo".tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context).accentColor),
                                                  )),
                                              InkWell(
                                                  onTap: () async {
                                                    var status =
                                                    await Permission.camera;
                                                    if (await status.isGranted) {
                                                      getPhotoFromCamera();
                                                    } else {
                                                      status.request();
                                                    }
                                                  },
                                                  child: Text(
                                                    "take_photo".tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context).accentColor),
                                                  )),
                                              InkWell(
                                                  onTap: () async {
                                                    var status =
                                                    await Permission.storage;
                                                    if (await status.isGranted) {
                                                      getFile();
                                                    } else {
                                                      status.request();
                                                    }
                                                  },
                                                  child: Text(
                                                    "file".tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Theme.of(context).accentColor),
                                                  )),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.black12,
                                  width: 100,
                                  child: Icon(Icons.add_photo_alternate_outlined,color: Theme.of(context).accentColor,),
                                ),
                              )
                            ] ,
                          ),
                        )

                      ]
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getFilteredMessage(String message_parsed, ProfilePosts post) {
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
  getPhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Navigator.pop(context);
      showLoaderDialog(context,"Loading");
      debugPrint(image.path);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
            Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(
            MyDataClass.api_key, MyDataClass.myUserId, File(image.path), attachmentKey);
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
            .generateAttachmentKeyForUserProfilePostsOfComments(
            MyDataClass.api_key,
            MyDataClass.myUserId,
            widget.conversation.profile_post_id,
            "profile_post_comment");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          debugPrint(key.toString());
          var response1 = await ApiClient(
              Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(
              MyDataClass.api_key, MyDataClass.myUserId, File(image.path), key.toString());
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

  void getPhotoFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      debugPrint(image.name);
      Navigator.pop(context);
      showLoaderDialog(context,"Loading");
      debugPrint(image.path);
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
            Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(
            MyDataClass.api_key, MyDataClass.myUserId, File(image.path), attachmentKey);
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
            .generateAttachmentKeyForUserProfilePostsOfComments(
            MyDataClass.api_key,
            MyDataClass.myUserId,
            widget.conversation.profile_post_id,
            "profile_post_comment");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          debugPrint(key.toString());
          var response1 = await ApiClient(
              Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(
              MyDataClass.api_key, MyDataClass.myUserId, File(image.path), key.toString());
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
      showLoaderDialog(context,"Loading");
      if (attachmentKey.isNotEmpty) {
        var response1 = await ApiClient(
            Dio(BaseOptions(contentType: "multipart/form-data")))
            .postAttachmentFile(
            MyDataClass.api_key, MyDataClass.myUserId, File(file.path), attachmentKey);
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
            .generateAttachmentKeyForUserProfilePostsOfComments(
            MyDataClass.api_key,
            MyDataClass.myUserId,
            widget.conversation.profile_post_id,
            "profile_post_comment");
        if (response.isNotEmpty) {
          var key = response["key"].toString();
          attachmentKey = key;
          debugPrint(key.toString());
          var response1 = await ApiClient(
              Dio(BaseOptions(contentType: "multipart/form-data")))
              .postAttachmentFile(
              MyDataClass.api_key, MyDataClass.myUserId, File(file.path), key.toString());
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

  showLoaderDialog(BuildContext context,String message) {
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

  void postReply(BuildContext context, String message) async{
    showLoaderDialog(context, "Sending");
    // var gettedAttachmentString="";
    // attachmentList.forEach((element) {
    //   gettedAttachmentString=gettedAttachmentString+r"""[ATTACH type="full"]"""+element.attachment_id.toString()+r"""[/ATTACH]""";
    // });

    var response = await ApiClient(
        Dio(BaseOptions(contentType: "application/json")))
        .getResponseOfUserProfilePostsOfComments(
        MyDataClass.api_key, MyDataClass.myUserId, widget.conversation.profile_post_id,message,attachmentKey);
    debugPrint(response["success"].toString());
    Navigator.pop(context);
    Navigator.pop(context);

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
                if(firstTextField){
                  var mess=_firstMessageControllar.text;
                  if(!mess.contains(attachmentString)){
                    _firstMessageControllar.text=mess+attachmentString;
                    Navigator.pop(context);
                    setState((){

                    });
                  }
                }else if(lastTextField){
                  var mess=_lastMessageControllar.text;
                  if(!mess.contains(attachmentString)){
                    _lastMessageControllar.text=mess+attachmentString;
                    Navigator.pop(context);
                    setState((){

                    });
                  }
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
                var firstmess=_firstMessageControllar.text;
                var lastmess=_lastMessageControllar.text;
                if(firstmess.contains(attachmentString)){
                  _firstMessageControllar.text=firstmess.replaceAll(attachmentString,"");
                  attachmentList.removeAt(index);
                  Navigator.pop(context);
                  if (attachmentList.isEmpty) {
                    isGeneratedAttachmentKey = false;
                    attachmentKey = "";
                  }
                  setState(() {});
                }else if(lastmess.contains(attachmentString)){
                  _lastMessageControllar.text=lastmess.replaceAll(attachmentString,"");
                  attachmentList.removeAt(index);
                  Navigator.pop(context);
                  if (attachmentList.isEmpty) {
                    isGeneratedAttachmentKey = false;
                    attachmentKey = "";
                  }
                  setState(() {});
                }
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