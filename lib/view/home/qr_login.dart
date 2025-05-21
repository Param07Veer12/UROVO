import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:urovo/services/login_service.dart';

import '../../constant/app_theme.dart';
import 'bottombar.dart';

class QrLogin extends StatefulWidget {
  const QrLogin({super.key});

  @override
  State<QrLogin> createState() => _nameState();
}

class _nameState extends State<QrLogin> {
  Barcode? _barcode;
  final controller =
      MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);

  void _handleBarcode(BarcodeCapture barcodes) {
    if (mounted) {
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
        print(_barcode!.rawValue);
        _submit(_barcode!.rawValue);
        controller.dispose();
      });
    }
  }

  void _submit(code) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(50)),
              width: 50,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoActivityIndicator(
                    color: AppTheme.primaryColor, radius: 14),
              ),
            ),
          ],
        );
      },
    );
    final service = ApiLoginPasswordService();
    service.apiQrLogin(code).then((value) {
      Navigator.pop(context);
      if (value != null) {
        if (value["errorCode"] == 0) {
          Fluttertoast.showToast(
              msg: "Login success",
              backgroundColor: Colors.green,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => BottomBar()));
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "QR Login",
            //style: AppTextStyles.headline1,
          )),
      body: MobileScanner(controller: controller, onDetect: _handleBarcode),
    );
  }
}
