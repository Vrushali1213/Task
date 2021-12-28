import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/dashboard.dart';
import 'package:flutterapp/homepage.dart';
import 'package:flutterapp/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Posts extends StatefulWidget {
  const Posts({Key key,
  })
      : super(key: key);

  @override
  _HomePagePostsState createState() => _HomePagePostsState();

}

class tab2 {
  int userId;
  int id;
  String title;
  String body;

  tab2({this.userId,
    this.id,
    this.title,
    this.body,
  });

  tab2.fromJsonnew(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
    body = json["body"];
  }
}
class _HomePagePostsState extends State<Posts> {
  final Color _backgroundColor = Colors.grey[200]; //Color(0xFFf0f0f0);
  List<tab2> secondTab = List<tab2>();

  getPosts() async {
    return await http.get(
      Uri.encodeFull(
          'https://jsonplaceholder.typicode.com/posts'),
    ).then((http.Response response) {
      // setState(() {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        var extractdata = jsonDecode(response.body);
        print("posts :$extractdata");

        List data = extractdata as List;
        if (data != null) {
          for (int i = 0; i < data.length; i++) {
            setState(() {
              secondTab.add(tab2.fromJsonnew(data[i]));
            });
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getPosts();
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
        body: Container(
            child: Flex(direction: Axis.vertical, children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                 child: Container(
                    color: Colors.grey[300],
                    width: (MediaQuery.of(context).size.width / 2),
                    padding: const EdgeInsets.all(9.0),
                    child: Center(
                      child: Text(
                        'Photos',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),),

                     Container(
                      color: Colors.orangeAccent,
                      width: (MediaQuery.of(context).size.width / 2),
                      padding: const EdgeInsets.all(9.0),
                      child: Center(
                        child: Text(
                          'Posts',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                ],
              ),
              SizedBox(height: 5),
              Container(child: Expanded(
//              child:Column(children: [
                  child:ListView.builder(
                      itemCount:secondTab.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap:() {
                            onTapped(index);
                          },
                            child: Container(
                                child:Padding(
                                padding: const EdgeInsets.all(10.0),
                               child: Card(
                                    elevation: 10.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                                        child:
                                        Column(children: <Widget>[
                                          Row(children: [
                                            Text(
                                              "${secondTab[index].id.toString()}",
                                              style: TextStyle(
                                                fontSize: 14.0,fontWeight: FontWeight.bold ),
                                            ),
                                            SizedBox(width: 10,),
                                            Container(width : MediaQuery.of(context).size.width*0.80,
                                              child:
                                              Text(
                                                "${secondTab[index].title}",//overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.0, ),

                                              ),),]),
                                    SizedBox(height: 10,),
                                    Align(alignment: Alignment.centerLeft,child:
                                    Text(
                                        "Description",
                                        style: TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.bold),),),
                                    Row(children: [
                                            Container(width : MediaQuery.of(context).size.width*0.80,
                                              child:
                                              Text(
                                                " ${secondTab[index].body}",//overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 14.0, ),
                                              ),),
                                          ],)
                                        ])
                                    ))
                                ) ));
                      })
//              ],)
              ),)

            ])
        ),

        drawer:Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Side menu',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Welcome'),
//            onTap: () => {},
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text('eve.holt@reqres.in'),
                onTap: () => {Get.to(() =>Dashboard())},
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () => {Navigator.of(context).pop()
                },
              ),

              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                onTap: () => {logoutUser(),},
              ),
            ],
          ),
        )
    );
  }

  Widget appbar() {
    Color appBarIconsColor = Colors.white; //Color(0xFF212121);
    return PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.08,),
//     child:
//     Padding(
//       padding: const EdgeInsets.all(10),
        child:AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.deepOrangeAccent,
          elevation: 0,
          title: Container(
            width: double.infinity,
//        alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text('Homepage',
//            textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 0.5,
                    color: appBarIconsColor,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),)
    );
  }

  void logoutUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs?.clear();
    Get.to(() => LoginPage());
  }

  onTapped(int position) {

    var a = secondTab[position].title;
    print("Name:" + a);
    var b = secondTab[position].body;

    Widget okButton = FlatButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    var alertDialog = Theme(
        data: Theme.of(context)
            .copyWith(dialogBackgroundColor: Colors.orangeAccent),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Details!",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          contentPadding: EdgeInsets.all(30.0),
          content:
          Text(
            'Title:$a, \n\nDescription:\n $b \n',
            maxLines: 100,
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          actions: [
            okButton,
          ],
        ));
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });

  }
}