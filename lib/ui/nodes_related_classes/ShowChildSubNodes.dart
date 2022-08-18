import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../data_classes/forume_data/Nodes.dart';
import '../../provider/MyProvider.dart';
import 'ShowThreads.dart';

class ShowChildSubNodes extends StatefulWidget {
  String title;
  String appBarTitle;
  String description;
  List<Nodes>? list1forChildSubNode;

  ShowChildSubNodes(this.title, this.appBarTitle,
      this.description, this.list1forChildSubNode,
      {Key? key})
      : super(key: key);

  @override
  State<ShowChildSubNodes> createState() => _ShowChildSubNodesState();
}

class _ShowChildSubNodesState extends State<ShowChildSubNodes> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "${widget.appBarTitle}",
            style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
          ),
          backgroundColor:Theme.of(context).bottomAppBarColor,iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          centerTitle: false,
        ),
        body:ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          ShowThreads(
                              widget.title,
                              widget.list1forChildSubNode![index].title.toString(),
                              widget.list1forChildSubNode![index].description.toString(),
                              widget.list1forChildSubNode![index].node_id,
                              widget.list1forChildSubNode![index].type_data
                          )));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8, top: 5),
                  child: ListTile(
                    leading: Icon(Icons.messenger_outline),
                    title: Text(
                      widget.list1forChildSubNode![index].title.toString(),
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${widget.list1forChildSubNode![index].description.toString()}"),
                        Text(
                          "discussions".tr+": ${widget.list1forChildSubNode![index].type_data.discussion_count.toString()} · "
                              "messages".tr+": ${NumberFormat.compact().format(widget.list1forChildSubNode![index].type_data.message_count)}",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              );
            },
            itemCount: widget.list1forChildSubNode!.length)
    );
  }
}
