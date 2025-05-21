import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:urovo/constant/app_theme.dart';

import '../../components/textfield.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({super.key, this.products});
  var products;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List colors = ["Mauve", "Black", "Yellow", "Red"];

  List size = ["S", "Xl", "XXl", "XXXl", "Free"];

  List<int> selectedItems = [];
  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            iconTheme: IconThemeData(color: Colors.black),

            expandedHeight: 200,
            //  forceElevated: innerBoxIsScrolled,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
              widget.products["image"],
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            )),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.products["title"],
                        style: GoogleFonts.montserrat(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text("Men's Sweater"),

                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Icon(Icons.star_outlined, color: AppTheme.starColor,size: 16,),
                      //       Text("  (4.3K)", style: AppTextStyles.lable),
                      //     ]),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Colors",
                            style: AppTextStyles.lable,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 16,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: CupertinoSwitch(
                                    // This bool value toggles the switch.
                                    //  inactiveThumbColor: AppTheme.backGround2,
                                    //  activeTrackColor: AppTheme.primaryColor,
                                    activeColor: AppTheme.primaryColor,
                                    //  inactiveTrackColor: AppTheme.backGround2,
                                    value: isRemember,
                                    // trackOutlineWidth: 20,
                                    //   trackColor: MaterialStatePropertyAll<Color>(
                                    //       AppTheme.primaryColor),
                                    //   thumbColor:
                                    //       const MaterialStatePropertyAll<Color>(Colors.white),
                                    onChanged: (bool value) {
                                      setState(() {
                                        isRemember = !isRemember;
                                      });
                                      // This is called when the user toggles the switch.
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    " Is Manual",
                                    style: AppTextStyles.lable,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      if (isRemember)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: MyTextField(
                              // textEditingController: emailController,

                              hintText: "Enter Manual qty",
                              color: const Color(0xff585A60)),
                        ),
                      if (!isRemember)
                        SizedBox(
                          height: 16,
                        ),
                      if (!isRemember)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              colors.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (selectedItems.contains(index)) {
                                      selectedItems.remove(index);
                                    } else {
                                      selectedItems.add(index);
                                    }
                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 16),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: selectedItems.contains(index)
                                            ? Colors.white
                                            : Colors.transparent,
                                        border: Border.all(
                                            color:
                                                AppTheme.lightHintTextColor)),
                                    child: Text(
                                      colors[index],
                                      style: GoogleFonts.inter(
                                          fontSize: 13,
                                          color: selectedItems.contains(index)
                                              ? Colors.black
                                              : const Color.fromARGB(
                                                  255, 238, 234, 234),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Enter Size Qty:",
                        style: AppTextStyles.lable,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ...List.generate(
                        size.length,
                        (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  size[index],
                                  style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      height: 0),
                                ),
                                Container(
                                    width: 150,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Enter Qty",
                                        hintStyle: AppTextStyles.hintText
                                            .copyWith(fontSize: 12),
                                      ),
                                    ))
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Remarks",
                        style: AppTextStyles.lable,
                      ),
                      MyTextField(
                          // textEditingController: emailController,

                          hintText: "Enter Remarks",
                          color: const Color(0xff585A60)),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 20, bottom: 20, right: 16, top: 16),
        decoration: BoxDecoration(color: Color.fromRGBO(30, 30, 30, 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Qty: 10",
                  style: GoogleFonts.montserrat(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => CartPage()));
              },
              child: Container(
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 133, 239),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(
                      0.5,
                    ))),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 26),
                  child: Text(
                    "Submit",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      //  bottomNavigationBar: Container(),
    );
  }
}
