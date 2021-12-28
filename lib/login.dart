import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/homepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key,
  })
      : super(key: key);

  @override
  _HomePageLoginPageState createState() => _HomePageLoginPageState();

}

class _HomePageLoginPageState extends State<LoginPage> {
  final Color _backgroundColor = Colors.grey[200]; //Color(0xFFf0f0f0);
  final TextEditingController emailidController = TextEditingController();
  final TextEditingController passwordNumController = TextEditingController();

  getlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await http.post(
        Uri.encodeFull(
            'https://reqres.in/api/login'),
        body: {
          "email":emailidController.text,
          "password":passwordNumController.text,
        },
        headers: {
          "Accept": "application/json",
        }).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        var extractdata = jsonDecode(response.body);
        print ("login data :$extractdata");
        prefs?.setBool("isLoggedIn", true);
        Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent[200],
            textColor: Colors.white,
            fontSize: 16.0
        );
        Get.to(() => HomePage());
      }else
        {
          Fluttertoast.showToast(
              msg: "InValid Details",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP_LEFT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.redAccent[200],
              textColor: Colors.white,
              fontSize: 16.0
          );
        }

    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _backgroundColor,
        appBar: appbar(),
        body:SingleChildScrollView(child:
        Column(children: [
          SizedBox(height:MediaQuery.of(context).size.height*0.20,),
          Padding(padding: const EdgeInsets.all(25),
            child:Container(
                height: MediaQuery.of(context).size.height*0.06,
                width:MediaQuery.of(context).size.width*0.85, //100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),),
                child:Row(children: [
                  SizedBox(width: 24,),
                  Container(
                    width:MediaQuery.of(context).size.width*0.70, //100.0,
                    child:
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Enter email id",
                          fillColor: Colors.white70),
                      controller:emailidController,
//                      keyboardType: TextInputType.number,
                    ),),
                ],)),),
//          SizedBox(height:MediaQuery.of(context).size.height*0.05,),
          Padding(padding: const EdgeInsets.all(25),
            child:Container(
                height: MediaQuery.of(context).size.height*0.06,
                width:MediaQuery.of(context).size.width*0.85, //100.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(24)),),
                child:Row(children: [
                  SizedBox(width: 24,),
                  Container(
                    width:MediaQuery.of(context).size.width*0.70, //100.0,
                    child:
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: "Enter password",
                          fillColor: Colors.white70),
                      obscureText: true,
                      controller:passwordNumController,
//                      keyboardType: TextInputType.number,
                    ),),
                ],)),),
          SizedBox(height:MediaQuery.of(context).size.height*0.02,),

          Container(
              height:MediaQuery.of(context).size.height*0.06,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(24)),
                border: Border.all(
                  width: 3,
                  color: Colors.pinkAccent,
                ),),
              width: MediaQuery.of(context).size.width*0.38,
              child: new GestureDetector(
                onTap: () {
                  getlogin();
                  //                              Get.to(() => Dashboard());
                },
                child:Center(
//                        :Padding(
//                      padding: const EdgeInsets.only(top: 0),
                  child:Text('Login',textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold)),
                ),)
          )
        ]))
    );
  }

  Widget appbar() {
    Color appBarIconsColor = Color(0xFF212121);
    return PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.08,),
//     child:
//     Padding(
//       padding: const EdgeInsets.all(10),
        child:AppBar(
            actions: <Widget>[

            ],
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Container(
              width: double.infinity,
//        alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('Login',
//            textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.5,
                      color: appBarIconsColor,
                      fontWeight: FontWeight.bold,
                    )),
              ),))
    );
  }
}
