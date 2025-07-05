import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urovo/view/auth/mpinScreen.dart';

class CreateMPinScreen extends StatefulWidget {
  @override
  _CreateMPinScreenState createState() => _CreateMPinScreenState();
}

class _CreateMPinScreenState extends State<CreateMPinScreen> {
  String pin = "";
  String confirmPin = "";

  void saveMPin() async {
    if (pin.length != 4 || confirmPin.length != 4) {
      Fluttertoast.showToast(msg: "Both MPins must be 4 digits");
      return;
    }

    if (pin != confirmPin) {
      Fluttertoast.showToast(msg: "Pins do not match");
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mpin', pin);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MPinScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create MPin"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Icon(Icons.lock_outline, size: 60, color: Colors.blue),
            SizedBox(height: 30),
            Text("Enter 4-digit MPin", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: true,
              autoFocus: true,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 60,
                fieldWidth: 50,
                activeColor: Colors.blue,
                selectedColor: Colors.orange,
                inactiveColor: Colors.grey.shade400,
              ),
              onChanged: (value) => pin = value,
            ),
            SizedBox(height: 20),
            Text("Confirm MPin", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            PinCodeTextField(
              keyboardType: TextInputType.numberWithOptions(),
              appContext: context,
              length: 4,
              obscureText: true,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 60,
                fieldWidth: 50,
                activeColor: Colors.blue,
                selectedColor: Colors.orange,
                inactiveColor: Colors.grey.shade400,
              ),
              onChanged: (value) => confirmPin = value,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: saveMPin,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text("Save MPin", style: TextStyle(fontSize: 16,color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
