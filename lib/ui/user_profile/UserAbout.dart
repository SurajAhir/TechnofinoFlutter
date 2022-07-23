import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technofino/data_classes/UserData.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "${widget.user.username}",
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Joined",
                style: TextStyle(fontSize: 15, color: Colors.black)),
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
            title: Text("Messages",
                style: TextStyle(fontSize: 15, color: Colors.black)),
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
            title: Text("Reaction score",
                style: TextStyle(fontSize: 15, color: Colors.black)),
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
            title: Text("Trophy points",
                style: TextStyle(fontSize: 15, color: Colors.black)),
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
            title: Text("Location",
                style: TextStyle(fontSize: 15, color: Colors.black)),
            subtitle: Text("${widget.user.location}",
                style: TextStyle(
                  fontSize: 15,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text("Facebook",
                style: TextStyle(fontSize: 15, color: Colors.black)),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text("Twitter",
                style: TextStyle(fontSize: 15, color: Colors.black)),
          )
        ],
      ),
    );
  }
}
