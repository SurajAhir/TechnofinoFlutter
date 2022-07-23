import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:technofino/data_classes/Nodes.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.appBarTitle}",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white24,iconTheme: IconThemeData(color: Colors.black),
          centerTitle: false,
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 8, top: 5),
                child: ListTile(
                  leading: Icon(Icons.messenger_outline),
                  title: InkWell(
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
                      child: Text(
                        widget.list1forChildSubNode![index].title.toString(),
                        style: const TextStyle(color: Colors.black),
                      )),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${widget.list1forChildSubNode![index].description.toString()}"),
                      Text(
                        "Discussions: ${widget.list1forChildSubNode![index].type_data.discussion_count.toString()} · "
                        "Messages: ${NumberFormat.compact().format(widget.list1forChildSubNode![index].type_data.message_count)}",
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              );
            },
            itemCount: widget.list1forChildSubNode!.length));
  }
}
