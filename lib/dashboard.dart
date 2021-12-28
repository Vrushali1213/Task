import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterapp/login.dart';
import 'package:flutterapp/posts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';
import 'package:full_screen_image/full_screen_image.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key,
  })
      : super(key: key);

  @override
  _HomePageDashboardState createState() => _HomePageDashboardState();

}

class _HomePageDashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final Color _backgroundColor = Colors.grey[200]; //Color(0xFFf0f0f0);

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
    return
      Scaffold(
//        backgroundColor: _backgroundColor,
        appBar: appbar(),
        body:
        Container(
         child:Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
           Padding(padding: EdgeInsets.only(top: 20,left: 25),
          child: Text("Featured Articles",style: TextStyle(
             fontSize: 20.0,fontWeight: FontWeight.bold ),)),

          Padding(padding: EdgeInsets.only(top: 20,left: 25),child:
           Container(
               decoration: BoxDecoration(
//             color: Colors.redAccent,
                 borderRadius: BorderRadius.all(Radius.circular(20)),),
               height:MediaQuery.of(context).size.height*0.35,
               child: ListView(
             scrollDirection: Axis.horizontal,
             children: [
               Stack(
                 children: [
           Container(
             width:MediaQuery.of(context).size.width*0.42,
             height:MediaQuery.of(context).size.height*0.35,
             child:ClipRRect(
               borderRadius: BorderRadius.circular(20), child:Image.asset("assets/yoga2.png",fit: BoxFit.fill,),
           )),
                   Positioned(
                     top: MediaQuery.of(context).size.height*0.23,
//                     left: 30,
                     height:MediaQuery.of(context).size.height*0.12,
                     width: MediaQuery.of(context).size.width*0.42,
                     child:
                     Container(
//                       width: 150,
//                       height: 150,
                       decoration: BoxDecoration(
             color: Colors.blueAccent,
                         borderRadius: BorderRadius.all(Radius.circular(20)),),
//                       color: Colors.blue,
                       child:
                       Padding(padding: EdgeInsets.fromLTRB(15,10,10,10),child:
                           Column(children: [
                       Text(
                         '5 minutes of daily yoga liftime of Strength',
                         style: TextStyle(
                             color: Colors.white,
                             fontSize: 14
                         ),),
                             SizedBox(height: 10,),
                             Row(children: [
                               SizedBox(width: MediaQuery.of(context).size.width*0.07,),
                               Text(
                                 'Read Now',
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 14
                                 ),),
                               SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                               CircleAvatar(
                                 radius: 16,backgroundColor: Colors.white,
//                backgroundImage: ExactAssetImage('assets/icon.png'),
//                                 backgroundImage:AssetImage("assets/Fav Star.png",)
                                 child:IconButton(
                  icon:Image.asset("assets/Fav Star.png",), //Icon(Icons.star_border),
                  color: Colors.grey,
                  iconSize: 35,
                  onPressed: () {},
                               ))
                             ],)

                           ],)
                       ),
                     ),

                   ),
                 ],
               ),
               SizedBox(width: MediaQuery.of(context).size.width*0.05,),
               Stack(
                 children: [
                   Container(
                       width:MediaQuery.of(context).size.width*0.42,
                       height:MediaQuery.of(context).size.height*0.35,
                       child:ClipRRect(
                         borderRadius: BorderRadius.circular(20), child:Image.asset("assets/yoga3.png",fit: BoxFit.fill,),
                       )),
                   Positioned(
                     top: MediaQuery.of(context).size.height*0.23,
//                     left: 30,
                     height:MediaQuery.of(context).size.height*0.12,
                     width: MediaQuery.of(context).size.width*0.42,
                     child:
                     Container(
//                       width: 150,
//                       height: 150,
                       decoration: BoxDecoration(
                         color: Colors.blueAccent,
                         borderRadius: BorderRadius.all(Radius.circular(20)),),
//                       color: Colors.blue,
                       child:
                       Padding(padding: EdgeInsets.fromLTRB(15,10,10,10),child:
                       Column(children: [
                         Text(
                           'Muscles-Up your way to your Strong Self',
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: 14
                           ),),
                         SizedBox(height: 10,),
                         Row(children: [
                           SizedBox(width: MediaQuery.of(context).size.width*0.07,),
                           Text(
                             'Read Now',
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 14
                             ),),
                           SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                           CircleAvatar(
                               radius: 16,backgroundColor: Colors.white,
//                backgroundImage: ExactAssetImage('assets/icon.png'),
//                                 backgroundImage:AssetImage("assets/Fav Star.png",)
                               child:Padding(padding: EdgeInsets.only(bottom: 25,right: 15),child:
                               IconButton(
                                 icon: Icon(Icons.star),//Image.asset("assets/Fav Star.png",),
                                 color: Colors.blueAccent,
                                 iconSize: 20,
                                 onPressed: () {},
                               )))
                         ],)

                       ],)
                       ),
                     ),

                   ),
                 ],
               ),
               SizedBox(width: MediaQuery.of(context).size.width*0.05,),
               Stack(
                 children: [
                   Container(
                       width:MediaQuery.of(context).size.width*0.42,
                       height:MediaQuery.of(context).size.height*0.35,
                       child:ClipRRect(
                         borderRadius: BorderRadius.circular(20), child:Image.asset("assets/yoga1.png",fit: BoxFit.fill,),
                       )),
                   Positioned(
                     top: MediaQuery.of(context).size.height*0.23,
//                     left: 30,
                     height:MediaQuery.of(context).size.height*0.12,
                     width: MediaQuery.of(context).size.width*0.42,
                     child:
                     Container(
//                       width: 150,
//                       height: 150,
                       decoration: BoxDecoration(
                         color: Colors.blueAccent,
                         borderRadius: BorderRadius.all(Radius.circular(20)),),
//                       color: Colors.blue,
                       child:
                       Padding(padding: EdgeInsets.fromLTRB(15,10,10,10),child:
                       Column(children: [
                         Text(
                           'Muscles-Up your way to your Strong Self',
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: 14
                           ),),
                         SizedBox(height: 10,),
                         Row(children: [
                           SizedBox(width: MediaQuery.of(context).size.width*0.07,),
                           Text(
                             'Read Now',
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 14
                             ),),
                           SizedBox(width: MediaQuery.of(context).size.width*0.05,),
                           CircleAvatar(
                               radius: 16,backgroundColor: Colors.white,
//                backgroundImage: ExactAssetImage('assets/icon.png'),
//                                 backgroundImage:AssetImage("assets/Fav Star.png",)
                               child:
                               IconButton(
                                 icon: Image.asset("assets/Fav Star.png",),
                                 color: Colors.blueAccent,
                                 iconSize: 35,
                                 onPressed: () {},
                               ))
                         ],)
                       ],)
                       ),
                     ),
                   ),
                 ],
               ),
             ],
           ))),

    SizedBox(height:MediaQuery.of(context).size.height*0.06,),

    Padding(padding: EdgeInsets.only(top: 20,left: 25),
    child: Text("Featured Videos",style: TextStyle(
    fontSize: 20.0,fontWeight: FontWeight.bold ),)),

    Padding(padding: EdgeInsets.only(top: 20,left: 25),child:
    Container(
    decoration: BoxDecoration(
//             color: Colors.redAccent,
    borderRadius: BorderRadius.all(Radius.circular(20)),),
    height:MediaQuery.of(context).size.height*0.20,
    child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
    Stack(
    children: [
    Container(
    width:MediaQuery.of(context).size.width*0.67,
        height:MediaQuery.of(context).size.height*0.20,
        child:ClipRRect(
          borderRadius: BorderRadius.circular(18), child:Image.asset("assets/yoga1.png",fit: BoxFit.fill,),
        )),

      Positioned(
        top: 0,
        left: 0,
        height:MediaQuery.of(context).size.height*0.05,
        width: MediaQuery.of(context).size.width*0.20,
        child: Container(
//          width: 150,
//          height: 150,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0)),
//            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
//          color: Colors.blueAccent,
          child:Center(child:  Text(
            '01:25:00',
            style: TextStyle(
                color: Colors.white,
                fontSize:12
            ),
          ),)
        ),
      ),
        Positioned(
            top: MediaQuery.of(context).size.height*0.13,
//            left: MediaQuery.of(context).size.width*0.01,
            height:MediaQuery.of(context).size.height*0.05,
            width: MediaQuery.of(context).size.width*0.20,
            child:
            CircleAvatar(
                radius: 10,backgroundColor: Colors.white,
//                backgroundImage: ExactAssetImage('assets/icon.png'),
//                                 backgroundImage:AssetImage("assets/Fav Star.png",)
                child:Padding(padding: EdgeInsets.only(bottom: 25,left: 3),child:
                IconButton(
                  icon: Icon(Icons.star),//Image.asset("assets/Fav Star.png",),
                  color: Colors.blueAccent,
                  iconSize: 30,
                  onPressed: () {},
                ))
                )),
      Positioned(
          top: MediaQuery.of(context).size.height*0.08,
            left: MediaQuery.of(context).size.width*0.32,
          height:MediaQuery.of(context).size.height*0.04,
          width: MediaQuery.of(context).size.width*0.10,
          child: Image.asset("assets/play.png",fit:BoxFit.fill,)
      ),

    ]),
      SizedBox(width: MediaQuery.of(context).size.width*0.05,),
      Stack(
          children: [
            Container(
                width:MediaQuery.of(context).size.width*0.67,
                height:MediaQuery.of(context).size.height*0.20,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(18), child:Image.asset("assets/yoga5.png",fit: BoxFit.fill,),
                )),

            Positioned(
              top: 0,
              left: 0,
              height:MediaQuery.of(context).size.height*0.05,
              width: MediaQuery.of(context).size.width*0.20,
              child: Container(
//          width: 150,
//          height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
//            borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
//          color: Colors.blueAccent,
                  child:Center(child:  Text(
                    '01:25:00',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:12
                    ),
                  ),)
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height*0.13,
//            left: MediaQuery.of(context).size.width*0.01,
                height:MediaQuery.of(context).size.height*0.05,
                width: MediaQuery.of(context).size.width*0.20,
                child:CircleAvatar(
                    radius: 10,backgroundColor: Colors.white,
//                backgroundImage: ExactAssetImage('assets/icon.png'),
//                                 backgroundImage:AssetImage("assets/Fav Star.png",)
                    child:
                    IconButton(
                      icon: Image.asset("assets/Fav Star.png",),
                      color: Colors.blueAccent,
                      iconSize: 35,
                      onPressed: () {},
                    ))),
            Positioned(
                top: MediaQuery.of(context).size.height*0.08,
                left: MediaQuery.of(context).size.width*0.32,
                height:MediaQuery.of(context).size.height*0.04,
                width: MediaQuery.of(context).size.width*0.10,
                child: Image.asset("assets/play.png",fit:BoxFit.fill,)
            ),

          ]),

    ])))


         ],)
        ),
        bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(top: 5),child:Image.asset("assets/home1.png",fit:BoxFit.cover,height: 25,width: 25,),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:Padding(padding: EdgeInsets.only(top: 5),child: Image.asset("assets/note.png",fit:BoxFit.cover,height: 25,width: 25,),),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:Padding(padding: EdgeInsets.only(top: 5),child: Image.asset("assets/play.png",fit:BoxFit.cover,height: 25,width: 25,),),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      );
  }

  Widget appbar() {
    Color appBarIconsColor = Color(0xFF212121);
    return PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.08,),
        child:AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left:10.0,top: 10),
              child:
              Transform.scale(
                scale: 0.7,
                child: new IconButton(
                  icon:Image.asset("assets/menuicon.png",fit:BoxFit.cover,),
                  onPressed: null,
                  ),
               ),),

            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search,color: Colors.grey,size: 35,),
                ),),Padding(
    
                  padding: const EdgeInsets.only(top: 10,right:15),
             child: CircleAvatar(
                radius: 20,//backgroundColor: Colors.lightGreen,
//                backgroundImage: ExactAssetImage('assets/icon.png'),
                 backgroundImage:AssetImage("assets/pic1.png",)
//                IconButton(
//                  icon: Icon(Icons.add),
//                  color: Colors.white,
//                  iconSize: 12,
//                  onPressed: () {},
////                                  tooltip: "Play",
//                ),
              ))

            ],
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Container(
              width: double.infinity,
//        alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text('Home',
//            textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 0.5,
                      color: appBarIconsColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    )),
              ),))
    );
  }
}