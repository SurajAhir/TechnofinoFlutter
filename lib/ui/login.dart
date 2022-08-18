import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/main_data_class/MyDataClass.dart';
import 'package:technofino/ui/MyWebView.dart';
import 'package:twitter_login/twitter_login.dart';
import '../data_classes/login_response/UserData.dart';
import '../provider/MyProvider.dart';
import '../services/ApiClient.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _email_controller = TextEditingController();
  final _userPasswordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          "log_in".tr,
          style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MyProvider>(
        builder: (BuildContext context, myProvider, Widget? child) {
          return Container(
            color: Colors.black12,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(8),
                    child: Image.asset('assets/images/technofino.png'),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _email_controller,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email_required'.tr;
                            }
                            return null;
                          },
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          decoration: InputDecoration(
                            // hintText: "Username or Email",
                            labelText: "username_or_email".tr,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            prefixIcon: Icon(
                              CupertinoIcons.person,
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            fillColor: Theme.of(context).bottomAppBarColor,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).bottomAppBarColor),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).bottomAppBarColor),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                debugPrint("this is email");
                                setState(() {
                                  _email_controller.text = "";
                                });
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _userPasswordController,
                          obscureText: !_passwordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password_required'.tr;
                            }
                            return null;
                          },
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          decoration: InputDecoration(
                            // hintText: "Password",
                            labelText: "password".tr,
                            labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            fillColor: Theme.of(context).bottomAppBarColor,
                            prefixIcon: Icon(
                              CupertinoIcons.lock,
                              color: Colors.lightBlueAccent,
                            ),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).bottomAppBarColor),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).bottomAppBarColor),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            height: 45,
                            child: Directionality(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  myProvider.setLoading(true);
                                  doLogin(_email_controller.text.toString(),
                                      _userPasswordController.text.toString());
                                },
                                icon: myProvider.isLoading == true
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : Icon(Icons.login),
                                label: Text(
                                  "log_in".tr,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              textDirection: TextDirection.rtl,
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              googleSignIn(context);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).bottomAppBarColor)),
                            icon: Image.asset(
                              "assets/icons/google.png",
                              width: 24,
                              height: 24,
                            ),
                            label: Text(
                              "sign_in_with_google".tr,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              twitterSignIn();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).bottomAppBarColor)),
                            icon: Image.asset(
                              "assets/icons/twitter.png",
                              width: 24,
                              height: 24,
                            ),
                            label: Text(
                              "sign_in_with_twitter".tr,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWebView(
                                        "https://www.technofino.in/community/register/")));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            alignment: Alignment.center,
                            child: Text(
                              "register_new_account".tr,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> doLogin(String email, String password) async {
    var provider = Provider.of<MyProvider>(context, listen: false);
    try {
      final client =
          ApiClient(Dio(BaseOptions(contentType: "application/json")));
      var data = await client.login(MyDataClass.api_key, email, password);
      if (data != null) {
        MyDataClass.loginResponse = data.user as UserData;
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        prefs.setString("email", email);
        MyDataClass.isUserLoggedIn = true;
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid Credentials!"),
          backgroundColor: Theme.of(context).bottomAppBarColor,
        ));
      }
      provider.setLoading(false);
    } on DioError catch (e) {
      provider.setLoading(false);
      print("code" + e.error);
      if (e.error.toString().contains("400")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid Credentials!"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error occurred!"),
        ));
      }
    }
  }

  void googleSignIn(BuildContext context) async {
    print("googleLogin method Called");
    final _googleSignIn = GoogleSignIn();
    var result = await _googleSignIn.signIn();
    showLoaderDialog(context);
    if (result != null) {
      var email = result.email;
      var response =
          await ApiClient(Dio(BaseOptions(contentType: "application/json")))
              .findUserEmail(MyDataClass.api_key, 1, email);
      if (response != null) {
        var user = response["user"] as UserData;
        if (user != null) {
          MyDataClass.loginResponse = user;
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("email", email);
          MyDataClass.isUserLoggedIn = true;
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, "/home");
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Your're not registered! Please register to continue..."),
          ));
        }
      }
      print("Result $result");
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error occurred!"),
      ));
    }
  }

  void twitterSignIn() async {
    final twitterLogin = TwitterLogin(
        apiKey: "trrkdp3dAidWbkMc3orLErzRd",
        apiSecretKey: "R97Rxq1hfeKu3FowwzJ5Mv3PR5MzdJcg3R0RnS89ikV58064DB",
        redirectURI: "technofino://twitterlogin");
    final authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        debugPrint(authResult.user!.name.toString());
        debugPrint(authResult.user!.id.toString());
        var response = await http.post(
            Uri.parse("https://technofino.in/androidapi/api.php"),
            body: {"provider_id": authResult.user?.id.toString()});
        var map = jsonDecode(response.body) as Map;
        debugPrint(map.toString());
        if (map["status"] == 0) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "You haven't linked your email account to the Twitter. Kindly link your account and then try again later!"),
          ));
        } else if (map["status"] == 1) {
          var email = map["email"];
          if (email != null) {
            showLoaderDialog(context);
            var response =
            await ApiClient(Dio(BaseOptions(contentType: "application/json")))
                .findUserEmail(MyDataClass.api_key, 1, email);
            if (response != null) {
              var user = response["user"] as UserData;
              if (user != null) {
                MyDataClass.loginResponse = user;
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", true);
                prefs.setString("email", email);
                MyDataClass.isUserLoggedIn = true;
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, "/home");
              } else {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                  Text("Your're not registered! Please register to continue..."),
                ));
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                  "You haven't linked your email account to the Twitter. Kindly link your account and then try again later!"),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "You haven't linked your email account to the Twitter. Kindly link your account and then try again later!"),
          ));
        }
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        break;
      case TwitterLoginStatus.error:
        // error
        break;
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text("loading".tr + "...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false, //this is default method which flutter provides
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
