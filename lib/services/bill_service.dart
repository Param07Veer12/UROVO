import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:urovo/models/PartyModel.dart';
import 'package:urovo/view/home/upload_builty.dart';
import 'dart:convert';

import '../constant/app_constant.dart';
import '../models/BillsModel.dart';
import 'pref_service.dart';

class ApiBillService {
Future<List<BillsModel>> apiGetBillls(String fromDate, String toDate, String partyCode) async {
  List<BillsModel> response = [];
  var token = PreferenceUtils.getString("token");

  final url = Uri.parse(
    "${AppConstants.getBills}?FromDate=$fromDate&ToDate=$toDate&PartyCode=$partyCode",
  );

  final response2 = await http.get(url, headers: {
    "content-type": "application/json",
    'Authorization': 'Bearer $token',
  });

  if (kDebugMode) {
    print(response2.body);
  }

  if (response2.statusCode == 200) {
    var data2 = jsonDecode(response2.body);
    data2.forEach((v) {
      response.add(BillsModel.fromJson(v));
    });
  }

  return response;
}


    Future<GetPartyNameModel?> apiGetPartyNameByGST() async {
    var token = PreferenceUtils.getString("token");
    var ur = Uri.parse(AppConstants.getPartyNameByGST);
    final response2 = await http.get(ur, headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token',
    });
    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = GetPartyNameModel.fromJson(jsonDecode(response2.body));
      

        return data2;

      default:
        return null;
        break;
    }
  }

  Future<dynamic> uploadBuilty(String grNo,String grDate,String docNo,String docDate,File imageFile) async {
    var ur = Uri.parse(AppConstants.uploadBillty);
      var token = PreferenceUtils.getString("token");
        var request = http.MultipartRequest('POST', ur)
      ..headers['Authorization'] = 'Bearer $token'
      ..files.add(await http.MultipartFile.fromPath('FileUpload', imageFile.path));

request.fields.addAll({
  'GRNo': grNo,
  'GRDate': grDate,
  'DocNo': docNo,
  'DocDate': docDate
} as Map<String, String>);
    var response2 = await request.send();

   

    switch (response2.statusCode) {
      case 200:
      final responseData = await http.Response.fromStream(response2);
      final jsonResponse = json.decode(responseData.body);
        return jsonResponse;

      default:
        return response2;
    }
  }
}
