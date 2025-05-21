import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../services/common_service.dart';

class HomepageController extends GetxController {
  var tabIndex = 0;
  final parameters = Get.parameters;
  void changeTabIndex(int index) {
    tabIndex = index;
    debugPrint(index.toString());

    update();
  }

  var vendorDetails;
  final searchController = TextEditingController();
  FocusNode focus = FocusNode();
  @override
  void onInit() {
    if (parameters.isNotEmpty) {
      tabIndex = int.parse(parameters["pageIndex"].toString());
      update();
    }
    getBuyers();
    // final rawJson = PreferenceUtils.getString('vendorProfile') ?? '';
    // //vendorId

    // if (rawJson != '') {
    //   final res = json.decode(rawJson);
    //   vendorDetails = res;

    //   update();
    //   getEvents();
    // }
    // if (PreferenceUtils.getString('eventId') == "" ||
    //     PreferenceUtils.getString('eventId') == null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     BottomSheetClass.openShareButtomSheet();
    //   });
    // }
    // else{
    //   getCheckGuestList();
    // }
    //   res["vendorId"].toString();
    //
    // } else {
    //   getvendorList();
    //   Get.to(SelectProfilePage());
    // }

    super.onInit();
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

          update();
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

          update();
          break;
      }
    });
  }

  selectBuyer(code,name) {
    selectedCode = code;
    selectedParty=name;
    update();
    Get.back();
  }
}
