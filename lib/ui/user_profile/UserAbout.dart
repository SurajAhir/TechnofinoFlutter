import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';

import '../../data_classes/login_response/UserData.dart';

class UserAbout extends StatefulWidget {
  UserData user;

  UserAbout(this.user, {Key? key}) : super(key: key);

  @override
  State<UserAbout> createState() => _UserAboutState();
}

class _UserAboutState extends State<UserAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor:Theme.of(context).bottomAppBarColor,
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        title: Text(
          "${widget.user.username}",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("joined".tr,
                  style: TextStyle(fontSize: 15, color: Theme.of(context).accentColor)),
              subtitle: Text(
                  "${DateFormat('MM/dd/yyyy').format(DateTime.fromMillisecondsSinceEpoch(((widget.user.register_date)! * 1000).toInt()))}",
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("messages".tr,
                  style: TextStyle(fontSize: 15, color: Theme.of(context).accentColor)),
              subtitle: Text(
                  "${NumberFormat.compact().format(widget.user.message_count)}",
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("reaction_score".tr,
                  style: TextStyle(fontSize: 15, color:Theme.of(context).accentColor)),
              subtitle: Text(
                  "${NumberFormat.compact().format(widget.user.reaction_score)}",
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("trophy_points".tr,
                  style: TextStyle(fontSize: 15, color: Theme.of(context).accentColor)),
              subtitle: Text(
                  "${NumberFormat.compact().format(widget.user.trophy_points)}",
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("location".tr,
                  style: TextStyle(fontSize: 15, color: Theme.of(context).accentColor)),
              subtitle: Text("${widget.user.location}",
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("facebook".tr,
                  style: TextStyle(fontSize: 15, color:Theme.of(context).accentColor)),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("twitter".tr,
                  style: TextStyle(fontSize: 15, color:Theme.of(context).accentColor)),
            )
          ],
        ),
      ),
    );
  }
}
