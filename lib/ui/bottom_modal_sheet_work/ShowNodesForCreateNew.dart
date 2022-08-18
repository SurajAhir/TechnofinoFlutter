import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import '../../data_classes/forume_data/NodeResponse.dart';
import '../../data_classes/forume_data/Nodes.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';
import 'ShowChildNodesForCreateNew.dart';

class ShowNodesForCreateNew extends StatefulWidget {
  BuildContext context;
  ShowNodesForCreateNew(this.context, {Key? key}) : super(key: key);

  @override
  State<ShowNodesForCreateNew> createState() => _ShowNodesForCreateNewState();
}

class _ShowNodesForCreateNewState extends State<ShowNodesForCreateNew> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Theme.of(context).bottomAppBarColor),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            child: Text("post_thread_in_forum".tr),
          ),
          Expanded(child: Container(
            child: FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    List<Nodes> list = [];
                    Map<String, List<int>> treeMap = {};
                    LinkedHashMap<int, List<Nodes>> list1ForChildNode =
                    LinkedHashMap();
                    LinkedHashMap<int, List<Nodes>> list1ForParentNode =
                    LinkedHashMap();
                    LinkedHashMap<int, List<Nodes>> list1ForChildSubNode =
                    LinkedHashMap();
                    List<Nodes> arrayListForChildNode;
                    List<Nodes> arrayListForParentNode;
                    List<Nodes> arrayListForChildSubNode;
                    var index = 0;
                    var indexForSubNode = 0;
                    final data = snapshot.data as NodeResponse;
                    list = data.nodes as List<Nodes>;
                    treeMap = data.tree_map as Map<String, List<int>>;
                    var mylist = treeMap["0"] as List<int>;
                    mylist.forEach((j) {
                      index = j;
                      arrayListForChildNode = [];
                      arrayListForParentNode = [];
                      arrayListForChildSubNode = [];
                      List<int> listForSubNodeId = [];
                      for (int i = 0; i < (list.length); i++) {
                        if (list[i].parent_node_id == j) {
                          arrayListForChildNode.add(list[i]);
                          listForSubNodeId.add(list[i].node_id);
                        }
                        if (list[i].node_id == j) {
                          arrayListForParentNode.add(list[i]);
                        }
                      }
                      listForSubNodeId.forEach((id) {
                        for (int i = 0; i < (list.length); i++) {
                          if (list[i].parent_node_id == id) {
                            arrayListForChildSubNode.add(list[i]);
                            indexForSubNode = id;
                          }
                        }
                        if (arrayListForChildSubNode.isNotEmpty) {
                          // list1ForChildSubNode.update(indexForSubNode, (value) => arrayListForChildSubNode);
                          list1ForChildSubNode.putIfAbsent(
                              indexForSubNode, () => arrayListForChildSubNode);
                        }
                      });

                      list1ForChildNode.putIfAbsent(
                          index, () => arrayListForChildNode);
                      list1ForParentNode.putIfAbsent(
                          index, () => arrayListForParentNode);
                    });

                    return ListView.builder(
                        itemBuilder: (context, index) {
                          List<Nodes> obj =
                          list1ForParentNode[mylist[index]] as List<Nodes>;
                          return InkWell(
                            onTap: () {
                              var childNodes =
                              list1ForChildNode[mylist[index]] as List<Nodes>;
                              debugPrint(childNodes.length.toString());
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                  ),
                                  context: context,
                                  builder: (context) => ShowChildNodesForCreateNew(
                                      context,
                                      childNodes,
                                      obj[0].title.toString(),
                                      list1ForChildSubNode)).then((value) => Navigator.pop(context,value));
                            },
                            child: ListTile(
                              leading: Icon(Icons.folder_outlined),
                              title: Text("${obj[0].title}"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          );
                        },
                        itemCount: mylist.length);
                  }
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },

              // Future that needs to be resolved
              // inorder to display something on the Canvas
              future: ApiClient(Dio(BaseOptions(contentType: "application/json")))
                  .getNodes(MyDataClass.api_key),
            ),
          ))
        ],
      ),
    );
  }
}
