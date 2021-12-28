import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/dashboard.dart';
import 'package:flutterapp/login.dart';
import 'package:flutterapp/posts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:full_screen_image/full_screen_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key,
  })
      : super(key: key);

  @override
  _HomePageHomePageState createState() => _HomePageHomePageState();

}
class tab1 {
  int albumid;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  tab1({this.albumid,
        this.id,
        this.title,
        this.url,
        this.thumbnailUrl,
        });

  tab1.fromJsonnew(Map<String, dynamic> json) {
    albumid = json["albumId"];
    id = json["id"];
    title = json["title"];
    url = json["url"];
    thumbnailUrl = json["thumbnailUrl"];
  }
}

class _HomePageHomePageState extends State<HomePage> with TickerProviderStateMixin{
  final Color _backgroundColor = Colors.grey[200]; //Color(0xFFf0f0f0);
  final TextEditingController emailidController = TextEditingController();
  final TextEditingController passwordNumController = TextEditingController();
  List<tab1> firstTab = List<tab1>();

  getphotos() async {
    return await http.get(
        Uri.encodeFull(
            'https://jsonplaceholder.typicode.com/photos'),
        ).then((http.Response response) {
      // setState(() {
      final int statusCode = response.statusCode;
      if (statusCode == 200) {
        var extractdata = jsonDecode(response.body);
        print("photos :$extractdata");

        List data = extractdata as List;
        if (data != null) {
          for (int i = 0; i < data.length; i++) {
            setState(() {
              firstTab.add(tab1.fromJsonnew(data[i]));
            });
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getphotos();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: _backgroundColor,
        appBar: appbar(),
        body:
        Container(
        child: Flex( direction: Axis.vertical,
            children: <Widget>[
          Row(
            children: [
              Container(
                color: Colors.orangeAccent,
                width: (MediaQuery.of(context).size.width / 2),
                padding: const EdgeInsets.all(9.0),
                child: Center(
                  child: Text(
                    'Photos',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Posts(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.grey[300],
                  width: (MediaQuery.of(context).size.width / 2),
                  padding: const EdgeInsets.all(9.0),
                  child: Center(
                    child: Text(
                      'Posts',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
         Container(child: Expanded(
//              child:Column(children: [
                child:ListView.builder(
                    itemCount:firstTab.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          child: Container(
                              child: Card(
                                  elevation: 10.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
                                      child: Column(children: <Widget>[
                                        Row(children: [Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                              width : MediaQuery.of(context).size.width*0.15,
                                              margin: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  color: Colors.grey[200]),
                                              height: MediaQuery.of(context).size.height*0.08,//50,
//                                              width: 50,
                                           child: FullScreenWidget(
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(16),
                                              child:Image.network(firstTab[index].url,fit: BoxFit.cover,)
                                              )),
                                          ),
                                        ),
                                        Container(width : MediaQuery.of(context).size.width*0.60,
                                        child:
                                      Text(
                                          "${firstTab[index].id.toString()} ${firstTab[index].title}",//overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14.0, ),
                                        ),),

                                        ],)
                                      ])
                                  ))
                          ));
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
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () => {Get.to(() =>Dashboard())},
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
    Color appBarIconsColor = Colors.white;
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
}