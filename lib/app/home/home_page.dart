import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vbee_app/base/network/network_utils.dart';
import 'package:vbee_app/base/theme/custom_theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.customTheme}) : super(key: key);
  final String title;
  final CustomTheme customTheme;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    // var url =
    //     "https://raw.githubusercontent.com/thanhnguyen1121/guide_app_f_studio/main/amongus_ads_config_v2.json";
    // NetWorkUtils.get(url);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "enter your input",
                        hintText: "input something",
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 2.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                            borderRadius: BorderRadius.circular(5.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please input something!";
                      } else {
                        return null;
                      }
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print("progress data");
                      }
                    },
                    child: Text("Submit"),
                  )
                ],
              ),
            ),

            // ignore: deprecated_member_use
            RaisedButton(
                child: Text("Login with google"),
                onPressed: () async {
                  GoogleSignInAccount _currentUser;
                  GoogleSignIn _googleSignIn = GoogleSignIn(
                    scopes: [
                      'email',
                      'https://www.googleapis.com/auth/contacts.readonly',
                    ],
                  );
                  _googleSignIn.onCurrentUserChanged
                      .listen((GoogleSignInAccount account) {
                    setState(() {
                      _currentUser = account;
                    });
                    if (_currentUser != null) {
                      print("_currentUser: " + _currentUser.toString());
                    }
                  });

                  await _googleSignIn.signIn();
                }),
            // ignore: deprecated_member_use
            RaisedButton(
                child: Text("Login"),
                onPressed: () async {
                  final User user = (await _auth.signInWithEmailAndPassword(
                    email: "anhthanh098@gmail.com",
                    password: "Anhthanh1102",
                  ))
                      .user;

                  print("user: " + user.toString());
                }),
            // ignore: deprecated_member_use
            RaisedButton(
                child: Text("Register"),
                onPressed: () async {
                  final User user = (await _auth.createUserWithEmailAndPassword(
                    email: "anhthanh098@gmail.com",
                    password: "Anhthanh1102",
                  ))
                      .user;
                  if (user != null) {
                    print("User: " + user.toString());
                  } else {
                    print("Loi!");
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.customTheme.toggleTheme();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
