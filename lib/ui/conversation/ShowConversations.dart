import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:technofino/ui/conversation/ReplyConversation.dart';
import 'package:technofino/ui/user_profile/UserProfile.dart';

import '../../data_classes/conversation_response/Conversations.dart';
import '../../data_classes/pagination/Pagination.dart';
import '../../main_data_class/MyDataClass.dart';
import '../../provider/MyProvider.dart';
import '../../services/ApiClient.dart';

class ShowConversations extends StatefulWidget {
  const ShowConversations({Key? key}) : super(key: key);

  @override
  State<ShowConversations> createState() => _ShowConversationsState();
}

class _ShowConversationsState extends State<ShowConversations> {
  final _scrollControllar = ScrollController();
  List<Conversations> list = [];
  var isLoadingThreads = false;
  var isFirstLoadingConversations = true;
  int page = 1;
  Pagination? pagination;
var isDataAvailbale=false;
  @override
  initState() {
    super.initState();
    getData(page);
    _scrollControllar.addListener(() {
      if (_scrollControllar.offset ==
          _scrollControllar.position.maxScrollExtent) {
        if (page != pagination!.last_page) {
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingConversations(true);
          page++;
          debugPrint(
              "position ${pagination!.last_page} and ${pagination!.current_page} and ${page}");
          getData(page);
        } else {
          debugPrint(
              "position ${pagination!.total} and ${pagination!.current_page}");
          var provider = Provider.of<MyProvider>(context, listen: false);
          provider.setisLoadingConversations(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Material(
              elevation: 15,
              child: Container(
                height: 45,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Conversations",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18)),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.black,
                            size: 24,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/icons/edit_post.png",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 6,)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 1,),
            isFirstLoadingConversations==false?Expanded(
              child: Scaffold(body: Padding(
                padding: EdgeInsets.all(6),
                child: ListView.builder(
                  controller: _scrollControllar,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                      list[index].Starter!.avatar_urls.o.toString().isNotEmpty
                          ? InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfile(list[index].Starter!)));
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              list[index].Starter!.avatar_urls.o),
                        ),
                      )
                          : InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfile(list[index].Starter!)));
                        },
                        child: CircleAvatar(
                          child: Text("${list[index].Starter!.username.substring(0, 1)}"),
                        ),
                      ),
                      title: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReplyConversation(list[index])));
                          },
                          child: Text("${list[index].title}")),
                      trailing:
                      Text("${readTimestamp(list[index].start_date.toInt())}"),
                    );
                  },
                  itemCount: list.length,
                ),
              ),),
            ):isDataAvailbale==false?const Center(child: CircularProgressIndicator()):const Center(child: Text("No Conversations found!"),),
            if(Provider.of<MyProvider>(context).isLoadingConversations)
              const CircularProgressIndicator.adaptive()
          ],
        ),
      ),
    );
  }
  String readTimestamp(int lastActivityData) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(lastActivityData * 1000);
    String time = "";
    if (now.year == date.year) {
      if (date.month == now.month) {
        if (date.day == now.day) {
          if (date.hour == now.hour) {
            if (now.minute - date.minute < 2) {
              time = "a moment ago";
            } else {
              time = "${now.minute - date.minute} minutes ago";
            }
          } else if (date.hour < now.hour) {
            var timeInMinuts = (now.hour - date.hour) * 60 + now.minute;
            if (timeInMinuts - date.minute < 60) {
              time = "${(timeInMinuts - date.minute).abs()} minutes ago";
            } else {
              time = "${now.hour - date.hour} hour ago";
            }
          }
        } else {
          if (now.day - date.day < 2) {
            time = "${now.day - date.day} day ago";
          } else {
            time = "${now.day - date.day} days ago";
          }
        }
      } else {
        if (now.month - date.month < 2) {
          time = "${now.month - date.month} month ago";
        } else {
          time = "${now.month - date.month} months ago";
        }
      }
    } else {
      if ((now.year - 100) - (date.year - 100) < 2) {
        time = "${(now.year - 100) - (date.year - 100)} year ago";
      } else {
        time = "${(now.year - 100) - (date.year - 100)} years ago";
      }
    }
    return time;
  }

  void getData(int page) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    var conversationResponse =
        await ApiClient(Dio(BaseOptions(contentType: "application/json")))
            .getConversations(
                MyDataClass.api_key, "625", page, "desc", "last_post_date");
    pagination = conversationResponse.pagination;
    list.addAll(conversationResponse.conversations);
    if(list.isEmpty){
      isDataAvailbale=true;
    }
    debugPrint(list.toString());
    provider.setisLoadingConversations(false);
    setState(() {
      isFirstLoadingConversations = false;
    });
  }

}
