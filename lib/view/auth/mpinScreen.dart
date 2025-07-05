import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urovo/view/home/main_screen.dart';

class MPinScreen extends StatefulWidget {
  @override
  _MPinScreenState createState() => _MPinScreenState();
}

class _MPinScreenState extends State<MPinScreen> {
  String enteredPin = "";

  void validateMPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedMPin = prefs.getString('mpin');

    if (enteredPin == savedMPin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
   ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text("Incorrect MPin"),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom + 70,
      left: 20,
      right: 20,
    ),
    duration: Duration(seconds: 2),
  ),
);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter MPin"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height -
                  MediaQuery.of(context).padding.top,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, size: 60, color: Colors.green),
                    SizedBox(height: 30),
                    Text(
                      "Enter your 4-digit MPin",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    PinCodeTextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      appContext: context,
                      length: 4,
                      obscureText: true,
                      autoFocus: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        
                        activeColor: Colors.green,
                        selectedColor: Colors.orange,
                        inactiveColor: Colors.grey.shade400,
                      ),
                      onChanged: (value) => enteredPin = value,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: validateMPin,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 140),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
