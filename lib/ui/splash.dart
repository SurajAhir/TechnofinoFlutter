import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:technofino/ui/HomePage.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomePage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff7BD3D3D3),
        body: Container(
      color: Color(0xff7BD3D3D3),
      child: Center(
        child:   Text("TechnoFino",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28
              ),
              decoration: TextDecoration.none,)
        ),
      )



      // Column(
      //   children: [
      //     Container(
      //       margin: EdgeInsets.all(20),
      //       child: Image.asset("assets/images/technofino.png"),
      //     ),
      //     Text("TechnoFino Community",
      //         style: GoogleFonts.anton(
      //             textStyle: TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold,
      //             ),
      //             decoration: TextDecoration.none,),textScaleFactor: 0.7
      //     ),
      //     SizedBox(height: 20,),
      //     Text("#1 Banking & Credit Card ",
      //         style: GoogleFonts.titanOne(
      //           textStyle: TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold,
      //             fontSize: 38
      //           ),
      //           decoration: TextDecoration.none,
      //         ),textScaleFactor: 0.7
      //     ),
      //     Container(
      //       width: MediaQuery.of(context).size.width,
      //       alignment: Alignment.center,
      //       child:    Text("Cumminity",
      //           style: GoogleFonts.titanOne(
      //             textStyle: TextStyle(
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.bold
      //             ),
      //             decoration: TextDecoration.none,
      //           ),textScaleFactor: 0.7
      //       ),
      //     )
      //   ],
      // ),
    ));
  }
}
