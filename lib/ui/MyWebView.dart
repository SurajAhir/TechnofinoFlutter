import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  String url;

  MyWebView(this.url, {Key? key}) : super(key: key);

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Container(
                height: 55,
                child: Card(
                  elevation: 2,
                  child: Row(children: [
                    SizedBox(width: 6,),
                    Icon(CupertinoIcons.lock,size: 24,color: Theme.of(context).accentColor,),
                    SizedBox(width: 3,),
                    Expanded(child: Text("${widget.url}...",style: TextStyle(fontSize:12,color: Theme.of(context).accentColor),maxLines: 1,)),
                    SizedBox(width: 2,),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          backgroundColor: Theme.of(context).bottomAppBarColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                            context: context,
                            builder: (context) => Container(
                              height: 50,padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(color:Theme.of(context).bottomAppBarColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10))),
                              child:InkWell(
                                  onTap: () async{
                                    if (await canLaunch(widget.url)) {
                                    await launch(widget.url);
                                    } else {
                                    throw 'Could not launch ${widget.url}';
                                    }
                                  },
                                  child: Text("Open in browser"))
                            )
                          //create a custom widget as you want
                        );
                      },
                      child: Image.asset("assets/icons/options.png",width: 24,height: 24,color: Theme.of(context).accentColor,),
                    ),
                    SizedBox(width: 3,),
                  ],),
                ),
              ),
              Expanded(
                child: WebView(
                  initialUrl: '${widget.url}',
                  zoomEnabled: true,
                  javascriptMode: JavascriptMode.unrestricted,
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.contains("mailto:")) {
                      launch(request.url);
                      return NavigationDecision.prevent;
                    } else {
                      return NavigationDecision.navigate;
                    }
                  },
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
