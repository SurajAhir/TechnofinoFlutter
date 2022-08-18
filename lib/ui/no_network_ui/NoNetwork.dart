
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class NoNetwork extends StatefulWidget {
  const NoNetwork({Key? key}) : super(key: key);

  @override
  State<NoNetwork> createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/alert_icon.png",width: 60,height: 60,),
            SizedBox(height: 5,),
            Text("oops".tr,style: TextStyle(fontSize: 24,color: Theme.of(context).accentColor),),
            Text("something_went_wrong".tr,style: TextStyle(fontSize: 16,color: Theme.of(context).accentColor),)
          ],
        ),),
    );
  }
}
