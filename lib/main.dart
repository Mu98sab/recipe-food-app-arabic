import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe/Controller/handler.dart';



void main() async{
  // This is called when initializing the firebase on the main function
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();     // inithialize the firebase
  runApp(MyApp());                    // run the app
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe',
      theme: ThemeData(
        textTheme: TextTheme(

          headline1: TextStyle(
            fontSize: 30,
          ),
          
          headline2: TextStyle(
            fontSize: 26,
          ),

          headline3: TextStyle(
            fontSize: 22,
          ),
          
          bodyText1: TextStyle(
            fontSize: 18,
          ),

          bodyText2: TextStyle(
            fontSize: 15
          ),
        ),

        /*RED EDITION */
        // Color(0xfff3e3e2), ==> Primary
        // Color(0xff74112f), ==> accent
        // Color(0xffada7a7).withOpacity(.3),


        // My lovely grey Color(0xff738290),
        fontFamily: "Cocon",/*"JF-Flat",*///"ithra-light",//"wasm",
        primaryColor: Color(0xfff1e8db),//Color(0xff535778),//Color(0xff5d7599),
        backgroundColor: /*Color(0xff11183f),*/Color(0xfff9f9f9),
        accentColor: Color(0xff4a0d4a),//Color(0xff403d52),
      
        indicatorColor: Color(0xfffffcf7),//.withOpacity(.8),//Color(0xfff8eae2),
        shadowColor: Colors.black.withOpacity(.15),
      ),
      debugShowCheckedModeBanner: false,
      home: Handler(),
    );
  }
}
