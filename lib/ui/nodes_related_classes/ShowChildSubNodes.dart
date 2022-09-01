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
                    leading: widget.list1forChildSubNode![index].title.toString().contains("Super Premium Credit Cards")?Image.asset(
                      "assets/icons/technofino_nodes_icons/super_premium_credit_card.jpg",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("Credit Card Comparison")?Image.asset(
                      "assets/icons/technofino_nodes_icons/credit_card_comparison.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("Credit Card - General")?Image.asset(
                      "assets/icons/technofino_nodes_icons/credit_card_general.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("HDFC Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/hdfc_bank_credit_card.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("American Express")?Image.asset(
                      "assets/icons/technofino_nodes_icons/american_express.jpg",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("Axis Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/axis_bank_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("ICICI Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/icici_bank_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("SBI Cards")?Image.asset(
                      "assets/icons/technofino_nodes_icons/sbi_card.jpg",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("BOB Cards")?Image.asset(
                      "assets/icons/technofino_nodes_icons/bob_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("IDFC FIRST Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/idfc_first_bank_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("FinTech Credit Cards")?Image.asset(
                      "assets/icons/technofino_nodes_icons/fintech_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("Citi Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/citi_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("HSBC Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/hsbc_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("IndusInd Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/indusind_bank_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("RBL Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/rbl_bank_credit_card.jpg",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("Standard Chartered Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/standard_chartered_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("AU Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/au_bank_credit_card.png",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("Yes Bank Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/yes_bank_credit_card.jpg",
                      height: 34,
                      width: 34,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("Kotak Credit Card")?Image.asset(
                      "assets/icons/technofino_nodes_icons/kotak_bank_credit_card.png",
                      height: 38,
                      width: 38,
                    ):
                    widget.list1forChildSubNode![index].title.toString().contains("PSU Bank Credit Cards")?Image.asset(
                      "assets/icons/technofino_nodes_icons/psu_bank_credit_card.png",
                      height: 34,
                      width: 34,
                      color: Theme.of(context).accentColor,
                    ):Icon(Icons.messenger_outline),
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
