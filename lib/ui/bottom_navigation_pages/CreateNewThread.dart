import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main_data_class/MyDataClass.dart';
import '../../services/ApiClient.dart';
import '../bottom_modal_sheet_work/ShowNodesForCreateNew.dart';

class CreateNewThread extends StatefulWidget {
  const CreateNewThread({Key? key}) : super(key: key);

  @override
  State<CreateNewThread> createState() => _CreateNewThreadState();
}

class _CreateNewThreadState extends State<CreateNewThread> {
  var isDataGetted = false;
  String title = "";
  int node_id = 0;
var _titleControllar=TextEditingController();
var _messageControllar=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "Create new thread",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    InkWell(
                      onTap: (){
                        if(_titleControllar.text.isNotEmpty&&_messageControllar.text.isNotEmpty){
                          showLoaderDialog(context);
                          postThread(_titleControllar.text,_messageControllar.text);
                        }
                      },
                      child: Text(
                        "Post",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
            MyDataClass.isUserLoggedIn?
            Expanded(
              child: Container(
                color: Colors.black12,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                              ),
                              context: context,
                              builder: (context) =>
                                  ShowNodesForCreateNew(context)).then((value){
                           if(value[1]!=null){
                             setState((){
                               debugPrint(value[0].toString());
                               node_id=value[0];
                               title=value[1];
                               isDataGetted=true;
                             });
                           }
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(0),
                            color: Colors.white,
                            child:
                            ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Post thread in forum..."),
                                  if(isDataGetted)
                                    Text("${title}",style:const TextStyle(fontSize: 12,color: Colors.black45),)
                                ],
                              ),
                              trailing:const Icon(Icons.arrow_forward_ios_rounded),
                            )
                        ),
                      ),
                      Container(
                        margin:const EdgeInsets.all(15),
                        padding:const EdgeInsets.only(left: 10, right: 10),
                        color: Colors.white,
                        child: TextField(
                          controller: _titleControllar,
                          decoration: const InputDecoration(
                              hintText: "Title...", border: InputBorder.none),
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        padding:const EdgeInsets.all(15),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        color: Colors.white,
                        child: TextField(
                          controller: _messageControllar,
                          decoration: const InputDecoration(
                              hintText: "Message", border: InputBorder.none),
                          keyboardType: TextInputType.multiline,
                          minLines: 10,
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ):
            Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black12,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You must log-in to perform this action.",style: TextStyle(fontSize: 16,color: Colors.black),),
                        SizedBox(height: 5,),
                        ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/login");}, child: Text("Log in",style: TextStyle(color: Colors.white),)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void postThread(String title,String message)async {
    var response=await ApiClient(Dio(BaseOptions(contentType: "application/json")))
        .postThread(MyDataClass.api_key, "625",node_id,title,message);
if(response["success"]==true){
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Done'),));
  setState((){
    _titleControllar.text="";
    _messageControllar.text="";
    isDataGetted=false;
    title="";
    node_id=0;
  });
}else{
  Navigator.pop(context);
}


  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 7),child:const Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
