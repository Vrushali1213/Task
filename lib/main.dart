
import 'package:flutter/material.dart';
import 'package:flutterapp/homepage.dart';
import 'package:flutterapp/login.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  print(status);
  runApp(GetMaterialApp(debugShowCheckedModeBanner: false,home: status == false ? LoginPage() : HomePage()));
//  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 300,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              width: 200.0,
              height: 50.0,
              //padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child:
              RaisedButton(
                color: Colors.grey,//Color(0xff09a8d9),
                splashColor: Colors.lightBlue,
                shape: StadiumBorder(),
                onPressed: () {
                  Get.to(() =>LoginPage());
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Screen',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
            ),),
          SizedBox(height: 20,),

        ],
        ),
      ),
    );
  }
}
