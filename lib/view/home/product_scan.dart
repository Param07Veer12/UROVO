import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../../components/textfield.dart';
import '../../constant/app_theme.dart';

class ProductScan extends StatefulWidget {
  @override
  State<ProductScan> createState() => _nameState();
}

class _nameState extends State<ProductScan> {
  final statusid = TextEditingController();
  List getStatus = [];
  final _formKey = GlobalKey<FormState>();
  int id = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late ScrollController _scrollController;
  late ScrollController _scrollController2;
  @override
  void initState() {
    super.initState();
    _scrollController2 = ScrollController();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          titleSpacing: 0,
          title: Text(
            "Product Scan",
          ),
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MyTextField(
                      //  textEditingController: password,
                      //   isSuffixIcon: true,
                      // obsecureText: !passwordLoginVisibility,
                      ontapSuffix: () {
                        // passwordLoginVisibility = !passwordLoginVisibility;
                        setState(() {});
                        // _controller.showPassword();
                      },
                      hintText: "Scan Barcode No.",
                      icon: Icon(Icons.qr_code_scanner_sharp),
                      color: const Color(0xff585A60)),
                ),
                SizedBox(
                  height: 20,
                ),

                
              ],
            )));
  }
}
