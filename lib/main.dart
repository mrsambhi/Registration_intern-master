import 'package:flutter/material.dart';
import 'package:registration_intern/comman/Constants.dart';
import 'package:registration_intern/screens/home.dart';
import 'package:registration_intern/screens/login.dart';
import 'package:registration_intern/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo'
      ,debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Connectivity Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String loginStatus="FALSE";
  void _signUpClick() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => signup()));
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incrementCounter();
  }

  void _loginClick() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => Login()));
  }

  _incrementCounter() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {

    loginStatus = prefs.getString(Constants.LOGIN_STATUS);
});
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if
    (loginStatus=="TRUE"){
      return Scaffold(

    body:   Home()
      );
    }else{

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title:

        Text(widget.title),

      ),
      body:LayoutBuilder(builder: (context, constraints)
    {
        return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth ,
                  minHeight: constraints.maxHeight) ,
              child: IntrinsicHeight(
                  child: Column(
                      mainAxisSize: MainAxisSize.max ,
                      children: [
                        Expanded(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                new Expanded(child: new Container(

                                  child: Padding(
                                    padding: const EdgeInsets.all(50.0),
                                    child: new Material(
                                      elevation: 5.0 ,
                                      borderRadius: BorderRadius.circular(30.0) ,
                                     color:  Colors.green,
                                      child: MaterialButton(
                                          minWidth: MediaQuery
                                              .of(context)
                                              .size
                                              .width ,
                                          padding: EdgeInsets.fromLTRB(
                                              20.0 , 20.0 , 20.0 , 20.0) ,
                                          onPressed: () {
                                            _loginClick();
                                          } ,
                                          child: Text(
                                            "Login" ,
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.white ,
                                                fontWeight: FontWeight.bold) ,
                                          )) ,
                                    ),
                                  ) ,
                                ) ,
                                ) , new Expanded(child: new Container(

                                  child: Padding(
                                    padding: const EdgeInsets.all(50.0),
                                    child: new Material(
                                      elevation: 5.0 ,
                                      borderRadius: BorderRadius.circular(30.0) ,
                                      color: Colors.blueGrey,
                                      child: MaterialButton(
                                          minWidth: MediaQuery
                                              .of(context)
                                              .size
                                              .width ,
                                          padding: EdgeInsets.fromLTRB(
                                              20.0 , 20.0 , 20.0 , 20.0) ,
                                          onPressed: () {
                                            _signUpClick();
                                          } ,
                                          child: Text(
                                            "Registration" ,
                                            textAlign: TextAlign.center ,
                                            style: TextStyle(
                                                color: Colors.white ,
                                                fontWeight: FontWeight.bold) ,
                                          )
                                      ) ,
                                    ),
                                  ) ,
                                ) ,
                                )
                              ] ,
                            ) ,
                          ) ,
                        ) ,
                        // This trailing comma makes auto-formatting nicer for build methods.
                      ]
                  )
              )
          )
      );
    }
    )
    );
  }
  }

  }

