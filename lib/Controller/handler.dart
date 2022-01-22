import 'package:flutter/material.dart';
import 'package:recipe/Model/authentication.dart';
import 'package:recipe/Model/user.dart';
import 'package:recipe/View/page_controler.dart';
import 'package:recipe/View/welcome.dart';



class Handler extends StatefulWidget {
  const Handler({Key? key}) : super(key: key);

  @override
  _HandlerState createState() => _HandlerState();
}

class _HandlerState extends State<Handler> {
  // inithialize the authentication class 
  // This class contain all the authentication services as a functions
  // TODO: Check whether or not it's important to create an instance 
  final Authentication _auth = Authentication();
  
  // responsible to shift between the home and welcome pages
  bool _signIn = false;

  // current user instance
  RecipeUser? _currUser;
  
  @override
  Widget build(BuildContext context) {
    // return home if the user is signed in
    // or sign in page if the user is not sign in
    _auth.user.listen(      // funtion will be called when user state changes
      (user) {
       
        if (user != null && (!_signIn || user.name != _currUser?.name)) {
          print("User: ${user.email}");
          setState(() {
            _currUser = user;
          });
        }
        // if [user is sign out and displayed page is Home] 
        // or [user is sign in and displayed page is sign in]
        if ( (user == null && _signIn) || (user != null && !_signIn)) { 
          print("${user?.email} ${DateTime.now().toString()}");
          setState(() {
            _signIn = user != null;
          });
        }
      },
    );


    return _signIn ? PageControler(user: _currUser,) : Welcome();
  }
}
