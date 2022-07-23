import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data_classes/Nodes.dart';
import '../../services/ApiClient.dart';

class ShowChildSubNodesForCreateNew extends StatefulWidget {
  BuildContext context;
  String title;
  String appBarTitle;
  String description;
  List<Nodes>? list1forChildSubNode;

  ShowChildSubNodesForCreateNew(this.context,this.title, this.appBarTitle,
  this.description, this.list1forChildSubNode, {Key? key})
      : super(key: key);

  @override
  State<ShowChildSubNodesForCreateNew> createState() =>
      _ShowChildSubNodesForCreateNewState();
}

class _ShowChildSubNodesForCreateNewState
    extends State<ShowChildSubNodesForCreateNew> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Colors.white),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Row(
              children: [
                InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new)),
                Expanded(child:  Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  child: Text("Post thread in forum..."),
                ))
              ],
            ),
          ),
          Expanded(
              child:ListView.builder(
                  itemBuilder: (context1, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8, top: 5),
                      child: ListTile(
                        leading: Icon(Icons.messenger_outline),
                        title: InkWell(
                            onTap: () {
                              Navigator.pop(context,[widget.list1forChildSubNode![index].node_id,widget.list1forChildSubNode![index].title]);
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
                  itemCount: widget.list1forChildSubNode!.length))
        ],
      ),
    );
  }
}
