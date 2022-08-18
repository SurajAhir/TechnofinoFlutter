import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:technofino/provider/MyProvider.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({Key? key}) : super(key: key);

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  var _usernameControllar = TextEditingController();
  var _reasonControllar = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        iconTheme: IconThemeData(color:Theme.of(context).accentColor),
        title: Text(
          "change_username".tr,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
        ),
      ),
      body:Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(10),
        child: Expanded(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                color: Theme.of(context).bottomAppBarColor,
                child: TextField(
                  controller: _usernameControllar,style: TextStyle(fontSize: 14,color: Theme.of(context).accentColor),
                  decoration:  InputDecoration(
                      hintText: "username".tr, border: InputBorder.none,
                  hintStyle: TextStyle(color: Theme.of(context).accentColor)),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                ),
              ),
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.only(left: 5,right: 5),
                color:Theme.of(context).bottomAppBarColor,
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: _reasonControllar,
                  decoration:  InputDecoration(
                      hintText: "change_reason".tr, border: InputBorder.none,
                  hintStyle: TextStyle(color: Theme.of(context).accentColor)),style: TextStyle(fontSize: 14,color: Theme.of(context).accentColor),
                  keyboardType: TextInputType.multiline,
                  minLines: 2,
                  maxLines: null,
                ),
              ),
              SizedBox(height: 6,),
              Text("please_explain_the_reason_for_this_username_change".tr,style: TextStyle(fontSize: 13),),
              SizedBox(
                height: 8,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  height: 45,
                  child: Directionality(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                      },
                      icon: isLoading == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Icon(Icons.save_outlined),
                      label: Text(
                        "save".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    textDirection: TextDirection.rtl,
                  )),
            ],
          ),
        ),
      )
    );
  }
}
