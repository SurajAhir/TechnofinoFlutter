import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:technofino/data_classes/thread_response/Threads.dart';
import 'package:technofino/provider/MyProvider.dart';

import '../../data_classes/attachment_response/AttachmentsData.dart';
import '../../data_classes/post_response/PostsOfThreads.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../services/ApiClient.dart';
import '../bottom_modal_sheet_work/ShowNodesForCreateNew.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
class EditPost extends StatefulWidget {
  PostsOfThreads post;
  Threads threads;
   EditPost(this.threads,this.post,{Key? key}) : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  String title = "";
  var _titleControllar = TextEditingController();
  var _messageControllar = TextEditingController();
  List<AttachmentsData> attachmentList = [];
  String attachmentKey = "";
  var isGeneratedAttachmentKey = false;
@override
  initState(){
  _titleControllar.text=widget.threads.title;
  var message=widget.post.message_parsed;
  debugPrint("post id"+widget.post.post_id.toString());
  if(message.contains("<blockquote class")){
    var bloc=message;
    bloc = bloc.substring(bloc.indexOf("<blockquote class") + 0);
    bloc = bloc.substring(0, bloc.indexOf("</blockquote>"));
    _messageControllar.text=parse(message.replaceAll(bloc, "")).body!.text??"";
  }else {
    _messageControllar.text =
        parse(widget.post.message_parsed).body!.text ?? "";
  }
  getAttachments(widget.post);
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return Scaffold(
      // backgroundColor: Theme.of(context).bottomAppBarColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title:  Text(
          "Edit post",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
        actions: [
          InkWell(
              onTap: () {
                if (_titleControllar.text.isNotEmpty &&
                    _messageControllar.text.isNotEmpty) {
                  showLoaderDialog(context, "Updating...");
                  updatePost(
                      _titleControllar.text, _messageControllar.text);
                }
              },
              child: Icon(Icons.send,color: Theme.of(context).accentColor,)
          ),
          SizedBox(width: 4,)
        ],
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            MyDataClass.isUserLoggedIn
                ? Expanded(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        padding:
                        const EdgeInsets.only(left: 10, right: 10),
                        color: Theme.of(context).bottomAppBarColor,
                        child: TextField(
                          controller: _titleControllar,
                          enabled: false,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "title".tr + "...",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color:
                                  Theme.of(context).accentColor)),
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          minLines: 1,
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
          ],
        ),
      ),
    );
  }

  void updatePost(String title, String message) async {
    // var gettedAttachmentString = "";
    // attachmentList.forEach((element) {
    //   gettedAttachmentString = gettedAttachmentString +
    //       r"""[ATTACH type="full"]""" +
    //       element.attachment_id.toString() +
    //       r"""[/ATTACH]""";
    // });
debugPrint(widget.post.post_id.toString()+"and "+attachmentKey+"and"+MyDataClass.api_key+"and"+MyDataClass.myUserId.toString());

var quote=widget.post.message;
var my_message="";
quote = quote.substring(quote.indexOf("[QUOTE") + 0);
quote = quote.substring(0, quote.indexOf("[/QUOTE]"));
quote=quote+"[/QUOTE]";
if(widget.post.message_parsed.startsWith("<blockquote")){
  my_message=quote+message;
}else{
  my_message=message+quote;
}
    var response =
    await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .updateSpecificPost(MyDataClass.api_key, MyDataClass.myUserId,
        my_message, attachmentKey,widget.post.post_id);
    if (response["success"] == true) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Done'),
      ));
      setState(() {
        _titleControllar.text = "";
        _messageControllar.text = "";
      });
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
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
            .generateAttachmentKeyForUpdateOfSpecificPost(
            MyDataClass.api_key, MyDataClass.myUserId,widget.post.post_id, "post");
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
            .generateAttachmentKeyForUpdateOfSpecificPost(
            MyDataClass.api_key, MyDataClass.myUserId, widget.post.post_id, "post");
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
            .generateAttachmentKeyForUpdateOfSpecificPost(
            MyDataClass.api_key, MyDataClass.myUserId, widget.post.post_id, "post");
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
                var deleteReponse=await http.delete(Uri.parse("https://technofino.in/community/api/attachments/${attachmentList[index].attachment_id}/"),
                headers: {"XF-Api-Key":"p-rQmDsW41tBC768faylyvJcd8KOnp3g","XF-Api-User":"1"});
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

  void getAttachments(PostsOfThreads post) {
  debugPrint(post.post_id.toString());

  if(post.attach_count>0){
    attachmentList.addAll(post.Attachments as List<AttachmentsData>);
    setState((){
      isGeneratedAttachmentKey=true;
    });
  }

  }
}
