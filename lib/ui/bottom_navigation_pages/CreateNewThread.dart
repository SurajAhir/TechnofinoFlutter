import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../data_classes/attachment_response/AttachmentsData.dart';
import '../../data_classes/thread_response/Threads.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import '../bottom_modal_sheet_work/ShowNodesForCreateNew.dart';
import 'dart:convert' as convert;

import '../nodes_related_classes/ShowPostsOfThreads.dart';
class CreateNewThread extends StatefulWidget {
  const CreateNewThread({Key? key}) : super(key: key);

  @override
  State<CreateNewThread> createState() => _CreateNewThreadState();
}

class _CreateNewThreadState extends State<CreateNewThread> {
  var isDataGetted = false;
  var isThreadSelected=false;
  String title = "";
  int node_id = 0;
  var _titleControllar = TextEditingController();
  var _messageControllar = TextEditingController();
  List<AttachmentsData> attachmentList = [];
  String attachmentKey = "";
  var isGeneratedAttachmentKey = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Container(
                  height: 55,
                  color: Theme.of(context).bottomAppBarColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "create_new_thread".tr,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                          onTap: () {
                           if(isThreadSelected){
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
                                                   color: Theme.of(context)
                                                       .accentColor),
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
                                                   color: Theme.of(context)
                                                       .accentColor),
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
                                                   color: Theme.of(context)
                                                       .accentColor),
                                             )),
                                       ],
                                     ),
                                   );
                                 });
                           }
                          },
                          child: Icon(Icons.attachment_sharp,color: isThreadSelected?Theme.of(context).accentColor:provider.darkTheme?Color(0xffdfd7d7):Colors.black12,)),
                      SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          if (_titleControllar.text.isNotEmpty &&
                              _messageControllar.text.isNotEmpty) {
                            showLoaderDialog(context, "loading");
                            postThread(
                                _titleControllar.text, _messageControllar.text);
                          }
                        },
                        child: Text(
                          "post".tr,
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              MyDataClass.isUserLoggedIn
                  ? Expanded(
                      child: Container(
                        color: Theme.of(context).backgroundColor,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                          backgroundColor: Theme.of(context)
                                              .bottomAppBarColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                topLeft: Radius.circular(10)),
                                          ),
                                          context: context,
                                          builder: (context) =>
                                              ShowNodesForCreateNew(context))
                                      .then((value) {
                                    if (value[1] != null) {
                                      setState(() {
                                        debugPrint(value[0].toString());
                                        node_id = value[0];
                                        title = value[1];
                                        isDataGetted = true;
                                        isThreadSelected=true;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                    margin: EdgeInsets.all(15),
                                    padding: EdgeInsets.all(0),
                                    color: Theme.of(context).bottomAppBarColor,
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("post_thread_in_forum".tr),
                                          if (isDataGetted)
                                            Text(
                                              "${title}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: provider.darkTheme
                                                      ? Colors.white
                                                      : Colors.black45),
                                            )
                                        ],
                                      ),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.all(15),
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                color: Theme.of(context).bottomAppBarColor,
                                child: TextField(
                                  controller: _titleControllar,
                                  decoration: InputDecoration(
                                      hintText: "title".tr + "...",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color:
                                              Theme.of(context).accentColor)),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width,
                                color: Theme.of(context).bottomAppBarColor,
                                child: TextField(
                                  controller: _messageControllar,
                                  decoration: InputDecoration(
                                      hintText: "message".tr,
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color:
                                              Theme.of(context).accentColor)),
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  keyboardType: TextInputType.multiline,
                                  minLines: 10,
                                  maxLines: null,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "you_must_log_in_to_perform_this_action".tr,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).accentColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/login");
                                },
                                child: Text(
                                  "log_in".tr,
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                    )),
              if (isGeneratedAttachmentKey)
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 70,
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
                                    color: Colors.black38,
                                    child: Expanded(
                                        child: Icon(
                                      CupertinoIcons.doc_on_clipboard_fill,
                                      size: 50,
                                    )),
                                  )
                                : Image(
                                    image: NetworkImage(
                                        attachmentList[index].thumbnail_url)),
                          );
                        },
                        itemCount: attachmentList.length,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void postThread(String title, String message) async {
    // var gettedAttachmentString = "";
    // attachmentList.forEach((element) {
    //   gettedAttachmentString = gettedAttachmentString +
    //       r"""[ATTACH type="full"]""" +
    //       element.attachment_id.toString() +
    //       r"""[/ATTACH]""";
    // });

    var response =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .postThread(MyDataClass.api_key, MyDataClass.myUserId, node_id,
                title, message, attachmentKey);
    if (response.success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Done'),
      ));
      var thread=response.thread;
      setState(() {
        _titleControllar.text = "";
        _messageControllar.text = "";
        isDataGetted = false;
        title = "";
        node_id = 0;
      });
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              ShowPostsOfThreads(
                  thread.Forum !=
                      null
                      ? thread
                      .Forum!
                      .breadcrumbs![
                  0]
                      .title
                      .toString()
                      : "",
                  thread.Forum !=
                      null
                      ? thread
                      .Forum!
                      .title
                      : "",
                  thread,
                  1,
                  "")));
    }
    else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong!'),
      ));
    }
  }

  showLoaderDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text("$message".tr + "...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
          debugPrint(attachment.toString());
        }
      } else {
        var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .generateAttachmentKeyForPostsOfThreads(
                    MyDataClass.api_key, MyDataClass.myUserId, node_id, "post");
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
                .generateAttachmentKeyForPostsOfThreads(
                    MyDataClass.api_key, MyDataClass.myUserId, node_id, "post");
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
      showLoaderDialog(context, "Loading");
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
                .generateAttachmentKeyForPostsOfThreads(
                    MyDataClass.api_key, MyDataClass.myUserId, node_id, "post");
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
                var attachmentString="\n"+r"""[ATTACH type="full"]"""+attachmentList[index].attachment_id.toString()+r"""[/ATTACH]"""+"\n";
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
