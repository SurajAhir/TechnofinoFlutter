import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../provider/MyProvider.dart';
class ChangeAppThem extends StatefulWidget {
  const ChangeAppThem({Key? key}) : super(key: key);

  @override
  State<ChangeAppThem> createState() => _ChangeAppThemState();
}

class _ChangeAppThemState extends State<ChangeAppThem> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<MyProvider>(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            "dark_mode".tr,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).accentColor),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).bottomAppBarColor,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            backgroundColor: Colors.black12,
            body: Container(
              height: 250,
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Theme.of(context).bottomAppBarColor
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        themeChange.darkTheme = true;
                      },
                      child: ListTile(
                        leading:themeChange.darkTheme==true?Icon(Icons.check):SizedBox(),
                        title: Text("On"),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        themeChange.darkTheme = false;
                      },
                      child: ListTile(
                        leading: themeChange.darkTheme==false?Icon(Icons.check):SizedBox(),
                        title: Text("Off"),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async{
                    //
                    //   },
                    //   child: ListTile(
                    //     leading: Provider.of<MyProvider>(context).language=="Vietnamese"?Icon(Icons.check):SizedBox(),
                    //     title: Text("System"),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

}
