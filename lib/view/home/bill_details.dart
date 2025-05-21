import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urovo/view/home/product_scan.dart';
import 'package:urovo/view/home/products.dart';
import '../../constant/app_theme.dart';

import '../../services/pref_service.dart';
import 'vendor_details.dart';

class BillsDetailsPage extends StatelessWidget {
  BillsDetailsPage({super.key});
  // void dialog() {
  //   DialogHelper.showLoading();
  //   Future.delayed(Duration(milliseconds: 400), () {
  //     PreferenceUtils().remove("token");
  //     PreferenceUtils().remove("customerId");
  //     PreferenceUtils().remove("email");
  //     PreferenceUtils().remove("name");

  //     Get.offAllNamed("/login");
  //   });

  //   //   PreferenceUtils().remove("Token");
  //   //    PreferenceUtils().remove("Token");
  // }
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Invoice No. 56",
            style: AppTextStyles.headline1.copyWith(fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 12,
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
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.tag,
                              size: 12,
                            ),
                            Expanded(
                              child: Text(
                                "  GEM135",
                                style: AppTextStyles.headline2
                                    .copyWith(fontSize: 14),
                              ),
                            ),
                            Text(
                              "ACCESSORIES",
                              style: AppTextStyles.headline2
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "WOOL BLEND STOLL",
                          style: AppTextStyles.headline1.copyWith(fontSize: 14),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Size:",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                                Text("  XXL",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Color:",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                                Text("  Yellow",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Price",
                                  style: AppTextStyles.lable
                                      .copyWith(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "₹ 2233",
                                  style: AppTextStyles.headline1
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Qty",
                                  style: AppTextStyles.lable
                                      .copyWith(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "  1",
                                  style: AppTextStyles.headline2
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ]),
        )));
  }
}
  // Icon(
  //                         CupertinoIcons.doc_chart_fill,
  //                         size: 26,
  //                         color: AppTheme.hintTextColor,
  //                       ),