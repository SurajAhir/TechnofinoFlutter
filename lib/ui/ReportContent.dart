import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:technofino/provider/MyProvider.dart';

class ReportContent extends StatefulWidget {
  const ReportContent({Key? key}) : super(key: key);

  @override
  State<ReportContent> createState() => _ReportContentState();
}

class _ReportContentState extends State<ReportContent> {
  var _messageControllar=TextEditingController();
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
                elevation: 5,
                child: Container(
                  height: 55,
                  padding: EdgeInsets.only(left: 6,right: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "report_content".tr,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: (){
                          if(_messageControllar.text.isNotEmpty){

                          }
                        },
                        child: Text(
                          "report".tr,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              provider.isNetworkAvailable()?Expanded(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  padding:const EdgeInsets.all(15),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Theme.of(context).bottomAppBarColor,
                  child: TextField(
                    controller: _messageControllar,
                    style: TextStyle(color: Theme.of(context).accentColor),
                    decoration:  InputDecoration(
                        hintText: "message".tr, border: InputBorder.none,
                    hintStyle: TextStyle(color: Theme.of(context).accentColor)),
                    keyboardType: TextInputType.multiline,
                    minLines: 10,
                    maxLines: null,
                  ),
                )
              )
                  :Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/alert_icon.png",width: 60,height: 60,),
                    SizedBox(height: 5,),
                    Text("Oops!",style: TextStyle(fontSize: 24),),
                    Text("Something went wrong.",style: TextStyle(fontSize: 16),)
                  ],
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
