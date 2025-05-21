import 'package:urovo/models/pie_chart_model.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:urovo/constant/app_constant.dart';
import 'pref_service.dart';
class ApiDashboardService {
  Future<PiChartResponse?> apiGetDashboard(String index) async {
    PiChartResponse? response ;
    var token = PreferenceUtils.getString("token");
    var ur = Uri.parse(AppConstants.getDashboard  + index);
    final response2 = await http.get(ur, headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer ' + token,
    });
    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);
    
          response = PiChartResponse.fromJson(data2);

        return response ?? null;

      default:
        return response ?? null;
        break;
    }
  }
}