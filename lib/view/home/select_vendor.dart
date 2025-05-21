import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urovo/services/common_service.dart';
import 'package:urovo/view/home/product_scan.dart';
import 'package:urovo/view/home/products.dart';
import '../../constant/app_theme.dart';

import '../../controllers/bottombar_controller.dart';
import '../../services/pref_service.dart';
import 'vendor_details.dart';

class SelectVendor extends StatefulWidget {
  SelectVendor({super.key});

  @override
  State<SelectVendor> createState() => _SelectVendorState();
}

class _SelectVendorState extends State<SelectVendor> {
  // void dialog() {
  List category = [
    {
      "title": "Chunmun Store Pvt Ltd.",
      "address": "F- 32 , Near HDFC bank Delhi",
      "image": "assets/images/mens.webp"
    },
    {
      "title": "Happy Store Pvt Ltd.",
      "address": "F- 32 , Near HDFC bank Ludhaina",
      "image": "assets/images/sweater.webp"
    }
  ];
@override
  void initState() {
    getBuyers();
    // TODO: implement initState
    super.initState();
  }
  List buyerList = [];
  String selectedCode = "";
  String selectedParty = "";
  bool isLoaded = false;
  final service = CommonService();
  void getBuyers() async {
    service.apiGetBuyers().then((value) {
      switch (value.statusCode) {
        case 200:
          isLoaded = true;
          final decodedData = jsonDecode(value.data);

          buyerList = decodedData["lstPartyNames"];

         
          break;
        case 401:
          Get.offAndToNamed("/login");
          //  DialogHelper.showErroDialog(description: "Token not valid");
          break;
        case 1:
          break;
        default:
          isLoaded = true;
          buyerList.clear();

       
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Select Buyer's",
            style: AppTextStyles.headline1,
          ),
        ),
        body: buyerList != [] ? SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: buyerList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(139, 151, 151, 155)
                                      .withOpacity(0.1),
                                  offset: Offset(1, 1),
                                  blurRadius: 2.0,
                                  spreadRadius: 1),
                            ],
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(22, 22, 22, 1)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          VendorDetails()));
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${buyerList[index]["code"]}",
                                        style: AppTextStyles.headline2
                                            .copyWith(fontSize: 16),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "${buyerList[index]["partyName"]}",
                                        style: AppTextStyles.lable
                                            .copyWith(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  CupertinoIcons.arrow_right_circle,
                                  size: 22,
                                  color: AppTheme.hintTextColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: category.length,
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      VendorDetails()));
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(139, 151, 151, 155)
                                        .withOpacity(0.1),
                                    offset: Offset(1, 1),
                                    blurRadius: 2.0,
                                    spreadRadius: 1),
                              ],
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromRGBO(22, 22, 22, 1)),
                          child: Row(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: ClipRRect(
                              //       borderRadius: BorderRadius.circular(8),
                              //       child: Image.asset(
                              //         "${category[index]["image"]}",
                              //         height: 90,
                              //         width: 80,
                              //         fit: BoxFit.cover,
                              //       )),
                              // ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${category[index]["title"]}",
                                      style: AppTextStyles.headline2
                                          .copyWith(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.map_pin_ellipse,
                                          size: 12,
                                        ),
                                        Text(
                                          "  ${category[index]["address"]}",
                                          style: AppTextStyles.lable
                                              .copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                CupertinoIcons.arrow_right_circle,
                                size: 20,
                                color: AppTheme.hintTextColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ]),
          )) : SizedBox()
        );
  }
}
