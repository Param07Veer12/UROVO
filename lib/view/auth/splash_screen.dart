

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:urovo/services/login_service.dart';
import 'package:urovo/services/shared_preferences_class.dart';
import 'package:urovo/view/auth/login.dart';
import 'package:urovo/view/home/bottombar.dart';
import 'package:urovo/view/home/home.dart';
import 'package:urovo/view/home/profile.dart';
import 'package:urovo/view/home/main_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<SplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<SplashScreen> {
 final EncryptedSharedPreferences encryptedSharedPreferences =
      EncryptedSharedPreferences();


 @override
  void initState() {
    super.initState();
    
    _splashScreen();
  
  
        // encryptedSharedPreferences.getString(ACCESS_TOKEN).then((String value) {
        //     print(value);
        //     if (value == "") {
          
    //         } else {
    //           Navigator.pushAndRemoveUntil(
    //               context, MaterialPageRoute(builder: (_) {
    //             return BlocProvider(
    //               create: (context) => HomeViewBloc(context: context),
    //               child: const HomeViewPage(),
    //             );
    //           }), (route) => false);
    //         }
    //     });
    //  }
  }
   void _getRandomQuote() {
      final service = ApiLoginPasswordService();
      service.getRandomQuote()
          .then((value) {
       
        if (value.isNotEmpty) {
randomQuote = value[0]["q"];
       
        }
           Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) {
                return  LoginScreeen();
              }), (route) => false);

      });
     
   
  }


     _splashScreen() async{
       
           await SharedPreferencesClass.initializeSharedPref();


         var token = SharedPreferencesClass.prefs.getString("token");
      


       if (token == null)
       {
         _getRandomQuote();
          
       }
       else
       {
                await Future.delayed(Duration(seconds: 2));

         print(token);
           Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(builder: (_) {
                return  MainScreen();
              }), (route) => false);

       }
       }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return  Scaffold(
      body:  Container(
          color: Colors.black,
          child: Center(child: Image.asset('assets/images/Applogo.jpeg', width: 158,
  fit: BoxFit.cover)),
        ),
    );

  }
}
