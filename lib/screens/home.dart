import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registration_intern/comman/Constants.dart';
import 'package:registration_intern/main.dart';
import 'dart:io';
import 'dart:convert';
import 'package:registration_intern/screens/profile.dart';
import 'package:registration_intern/comman/CustomProgressLoader.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Home extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();
  }

  void _loginClick() {
    setState(() {

      prefs.setString(Constants.LOGIN_STATUS,"FALSE");
    });
    Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => MyApp()));

  }

  _incrementCounter() async {
     prefs = await SharedPreferences.getInstance();
  }
  /*String reply = "";
  Future<String> apiRequest(String url , Map jsonMap) async {
    try {
      CustomProgressLoader.showLoader(context);
      // var isConnect = await ConnectionDetector.isConnected();
      // if (isConnect) {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type' , 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));
      HttpClientResponse response = await request.close();

      reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      Map data = json.decode(reply);
      String status = data['status'].toString();
      for (var d in data['result']) {
        print("sdfsdfsdf ${d}");
      }
    }catch (e) {
      CustomProgressLoader.cancelLoader(context);
      print(e);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      return reply;
    }
  }
*/
  @override
  Widget build(BuildContext context) {


    return
      new Scaffold(
          appBar: AppBar(
            title: Text('Home') ,
            backgroundColor: Colors.green ,

            automaticallyImplyLeading: false ,
            actions: <Widget>[
              new FlatButton.icon(onPressed: _loginClick
                  , icon:Icon(Icons.settings_power), label: new Text("logout"))
            ],
          ) ,
          body: new Center(
            child: new Text("welcome User...") ,
          ),
        drawer: Drawer(
           // Add a ListView to the drawer. This ensures the user can scroll
           // through the options in the drawer if there isn't enough vertical
           // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Paljeet Singh Sambhi',
              style: TextStyle(color:Colors.black87),),
            accountEmail: Text('paljeets.sambhi11@gmail.com',
                style: TextStyle(color: Colors.black87,)),
            decoration: BoxDecoration(
                image: DecorationImage(image:
                new ExactAssetImage('assets/logo3.jpg'),fit: BoxFit.fill )
            ),
          ),
          /* DrawerHeader(
                  child: Text('Welcome, Mr. Paljeet'),
                  decoration: BoxDecoration(

                  color: Colors.blue,
                  ),
                ),*/
            ListTile(

                title: Text('Feeds'),
               trailing: Icon(Icons.web_asset),
                onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Feedspage()));
                },
            ),ListTile(

                title: Text('Profile'),
               trailing: Icon(Icons.web_asset),
                onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
                },
            ),
            ListTile(
              title: Text('Reset Password'),
              trailing: new Icon(Icons.lock),
              onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Resetpage()));

              },
            ), ListTile(

            title: Text('About Us'),
            trailing: Icon(Icons.info_outline),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Aboutpage()));
            },
          ),ListTile(
            title: Text('Log Out'),
            trailing: Icon(Icons.info_outline),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      )
    ),
      );
  }
}

