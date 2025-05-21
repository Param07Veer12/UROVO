import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urovo/view/home/product_details.dart';
import 'package:urovo/view/home/product_scan.dart';
import 'package:urovo/view/home/products.dart';
import '../../components/textfield.dart';
import '../../constant/app_theme.dart';

import '../../services/pref_service.dart';

class VendorDetails extends StatelessWidget {
  VendorDetails({super.key});
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
  List products = [
    {
      "title": "MEN’S WHITE SOLID KNITTED SWEATER",
      "price": "C907",
      "image": "assets/images/mens.webp"
    },
    {
      "title": "Red Floral Wool Knitted Crop Top",
      "price": "AD1597",
      "image": "assets/images/sweater.webp"
    },
    // {
    //   "title": "WHITE CHECKED KNITTED STOLE",
    //   "price": "HB1288",
    //   "image": "assets/images/stole.webp"
    // },
    // {
    //   "title": "SELF DESIGN KNITTED CASUAL CO-ORD SET",
    //   "price": "999",
    //   "image": "assets/images/cord.webp"
    // },
    // {
    //   "title": "BEIGE SOLID SELF DESIGN KNITTED A-LINE DRESS",
    //   "price": "1000",
    //   "image": "assets/images/dress.webp"
    // }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Buyer's Details",
            style: AppTextStyles.headline2.copyWith(fontSize: 16),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Chunmun Store Pvt Ltd.",
              style: AppTextStyles.headline2.copyWith(fontSize: 16),
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
                  "   F- 32 , Near HDFC bank Delhi",
                  style: AppTextStyles.lable.copyWith(fontSize: 13),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Po No.",
              style: AppTextStyles.lable,
            ),
            MyTextField(
                // textEditingController: emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Po No. is required";
                  }
                  return null;
                },
                hintText: "Enter Po No.",
                color: const Color(0xff585A60)),
            SizedBox(
              height: 12,
            ),
            Text(
              "Terms & Conditions",
              style: AppTextStyles.lable,
            ),
            MyTextField(
                // textEditingController: emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Po No. is required";
                  }
                  return null;
                },
                hintText: "Enter Terms & Conditions",
                color: const Color(0xff585A60)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Articles",
                  style: AppTextStyles.bodyText,
                ),
                GestureDetector(
                  onTap: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProductScan()));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "+ Article",
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ListView.builder(
              itemCount: products.length,
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                      MaterialPageRoute(
                              builder: (BuildContext context) => ProductDetail(products:products[index])));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              "${products[index]["image"]}",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${products[index]["title"]}",
                                style: AppTextStyles.headline2
                                    .copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.numbers,
                                    size: 18,
                                  ),
                                  Text(
                                    " ${products[index]["price"]}",
                                    style: AppTextStyles.lable
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  Text(
                                    " Qty 2",
                                    style: AppTextStyles.lable
                                        .copyWith(fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
