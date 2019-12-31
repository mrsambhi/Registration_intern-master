import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:registration_intern/comman/Constants.dart';
import 'dart:io';
import 'dart:convert';
class Profile extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  ProfileState createState() => ProfileState ();
}

class ProfileState extends State<Profile>  {
  var isLoader =false;
  String reply = "";
  String name;
  String email;
  var moblie;


  Future<String> apiRequest(String url , Map jsonMap) async {
    try {
      setState(() {
        isLoader=true;

      });
     // CustomProgressLoader.showLoader(context);
    //  var isConnect = await ConnectionDetector.isConnected();
     // if (isConnect) {
        HttpClient httpClient = new HttpClient();
        HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
        request.headers.set('content-type' , 'application/json');
        request.add(utf8.encode(json.encode(jsonMap)));
        HttpClientResponse response = await request.close();
        //you should check the response.statusCode
        reply = await response.transform(utf8.decoder).join();
        httpClient.close();
        Map data = json.decode(reply);
        //String status = data['status'].toString();
        for (var d in data['result']) {
          if (d != null) {
            setState(() {
              name = d['user_name'];
              email = d['user_email'];
              moblie = d['user_mobile'];
              isLoader=false;

            });

          }
          else {
            setState(() {
              isLoader=false;

            });
          }
        }
    //  }
    }

      catch (e) {
        setState(() {
          isLoader=false;

        });
     // CustomProgressLoader.cancelLoader(context);
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
    return reply;

  }

  @override
  void initState() {
    super.initState();
    print("Hello Paljeet");
    Map map={"id": '10'} ;
    apiRequest(Constants.PROFILE, map);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
     appBar: AppBar(title: Text('User Profile'),
       backgroundColor: Colors.black87,
     ),
        body: new Container(
          child: isLoader ?Center(
            child: new Container(
              child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation(Colors.green)),
            ),
          ):
        SingleChildScrollView(
            child: Center(
                child: Container(
                    child: Column(
                        children: <Widget>[
                          new Container(
                            margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                            child: new Image.asset('assets/profile.png'),
                            width: 200.0,
                            height: 200.0,
                          ),
                          new Container(child: Text('${name}'),
                                margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),

                                decoration: new BoxDecoration(
                                    border: new Border(
                                        bottom: new BorderSide(
                                            color: Colors.black87,
                                            style: BorderStyle.solid
                                        )
                                    )
                                ),
                          ),new Container(
                               child: Text("${email}"),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        bottom: new BorderSide(
                                            color: Colors.black87,
                                            style: BorderStyle.solid
                                        )
                                    )
                                ),
                          ),new Container(
                            child: Text("${moblie}"),
                            decoration: new BoxDecoration(
                                    border: new Border(
                                        bottom: new BorderSide(
                                            color: Colors.black87,
                                            style: BorderStyle.solid
                                        )
                                    )
                                ),
                          )
                        ]
                    )
                )

            )
        ),
        ),
    );

}