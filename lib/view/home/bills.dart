import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urovo/models/BillsModel.dart';
import 'package:urovo/models/PartyModel.dart';
import 'package:urovo/services/bill_service.dart';
import 'package:urovo/view/home/product_scan.dart';
import 'package:urovo/view/home/products.dart';
import '../../components/bottomsheet.dart';
import '../../constant/app_theme.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

import '../../controllers/bottombar_controller.dart';
import '../../services/pref_service.dart';
import 'bill_details.dart';
import 'vendor_details.dart';
import 'package:intl/intl.dart';

class BillsPage extends StatefulWidget {
  final LstPartyNames selectedParty;
  final DateTime fromDate;
  final DateTime toDate;

  BillsPage({
    Key? key,
    required this.selectedParty,
    required this.fromDate,
    required this.toDate,
  }) : super(key: key);

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  @override
  void initState() {
    super.initState();
       var token = PreferenceUtils.getString("firsttoken");
       print(token);
      //  getPartyNameByGST();
     getBills();
  }

  List<BillsModel>? billList;
   GetPartyNameModel? partyModel;

  List<BillsModel>? selectedList = [];
  String formatDate(DateTime date) {
  return DateFormat("dd-MMM-yyyy").format(date);
}
void getBills() async {
  final service = ApiBillService();
  final from = formatDate(widget.fromDate); // e.g. 01-Jan-2025
  final to = formatDate(widget.toDate);
  final partyCode = widget.selectedParty.code ?? "";

  final bills = await service.apiGetBillls(from, to, partyCode);
  if (bills.isNotEmpty) {
    setState(() {
      billList = bills;
    });
  }
}

  

    void getPartyNameByGST() async {
    final service = ApiBillService();
    service.apiGetPartyNameByGST().then((value) {
      if (value != null) {
        setState(() {
          partyModel = value;
        });
      }
      else
      {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: GestureDetector(
              onTap: () {
                BottomSheetClass.openShareButtomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (controller.selectedParty == '')
                    Text(
                      "Bills",
                      style: AppTextStyles.headline1.copyWith(fontSize: 14),
                    )
                  // else
                  //   Flexible(
                  //     child: Text(
                  //       "${Get.find<HomepageController>().selectedParty} ",
                  //       style: AppTextStyles.headline1.copyWith(fontSize: 14),
                  //     ),
                  //   ),
                  // Icon(
                  //   Icons.arrow_drop_down,
                  // )
                ],
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 20),
              )
            ],
          ),
          body: billList == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        if (selectedList!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              
                              Container(
                                margin: EdgeInsets.only(right: 10, bottom: 10),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.mail_rounded,
                                      color: AppTheme.whiteBackgroundColor,
                                      size: 20,
                                    ),
                                    Text(
                                      "  Send Mail",
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: AppTheme.whiteBackgroundColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ListView.builder(
                          itemCount: billList!.length,
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onLongPress: () {
                                if (selectedList!.contains(billList![index])) {
                                  selectedList!.remove(billList![index]);
                                } else {
                                  selectedList!.add(billList![index]);
                                }
                                setState(() {});
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             BillsDetailsPage()));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 12),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        selectedList!.contains(billList![index])
                                            ? Color.fromRGBO(50, 50, 50, 1)
                                            : Color.fromRGBO(22, 22, 22, 1)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .doc_chart_fill,
                                                    size: 14,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      " Invoice No: ${billList![index].bilLNO}",
                                                      style: AppTextStyles
                                                          .headline2
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  Text(
                                                    " ${billList![index].dated!.substring(0, 10)}",
                                                    style: AppTextStyles
                                                        .headline2
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.person_alt,
                                                    size: 12,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "  ${billList![index].customeRNAME}",
                                                      style: AppTextStyles
                                                          .headline1
                                                          .copyWith(
                                                              fontSize: 14),
                                                    ),
                                                  ),
                                                  if (selectedList!.contains(
                                                      billList![index]))
                                                    Icon(
                                                      Icons.check_circle,
                                                      size: 20,
                                                      color: Colors.green,
                                                    )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .device_phone_portrait,
                                                    size: 12,
                                                  ),
                                                  Text(
                                                    "  ${billList![index].contact}",
                                                    style: AppTextStyles
                                                        .headline1
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Total Amount",
                                              style: AppTextStyles.lable
                                                  .copyWith(fontSize: 12),
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              "Rs. ${billList![index].totaLBILLAMOUNT}",
                                              style: AppTextStyles.headline2
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              "${billList![index].totaLQTY}",
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