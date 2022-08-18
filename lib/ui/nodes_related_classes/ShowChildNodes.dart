import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import "package:intl/intl.dart";
import 'package:provider/provider.dart';
import 'package:technofino/ui/nodes_related_classes/ShowChildSubNodes.dart';
import 'package:technofino/ui/nodes_related_classes/ShowThreads.dart';

import '../../data_classes/forume_data/Nodes.dart';
import '../../provider/MyProvider.dart';
class ShowChildNodes extends StatefulWidget {
  List<Nodes> obj;
  String title;
  LinkedHashMap<int, List<Nodes>> list1forChildSubNode;

  ShowChildNodes(List<Nodes> this.obj, String this.title,
      LinkedHashMap<int, List<Nodes>> this.list1forChildSubNode,
      {Key? key})
      : super(key: key);

  @override
  State<ShowChildNodes> createState() => _ShowChildNodesState();
}

class _ShowChildNodesState extends State<ShowChildNodes> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "${widget.title}",
            style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Theme.of(context).bottomAppBarColor,iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          centerTitle: false,
        ),
        body:ListView.builder(
            itemBuilder: (context, index) {
              var totalThread = 0;
              var totalMessage = 0;
              var description = "";
              var isFoundAnotherNode = false;
              if (widget.list1forChildSubNode[widget.obj[index].node_id] !=
                  null) {
                isFoundAnotherNode = true;
                var arrayList =
                widget.list1forChildSubNode[widget.obj[index].node_id]
                as List<Nodes>;
                if (arrayList != null) {
                  arrayList.forEach((element) {
                    totalThread += element.type_data.discussion_count;
                    totalMessage += element.type_data.message_count;
                  });
                  description = arrayList[index].description.toString();
                }
              }
              return InkWell(
                onTap: () {
                  if (widget.list1forChildSubNode[widget.obj[index]
                      .node_id]?[0].parent_node_id != null &&
                      widget.list1forChildSubNode[widget.obj[index]
                          .node_id]?[0].parent_node_id ==
                          widget.obj[index].node_id
                  ) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ShowChildSubNodes(
                                widget.title,
                                widget.obj[index].title.toString(),
                                widget.obj[index].description.toString(),
                                widget.list1forChildSubNode[widget.obj[index].node_id]
                            )));
                  } else {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ShowThreads(
                                widget.title,
                                widget.obj[index].title.toString(),
                                widget.obj[index].description.toString(),
                                widget.obj[index].node_id,
                                widget.obj[index].type_data
                            )));
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8, top: 5),
                  child: ListTile(
                    leading: Icon(Icons.messenger_outline),
                    title: Text(
                      widget.obj[index].title.toString(),
                      style:TextStyle(color: Theme.of(context).accentColor),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isFoundAnotherNode == true
                            ? Text("${description}")
                            : Text("${widget.obj[index].description.toString()}"),
                        isFoundAnotherNode == true
                            ? Text(
                          "discussions".tr+": ${totalThread} · "
                              "messages".tr+": ${NumberFormat.compact().format(
                              totalMessage)}",
                          style: TextStyle(fontSize: 12),
                        )
                            : Text(
                          "discussions".tr+": ${widget.obj[index].type_data
                              .discussion_count.toString()} · "
                              "messages".tr+": ${NumberFormat.compact().format(
                              widget.obj[index].type_data.message_count)}",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              );
            },
            itemCount: widget.obj.length)
    );
  }
}
