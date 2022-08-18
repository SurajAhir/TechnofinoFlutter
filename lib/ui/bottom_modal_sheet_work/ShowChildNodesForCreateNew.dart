import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technofino/provider/MyProvider.dart';
import '../../data_classes/forume_data/Nodes.dart';
import 'ShowChildSubNodesForCreateNew.dart';

class ShowChildNodesForCreateNew extends StatefulWidget {
  BuildContext context;
  List<Nodes> obj;
  String title;
  LinkedHashMap<int, List<Nodes>> list1forChildSubNode;

  ShowChildNodesForCreateNew(
      this.context, this.obj, this.title, this.list1forChildSubNode,
      {Key? key})
      : super(key: key);

  @override
  State<ShowChildNodesForCreateNew> createState() =>
      _ShowChildNodesForCreateNewState();
}

class _ShowChildNodesForCreateNewState
    extends State<ShowChildNodesForCreateNew> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color:Theme.of(context).bottomAppBarColor),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new)),
                Expanded(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                  child: Text("Post thread in forum..."),
                ))
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    var totalThread = 0;
                    var totalMessage = 0;
                    var description = "";
                    var isFoundAnotherNode = false;
                    if (widget
                            .list1forChildSubNode[widget.obj[index].node_id] !=
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
                        if (widget
                            .list1forChildSubNode[
                        widget.obj[index].node_id]?[0]
                            .parent_node_id !=
                            null &&
                            widget
                                .list1forChildSubNode[
                            widget.obj[index].node_id]?[0]
                                .parent_node_id ==
                                widget.obj[index].node_id) {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                              ),
                              context: context,
                              builder: (context) =>
                                  ShowChildSubNodesForCreateNew(
                                      context,
                                      widget.title,
                                      widget.obj[index].title.toString(),
                                      widget.obj[index].description
                                          .toString(),
                                      widget.list1forChildSubNode[
                                      widget.obj[index].node_id])).then((value) => Navigator.pop(context,value));
                        } else {
                          Navigator.pop(context,[widget.obj[index].node_id,widget.obj[index].title]);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8, top: 5),
                        child: ListTile(
                          leading: Icon(Icons.messenger_outline),
                          title: Text(
                            widget.obj[index].title.toString(),
                            style:  TextStyle(color: Theme.of(context).accentColor),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isFoundAnotherNode == true
                                  ? Text("${description}")
                                  : Text(
                                      "${widget.obj[index].description.toString()}"),
                              isFoundAnotherNode == true
                                  ? Text(
                                      "discussions".tr+": ${totalThread} · "
                                      "messages".tr+": ${NumberFormat.compact().format(totalMessage)}",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  : Text(
                                "discussions".tr+": ${widget.obj[index].type_data.discussion_count.toString()} · "
                                    "messages".tr+": ${NumberFormat.compact().format(widget.obj[index].type_data.message_count)}",
                                      style: TextStyle(fontSize: 12),
                                    )
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.obj.length))
        ],
      ),
    );
  }
}
