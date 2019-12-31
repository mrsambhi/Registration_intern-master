import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registration_intern/comman/Connectivity.dart';
import 'package:registration_intern/comman/Constants.dart';
import 'dart:io';
import 'dart:convert';

import 'package:registration_intern/comman/CustomProgressLoader.dart';
import 'package:registration_intern/screens/home.dart';
import 'package:registration_intern/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  var id;
  int _counter = 0;
  bool obscureText = true, passwordVisible = false;

  TextEditingController em = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String reply="";

  Future<String> apiRequest(String url, Map jsonMap) async {
    try {
      CustomProgressLoader.showLoader(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // var isConnect = await ConnectionDetector.isConnected();
       // if (isConnect) {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(jsonMap)));
      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode
      reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      Map data = json.decode(reply);
      String status = data['status'].toString();
      for(var d in data['result']){
        print(" ${d}");
        setState(() {
          id=d['id'];

        });
      }

      print('RESPONCE_DATA : ' + status);
      CustomProgressLoader.cancelLoader(context);

        if (status == "success") {
        prefs.setString(Constants.LOGIN_STATUS, "TRUE");
        prefs.setString(Constants.USER_ID, id);
        Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => Home()));

        Fluttertoast.showToast(
            msg: "Login Succesful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }else if(status == "incorrect_password"){
        Fluttertoast.showToast(
            msg: "Username and password is wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Try Again Some Thing Is Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
  /*  }else {
        CustomProgressLoader.cancelLoader(context);
        Fluttertoast.showToast(
            msg: "Please check your internet connection....!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
        // ToastWrap.showToast("Please check your internet connection....!");
        // return response;
      }*/
    }
    catch (e) {
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

  validation() async {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (em.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Mobile No",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }else if (pass.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please Enter Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Map map = {"user_mobile": '${em.text}',
        "user_password":'${pass.text}'};
      apiRequest(Constants.LOGIN_URL, map);
    }
  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
    new Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green,

        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: new Image.asset('images/logo.png'),
                  width: 80.0,
                  height: 80.0,
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 0.0),
                  child: new Row(
                    children: <Widget>[
                      /*new Container(
                        margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: Image(image: AssetImage('images/cellphone.png')),
                        width: 30.0,
                        height: 30.0,
                      ),*/
                      new Expanded(
                          child: Container(
                        margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                            child: new TextField(
                            controller: em,
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            decoration: InputDecoration(
                            labelText: 'Mobile No',
                            labelStyle: theme.textTheme.caption
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        decoration: new BoxDecoration(
                            border: new Border(
                                bottom: new BorderSide(
                                    color: Colors.green,
                                    style: BorderStyle.solid))),
                      ))
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 0.0),
                  child: new Row(
                    children: <Widget>[
                      /*new Container(
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                        child: Image(image: AssetImage('images/password.png')),
                        width: 30.0,
                        height: 30.0,
                      ),*/
                      new Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),

                            child: new TextField(
                              textAlign: TextAlign.start,
                              obscureText: obscureText,
                              controller: pass,
                              maxLines: 1,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(

                                  icon: Icon(
                                // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                      if (passwordVisible == false) {
                                        obscureText = true;
                                      } else if (passwordVisible == true) {
                                        obscureText = false;
                                      }
                                    }
                                    );
                                    },
                                ),
                            labelText: 'Password',
                            labelStyle: theme.textTheme.caption
                                .copyWith(color: Colors.green),
                          ),
                        ),
                        decoration: new BoxDecoration(
                            border: new Border(
                                bottom: new BorderSide(
                                    color: Colors.green,
                                    style: BorderStyle.solid))),

                          )
                      )
                    ],
                  ),
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(35.0, 80.0, 35.0, 0.0),
                  child: new Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.green,
                    child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                        onPressed: () {
                          validation();
                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                    ),
                  ),
                ),


                new GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => signup()));
                  },
                  child: new Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: new Text("Dont have an account, Register now", style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
