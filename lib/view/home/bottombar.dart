import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urovo/view/home/home.dart';
import 'package:urovo/view/home/profile.dart';

import '../../constant/app_theme.dart';
import '../../controllers/bottombar_controller.dart';
import 'category.dart';
import 'legder.dart';
import 'select_vendor.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  final pages = [Home(), Legder(), SelectVendor(), Profile()];

  @override
  Widget build(BuildContext context) {
    const bottomNavigationBarItem = BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chart_bar), label: 'Ledger');
    return GetBuilder<HomepageController>(
        builder: (controller) => Scaffold(
              // body: IndexedStack(
              //   children: [
              //     HomePage(),
              //     Certificate(),
              //     Text('notifications'),
              //     EBattle(),
              //     Profile(),
              //   ],
              //   index: controller.tabIndex,
              // ),
              body: pages[controller.tabIndex],
              bottomNavigationBar: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppTheme.lightHintTextColor,
                            blurRadius: 1,
                            offset: Offset(1, 1),
                            spreadRadius: 1),
                      ],
                    ),
                    child: BottomNavigationBar(
                      // showSelectedLabels: false,
                      //  showUnselectedLabels: false,
                      selectedLabelStyle:
                          TextStyle(color: AppTheme.primaryColor),
                      selectedItemColor: AppTheme.primaryColor,

                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      elevation: 6,
                      unselectedLabelStyle: AppTextStyles.lable,
                      unselectedItemColor: AppTheme.hintTextColor,
                      iconSize: 22,
                      type: BottomNavigationBarType.fixed,

                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Icon(Icons.home), label: 'Home'),
                        bottomNavigationBarItem,
                        BottomNavigationBarItem(
                            icon: Icon(Icons.shopping_bag_outlined),
                            label: 'Products'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.account_circle), label: 'Account'),
                      ],
                      onTap: (val) {
                        FocusScope.of(context).unfocus();
                        controller.changeTabIndex(val);
                      },
                      currentIndex: controller.tabIndex,
                    ),
                  ),
                  // Positioned(
                  //   top: -25,
                  //   left: 0,
                  //   right: 0,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       //  controller.changeTabIndex(2);
                  //     },
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Container(
                  //           padding: const EdgeInsets.all(1),
                  //           // margin: EdgeInsets.only(top: 25.h),
                  //           height: 60,
                  //           width: 60,
                  //           decoration: BoxDecoration(
                  //             gradient: LinearGradient(
                  //                 begin: Alignment.topCenter,
                  //                 colors: [
                  //                   AppTheme.primaryColor,
                  //                   AppTheme.primaryColor
                  //                 ]),
                  //             borderRadius: BorderRadius.circular(100),
                  //           ),
                  //           child: Container(
                  //             height: 60,
                  //             width: 60,
                  //             decoration: BoxDecoration(
                  //                 color: Color.fromARGB(255, 51, 50, 50),
                  //                 shape: BoxShape.circle),
                  //             child: Padding(
                  //                 padding: const EdgeInsets.all(6.0),
                  //                 child: Icon(CupertinoIcons.barcode_viewfinder)),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ));
  }
}

