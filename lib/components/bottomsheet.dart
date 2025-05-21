import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../constant/app_theme.dart';
import '../controllers/bottombar_controller.dart';

class BottomSheetClass {
  static void openShareButtomSheet() {
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      GetBuilder<HomepageController>(builder: (_controller) {
        return DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.85,
            maxChildSize: 0.96,
            builder: (_, controller) {
              return Container(
                  decoration: BoxDecoration(
                    color: Get.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: DefaultTabController(
                    length: 2,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            if (_controller.isLoaded)
                              Expanded(
                                child: TabContent(
                                  data: _controller.buyerList,
                                ),
                              )
                            else
                              CupertinoActivityIndicator(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
            });
      }),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
    );
  }
}

class TabContent extends StatelessWidget {
  final List data;
  var ontap;
  TabContent({required this.data, this.ontap});

  @override
  Widget build(BuildContext context) {
    return data.isNotEmpty
        ? ListView.builder(
            //controller: controller,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.find<HomepageController>()
                        .selectBuyer(data[index]["code"],data[index]["partyName"]);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data[index]["code"]}",
                              style: AppTextStyles.headline2
                                  .copyWith(fontSize: 16),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${data[index]["partyName"]}",
                                  style: AppTextStyles.lable
                                      .copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (Get.find<HomepageController>().selectedCode ==
                          data[index]["code"])
                        Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          size: 22,
                          color: AppTheme.primaryColor,
                        )
                      else
                        Icon(
                          CupertinoIcons.circle,
                          size: 22,
                          color: AppTheme.hintTextColor,
                        ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(child: Text("No Buyers found"));
  }
}
