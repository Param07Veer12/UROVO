import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urovo/view/home/product_scan.dart';
import 'package:urovo/view/home/products.dart';
import '../../constant/app_theme.dart';

import '../../services/pref_service.dart';

class CategoryPage extends StatelessWidget {
   CategoryPage({super.key});
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
List category=[
  {
    "title":"Men's Sweater",
    "items":"5",
    "image":"assets/images/mens.webp"
  },{
    "title":"Shrug",
    "items":"3",
    "image":"assets/images/sweater.webp"
  },
  {
    "title":"Stole",
    "items":"3",
    "image":"assets/images/stole.webp"
  }
  ,
  {
    "title":"Co-ord Sets",
    "items":"3",
    "image":"assets/images/cord.webp"
  }
  ,
  {
    "title":"Dress",
    "items":"3",
    "image":"assets/images/dress.webp"
  }
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Category",
            style: AppTextStyles.headline1,
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                              builder: (BuildContext context) => ProductsPage()));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2, vertical: 12),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "${category[index]["image"]}",
                                height: 90,
                                width: 80,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  ${category[index]["title"]}",
                              style:
                                  AppTextStyles.headline2.copyWith(fontSize: 16),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                               "  ${category[index]["items"]} items",
                              style: AppTextStyles.lable.copyWith(fontSize: 13),
                            ),
                          ],
                        )
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
