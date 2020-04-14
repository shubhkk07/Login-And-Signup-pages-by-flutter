

import 'home_page.dart';
import 'package:apil/Screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';


class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState( );
}

class _NewUserState extends State<NewUser> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>( );

  String password, _error;

  TextEditingController namecontroller = TextEditingController( );

  TextEditingController emailcontro = TextEditingController( );

  TextEditingController passwordcontro = TextEditingController( );

  TextEditingController passwordcontro2 = TextEditingController( );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  showError() {
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.only( left: 9, right: 9, top: 12 ),
        child: Row(
          children: <Widget>[
            Icon( Icons.error_outline ),
            Expanded(
              child: Text(
                _error,
                maxLines: 2,
                style: TextStyle( color: Colors.red ),
              ),
            )
          ],
        ),
      );
    }
  }

  void _register() async {
    final formState = _globalKey.currentState;
    if (formState.validate( )) {
      formState.save( );

      try {
        final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: emailcontro.text,
          password: passwordcontro.text,
        ))
            .user;
        formState.reset();


        alertDialog(context);

      } catch (e) {
        print( e );
        setState( () {
          _error = e.message;
        } );
      }
    }
  }

  final passwordValidator = MultiValidator( [
    RequiredValidator( errorText: 'password is required' ),
    MinLengthValidator(
        8, errorText: 'password must be at least 8 digits long' ),
    PatternValidator( r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords does not match required condition' )
  ] );

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp( pattern );
    if (!regex.hasMatch( value ))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validateName(String name) {
    if (name.length <= 1) {
      return 'enter your name';
    }
  }

  void alertDialog(BuildContext context) {
    var alertDialog = AlertDialog(
      content: Text( 'You are successfully registered.' ),
      actions: <Widget>[

        RaisedButton(
          child: Text( 'Go to Login Page' ),
          onPressed: () {
            Navigator.push( context,
                MaterialPageRoute( builder: (context) => LoginPage( ) ) );
          },
        )
      ],
    );
    showDialog( context: null, builder: (BuildContext context) => alertDialog );
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
                    end: Alignment.bottomLeft ) ),
          ),
          Positioned(
            top: 80,
            bottom: 43,
            left: 12,
            right: 12,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 15 ),
                    color: Colors.white ),
                child: Form(
                  key: _globalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only( top: 30 ),
                        child: Text(
                          'Candidate Signup',
                          textAlign: TextAlign.center,
                          style: TextStyle( fontSize: 26 ),
                        ),
                      ),
                      Container(
                        child: showError( ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only( top: 35, left: 8, right: 8 ),
                        child: TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular( 40 ) ),
                              labelText: 'Candidate Name' ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only( top: 15, right: 8, left: 8 ),
                        child: TextFormField(
                          controller: emailcontro,
                          validator: validateEmail,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular( 40 ) ),
                              labelText: 'Email Address' ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only( top: 15, right: 8, left: 8 ),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordcontro,
                          onChanged: (val) => password = val,
                          validator: passwordValidator,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular( 40 ) ),
                              labelText: 'Password' ),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only( top: 15, right: 8, left: 8 ),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordcontro2,
                          validator: (val) =>
                              MatchValidator(
                                  errorText: "password don't match" )
                                  .validateMatch( val, password ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular( 40 ) ),
                              labelText: 'Confirm Password' ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only( left: 8, right: 8, top: 30 ),
                        child: MaterialButton(
                          height: 45,
                          shape: StadiumBorder( ),
                          child: Text(
                            'Register',
                            style: TextStyle( fontSize: 20 ),
                          ),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          elevation: 10,
                          onPressed: () {
                            _register( );

                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only( top: 4, bottom: 8 ),
                        child: GestureDetector(
                          child: Text(
                            'Back',
                            textAlign: TextAlign.center,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage( ) ) );
                          },
                        ),
                      ),
                      Divider(
                        height: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 5, left: 8, right: 8, bottom: 6 ),
                        child: RichText(
                          text: TextSpan( children: [
                            TextSpan(
                                text: 'Note:',
                                style: TextStyle( color: Colors.black ) ),
                            TextSpan(
                                text:
                                ' Password must contain more than 8 chracters and one uppercase,lowercase,special chracter and a number',
                                style: TextStyle( color: Colors.red ) )
                          ] ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
