
import 'package:apil/Screens/home_page.dart';
import 'package:apil/Screens/new_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool save = false;

  String _email, _password, _error;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;








  Future<FirebaseUser> _handleSignIn() async {
    final formState = _key.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
                email: emailcontroller.text, password: passwordcontroller.text))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        print(e);
        setState(() {
          _error = e.message;
        });
      }
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatepassword(String value) {
    if (value.length <= 7) {
      return 'Invalid Password';
    }
  }

  showAlert() {
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 9, right: 9, top: 12),
        child: Row(
          children: <Widget>[
            Icon(Icons.error_outline),
            Expanded(
              child: Text(
                _error,
                maxLines: 2,
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.deepPurple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
          ),
          Positioned(
            top: 80,
            bottom: 43,
            left: 12,
            right: 12,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 26),
                        ),
                      ),
                      Container(
                        child: showAlert(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 35, left: 8, right: 8),
                        child: TextFormField(
                          controller: emailcontroller,
                          validator: validateEmail,
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              labelText: 'Work Email address'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, right: 8, left: 8),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordcontroller,
                          validator: validatepassword,
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              labelText: 'Password'),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                              value: save,
                              onChanged: (bool value) {
                                setState(() {
                                  save = value;
                                });
                              }),
                          Text('Remember me')
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: MaterialButton(
                          height: 45,
                          shape: StadiumBorder(),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20),
                          ),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          elevation: 10,
                          onPressed: () {
                            _handleSignIn();
                          },
                        ),
                      ),
                      Divider(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Text(
                          'Forgot Password?',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>NewUser())),
                          child: Text(
                            'sign up',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
