import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:urovo/view/home/product_details.dart';

import '../../components/textfield.dart';
import '../../constant/app_theme.dart';

class ProductsPage extends StatefulWidget {
  @override
  _StaggeredGridExampleState createState() => _StaggeredGridExampleState();
}

class _StaggeredGridExampleState extends State<ProductsPage> {
  List products = [
    {
      "title": "MEN’S WHITE SOLID KNITTED SWEATER",
      "price": "1907",
      "image": "assets/images/mens.webp"
    },
    {
      "title": "Red Floral Wool Knitted Crop Top",
      "price": "1597",
      "image": "assets/images/sweater.webp"
    },
    {
      "title": "WHITE CHECKED KNITTED STOLE",
      "price": "1288",
      "image": "assets/images/stole.webp"
    },
    {
      "title": "SELF DESIGN KNITTED CASUAL CO-ORD SET",
      "price": "999",
      "image": "assets/images/cord.webp"
    },
    {
      "title": "BEIGE SOLID SELF DESIGN KNITTED A-LINE DRESS",
      "price": "1000",
      "image": "assets/images/dress.webp"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Products",
            style: AppTextStyles.headline1,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              MyTextField(
                  //  textEditingController: password,
                  //   isSuffixIcon: true,
                  // obsecureText: !passwordLoginVisibility,
                  ontapSuffix: () {
                    // passwordLoginVisibility = !passwordLoginVisibility;
                    setState(() {});
                    // _controller.showPassword();
                  },
                  hintText: "Search",
                  icon: Icon(Icons.search),
                  color: const Color(0xff585A60)),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.custom(
                  gridDelegate: SliverStairedGridDelegate(
                      crossAxisSpacing: 20,
                      tileBottomSpace: 20,
                      mainAxisSpacing: 16,
                      pattern: [
                        StairedGridTile(0.5, 0.68),
                        StairedGridTile(0.5, 0.68)
                      ]),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: products.length,
                    (context, index) {
                      return GestureDetector(
                        onTap: () {
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ProductDetail(products:products[index])));
                        },
                        child: Container(
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
                              color: Color.fromRGBO(30, 30, 30, 1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      "${products[index]["image"]}",
                                      fit: BoxFit.cover,
                                      height: 180,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                      bottom: -20,
                                      right: 6,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(22, 22, 22, 1)),
                                        child: Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color.fromARGB(255, 2, 133, 239)),
                                            child: Icon(
                                              Icons.shopping_bag_outlined,
                                              size: 18,
                                            )),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  "₹ ${products[index]["price"]}",
                                  style:
                                      AppTextStyles.lable.copyWith(fontSize: 14),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  "${products[index]["title"]}",
                                  style: AppTextStyles.headline2
                                      .copyWith(fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
