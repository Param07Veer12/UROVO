import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urovo/services/shared_preferences_class.dart';
import 'package:urovo/view/auth/splash_screen.dart';
import 'package:urovo/view/home/article_screen.dart';
import 'package:urovo/view/home/bills.dart';

import 'package:urovo/view/home/legder.dart';
import 'package:urovo/view/home/qr_login.dart';
import 'package:urovo/view/home/selectParty.dart';
import 'package:urovo/view/home/upload_builty.dart';
import '../../constant/app_theme.dart';

import '../../services/pref_service.dart';
import '../auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // void dialog() {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              "Profile",
              style: AppTextStyles.headline1,
            )),
        body: SingleChildScrollView(
            child: Container(
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 20,
            ),
            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/Logo1.ico'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "User",
              style: AppTextStyles.headline1,
            ),
            Text(
              "user@gmail.com",
              style: AppTextStyles.headline1,
            ),
            SizedBox(
              height: 25,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Column(
            //       children: [
            //         Text(
            //           "10",
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodySmall!
            //               .copyWith(fontSize: 16),
            //         ),
            //         SizedBox(
            //           height: 10,
            //         ),
            //         Text(
            //           "Total Bills",
            //           style: Theme.of(context)
            //               .textTheme
            //               .bodySmall!
            //               .copyWith(fontSize: 16, color: AppTheme.primaryColor),
            //         ),
            //       ],
            //     ),
            //     GestureDetector(
            //       behavior: HitTestBehavior.opaque,
            //       onTap: () {},
            //       child: Column(
            //         children: [
            //           Text(
            //             "20",
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodySmall!
            //                 .copyWith(fontSize: 16),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text(
            //             "Total Sales",
            //             style: Theme.of(context).textTheme.bodySmall!.copyWith(
            //                 fontSize: 16, color: AppTheme.primaryColor),
            //           ),
            //         ],
            //       ),
            //     )
            //   ],
            // ),

            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Account Settings",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 16),
                        ),
                        Icon(
                          Icons.settings,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),

                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Privacy Policy",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 16),
                          ),
                          Icon(
                            Icons.privacy_tip_rounded,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  // SizedBox(
                  //   height: 16.h,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     Get.to(Purchasepolicy());
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text("Purchase Policy",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .displayLarge!),
                  //       Icon(
                  //         Icons.arrow_forward,
                  //         size: 20,
                  //         color: AppTheme.primaryColor,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Text(
                  //   "Account",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headlineLarge!
                  //       .copyWith(fontSize: 22),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.dialog(
                  //        context: Get.context,//
                  //       CupertinoAlertDialog(
                  //         title: const Text('Delete Account'),
                  //         insetAnimationCurve: Curves.linear,
                  //         insetAnimationDuration:
                  //             const Duration(milliseconds: 500),
                  //         content: const Padding(
                  //           padding: EdgeInsets.only(top: 4.0),
                  //           child: Text(
                  //             "Are you sure you want to close your account",
                  //           ),
                  //         ),
                  //         actions: <CupertinoDialogAction>[
                  //           CupertinoDialogAction(
                  //             / This parameter indicates this action is the default,
                  //             / and turns the action's text to bold text.
                  //             isDefaultAction: true,
                  //             onPressed: () {
                  //               Get.back();
                  //             },
                  //             child: const Text('Cancel'),
                  //           ),
                  //           CupertinoDialogAction(
                  //             / This parameter indicates the action would perform
                  //             / a destructive action such as deletion, and turns
                  //             / the action's text color to red.
                  //             isDestructiveAction: true,
                  //             onPressed: () {
                  //             controller.deleteAccount();
                  //             },
                  //             child: const Text('Delete'),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment:
                  //         MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text("Delete Account",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .displayLarge!),
                  //       Icon(
                  //         Icons.arrow_forward,
                  //         size: 20,
                  //         color: AppTheme.primaryColor,
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Give your feedback",
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .headlineSmall!
                  //           .copyWith(fontSize: 16),
                  //     ),
                  //     Icon(
                  //       Icons.arrow_forward,
                  //       size: 20,
                  //       color: AppTheme.primaryColor,
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // Text(
                  //   "About",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headlineLarge!
                  //       .copyWith(fontSize: 24),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Orders",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 16),
                        ),
                        Icon(
                          CupertinoIcons.square_list,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => SelectPartyScreen()));
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                      
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Bills",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 16),
                          ),
                          Icon(
                            CupertinoIcons.doc,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Legder()));
                    },
                    child: Container(
                      
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ledger",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 16),
                          ),
                          Icon(
                            CupertinoIcons.chart_bar,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                      InkWell(
                    onTap: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => UploadBuilty()));
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Upload Builty",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 16),
                          ),
                          Icon(
                                        
                                Icons.business, 
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  //   SizedBox(
                  //   height: 16,
                  // ),
                      InkWell(
                    onTap: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => ArticleScreen()));
                    },
                    child: Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Article",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 16),
                          ),
                          Icon(
                                        
                                Icons.business, 
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 16,
                  // ),
  //                 InkWell(
  //                   onTap: () {
  //                     showDialog(
  //                       context: context,
  //                       builder: (context) => CupertinoAlertDialog(
  //                         title: const Text('Logout'),
  //                         insetAnimationCurve: Curves.linear,
  //                         insetAnimationDuration:
  //                             const Duration(milliseconds: 500),
  //                         content: const Padding(
  //                           padding: EdgeInsets.only(top: 4.0),
  //                           child: Text(
  //                             "Are you sure you want to logout",
  //                           ),
  //                         ),
  //                         actions: <CupertinoDialogAction>[
  //                           CupertinoDialogAction(
  //                             /// This parameter indicates this action is the default,
  //                             /// and turns the action's text to bold text.
  //                             isDefaultAction: true,
  //                             onPressed: () {
  //                               Navigator.pop(context);
                            
  //                             },
  //                             child: const Text('Cancel'),
  //                           ),
  //                           CupertinoDialogAction(
  //                             /// This parameter indicates the action would perform
  //                             /// a destructive action such as deletion, and turns
  //                             /// the action's text color to red.
  //                             isDestructiveAction: true,
  //                             onPressed: () async {
  //                    SharedPreferencesClass.initializeSharedPref();
  // final prefs = SharedPreferencesClass.prefs;

  // // Store mpin temporarily
  // final savedMPin = prefs.getString('mpin');

  // await prefs.clear();

  // if (savedMPin != null) {
  //   await prefs.setString('mpin', savedMPin);
  // }

  // Navigator.pushAndRemoveUntil(
  //   context,
  //   MaterialPageRoute(builder: (_) => SplashScreen()),
  //   (route) => false,
  // );
                               
  //                             },
  //                             child: Container(
  //                               child: const Text('Logout')),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   },
  //                   child: Container(
  //                     height: 40,
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text(
  //                           "Logout",
  //                           style: Theme.of(context)
  //                               .textTheme
  //                               .headlineSmall!
  //                               .copyWith(fontSize: 16),
  //                         ),
  //                         Icon(
  //                           Icons.logout,
  //                           size: 20,
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => QrLogin()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Center(
                          child: Text("Link Device",
                              style: AppTextStyles.headline3
                                  .copyWith(fontSize: 16))),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        )));
  }
}
