import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../data_classes/thread_response/Threads.dart';
import '../../data_classes/attachment_response/AttachmentsData.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import 'package:http/http.dart' as http;
class ExpandedReplyForPostsOfThreads extends StatefulWidget {
  Threads thread;
  ExpandedReplyForPostsOfThreads(this.thread, {Key? key}) : super(key: key);

  @override
  State<ExpandedReplyForPostsOfThreads> createState() => _ExpandedReplyForPostsOfThreadsState();
}

class _ExpandedReplyForPostsOfThreadsState extends State<ExpandedReplyForPostsOfThreads> {
  final _messageControllar = TextEditingController();
  List<AttachmentsData> attachmentList = [];
  String attachmentKey = "";
  var isGeneratedAttachmentKey = false;
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
                elevation: 2,shadowColor: Theme.of(context).accentColor,
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
                                if(_messageControllar.text.isNotEmpty){
                                  showLoaderDialog(context,"sending".tr);
                                  postReply(context,_messageControllar.text);
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
                child: Container(
                  color: Theme.of(context).bottomAppBarColor,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            padding: EdgeInsets.all(6),
                            child: TextField(
                              controller: _messageControllar,
                              decoration:  InputDecoration(
                                  hintText: "message".tr, border: InputBorder.none,hintStyle: TextStyle(color: Theme.of(context).accentColor)),
                              keyboardType: TextInputType.multiline,
                              minLines: 8,
                              style: TextStyle(color: Theme.of(context).accentColor),
                              maxLines: null,
                            ),
                          ),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
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
            .generateAttachmentKeyForPostsOfThreads(
            MyDataClass.api_key,
            MyDataClass.myUserId,
            widget.thread.thread_id,
            "conversation_message");
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
            .generateAttachmentKeyForPostsOfThreads(
            MyDataClass.api_key,
            MyDataClass.myUserId,
            widget.thread.thread_id,
            "conversation_message");
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
            .generateAttachmentKeyForPostsOfThreads(
            MyDataClass.api_key,
            MyDataClass.myUserId,
            widget.thread.thread_id,
            "conversation_message");
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
debugPrint(message);
    // var gettedAttachmentString="";
    // attachmentList.forEach((element) {
    //   gettedAttachmentString=gettedAttachmentString+r"""[ATTACH type="full"]"""+element.attachment_id.toString()+r"""[/ATTACH]""";
    // });

    var response = await ApiClient(
        Dio(BaseOptions(contentType: "application/json")))
        .getResponseOfPostsOfThreadsComments(
        MyDataClass.api_key, MyDataClass.myUserId, widget.thread.thread_id,message,attachmentKey);
    Navigator.pop(context);
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