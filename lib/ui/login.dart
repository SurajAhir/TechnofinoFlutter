import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technofino/data_classes/LoginResponse.dart';
import 'package:technofino/data_classes/UserData.dart';
import 'package:technofino/main_data_class/MyDataClass.dart';
import 'package:technofino/shared_preferences/Shared_Preferences.dart';

import '../provider/MyProvider.dart';
import '../services/ApiClient.dart';

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
      appBar: AppBar(
        title: const Text(
          "Log in",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body:  Consumer<MyProvider>(
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
                              return 'Email required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // hintText: "Username or Email",
                            labelText: "Username or Email",
                            prefixIcon: Icon(
                              CupertinoIcons.person,
                            ),
                            contentPadding: EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _email_controller.clear;
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
                              return 'Password required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            // hintText: "Password",
                            labelText: "Password",
                            contentPadding: EdgeInsets.only(left: 20),
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              CupertinoIcons.lock,
                              color: Colors.lightBlueAccent,
                            ),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme.of(context).primaryColorDark,
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
                                  doLogin(_email_controller.text.toString(),_userPasswordController.text.toString());
                                },
                                icon: myProvider.isLoading==true?Center(child: CircularProgressIndicator(color: Colors.white,),):Icon(Icons.login),
                                label: Text(
                                  "Log in",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              textDirection: TextDirection.rtl,
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                            icon: Image.asset(
                              "assets/icons/google.png",
                              width: 24,
                              height: 24,
                            ),
                            label: Text("Sign in with Google",style: TextStyle(color: Colors.black),),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.center,
                          child: Text(
                            "Register new account",
                            style: TextStyle(color: Colors.black, fontSize: 15),
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

  Future<void> doLogin(String email, String password) async{
var provider=Provider.of<MyProvider>(context,listen: false);
try {
  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  var data = await client.login(MyDataClass.api_key, email, password);
  if(data!=null){
    MyDataClass.loginResponse=data.user as UserData;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn",true);
    prefs.setString("email", email);
    MyDataClass.isUserLoggedIn=true;
    Navigator.pushReplacementNamed(context, "/home");
  }
  provider.setLoading(false);
} on DioError catch (e) {
  provider.setLoading(false);
  print(e.error);
}
  }


}
