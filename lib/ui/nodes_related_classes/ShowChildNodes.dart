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
                    leading: widget.obj[index].title.toString().contains("Announcements")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/announcement.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("General Discussion")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/general.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Finance World News")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/finance_world_news.jpg",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Twitter Spaces")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/twitter_space.png",
                      height: 28,
                      width: 28,
                    ):
                    widget.obj[index].title.toString().contains("Just For Fun")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/just_for_fun.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Review & Experience")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/review_and_experience.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Mod Only Forum")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/mod_only_forum.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.obj[index].title.toString().contains("Informational Threads")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/informational_thread.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.obj[index].title.toString().contains("Credit Card Reviews On")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/credit_card_review_on_technoFino.png",
                      height: 32,
                      width: 32,
                    ):
                    widget.obj[index].title.toString().contains("Credit Cards")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/credit_cards.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Bank Account")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/bank_account.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Debit Card")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/debit_card.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Credit Score")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/credit_score.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("BNPL Cards")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/bnpl_cards.png",
                      height: 32,
                      width: 32,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Prepaid Card/")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/prepaid_card_wallet_card.png",
                      height: 28,
                      width: 28,
                    ):
                    widget.obj[index].title.toString().contains("Banking Complaint")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/banking_complaint.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("UPI")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/upi.png",
                      height: 28,
                      width: 28,
                    ):
                    widget.obj[index].title.toString().contains("Loan")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/loan.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Agent Section")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/agent_section.png",
                      height: 28,
                      width: 28,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("How To Maximise Card")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/how_to_maximize_card_reward.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.obj[index].title.toString().contains("Credit Card Offers")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/credit_card_offer.png",
                      height: 30,
                      width: 30,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("App Offers /")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/app_offer.jpg",
                      height: 34,
                      width: 34,
                    ):
                    widget.obj[index].title.toString().contains("Other Offers")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/other_offer.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Donate Your Voucher/")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/donate_your_voucher.jpg",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Flight & Hotel Booking")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/flight_and_hotel_booking_offer.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Investment")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/investment.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Insurance")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/insurance.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Tax")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/tax.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Airmiles & Credit Card")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/airmiles_and_credit_card.jpg",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Hotel Loyalty Program")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/hotel_loyalty_program_and_credit_card.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Lounge/Hotel Reviews")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/lounge_and_hotel_review.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Travel Hacks")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/travel_hacks.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.obj[index].title.toString().contains("Personal Travel Experience")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/personal_travel_experience.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("Foreign Credit Card")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/foreign_credit_cards.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("VIP Credit Card Lounge")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/vip_credit_card_lounge.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.obj[index].title.toString().contains("VIP General Lounge")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/vip_general_lounge.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.obj[index].title.toString().contains("Invite Only")
                        ? Image.asset(
                      "assets/icons/technofino_nodes_icons/invite.png",
                      height: 34,
                      width: 34,
                    ):
                    Icon(Icons.messenger_outline),
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
