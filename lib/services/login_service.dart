import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:urovo/models/FinancialYearModel.dart';
import 'dart:convert';

import '../constant/app_constant.dart';
import 'pref_service.dart';

class ApiLoginPasswordService {
  List loginResponse = [];
  Future<List> ApiLoginService(String? username, String? password, String? dbName, String? financeCode) async {
    var ur = Uri.parse(AppConstants.login);
    final response2 = await http.post(ur,
        body: jsonEncode({"userName": username, "userPassword": password,  "dbName": dbName,
  "finCode": financeCode,
}),
        headers: {
          "content-type": "application/json",
        });
    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);
        loginResponse.add(data2);
        return loginResponse;
        break;

      default:
        return loginResponse;
        break;
    }
  }

  Future<dynamic> selectCompanyFinYear(int? companyId,String? dbName,String? fnYearCode) async {
    var ur = Uri.parse(AppConstants.selectCompanyFinYear);
      var token = PreferenceUtils.getString("firsttoken");
    final response2 =
        await http.post(ur, body: jsonEncode({"companyId": companyId,"dbName": dbName,"fnYearCode": fnYearCode}), headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token',
    });
    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);
        return data2;

      default:
        return response2;
    }
  }
  Future<dynamic> apiQrLogin(String? code) async {
    var ur = Uri.parse(AppConstants.webLogin);
      var token = PreferenceUtils.getString("token");
    final response2 =
        await http.post(ur, body: jsonEncode({"qrCode": code}), headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token',
    });
    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);
        return data2;

      default:
        return response2;
    }
  }
   Future<dynamic> getFinancialYearAPI() async {
    
    var ur = Uri.parse(AppConstants.getFinancialYear);
      var token = PreferenceUtils.getString("firsttoken");
    final response2 =
        await http.get(ur, headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);

        
        return data2;

      default:
        return response2;
    }
  }

     Future<dynamic> getCompanyAPI() async {
    
    var ur = Uri.parse(AppConstants.getCompanyMst);
      var token = PreferenceUtils.getString("firsttoken");
    final response2 =
        await http.get(ur, headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);

        
        return data2;

      default:
        return response2;
    }
  }
    Future<dynamic> getRandomQuote() async {
    
    var ur = Uri.parse("https://zenquotes.io/api/random");
      var token = PreferenceUtils.getString("token");
    final response2 =
        await http.get(ur, headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer $token',
    });

    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);

        
        return data2;

      default:
        return response2;
    }
  }
}

   


 

// {
//   "code": 1,
//   "msg": "Login Failed",
//   "token": ""
// }	
// Response body
// Download
// {
//   "code": 0,
//   "msg": "Success",
//   "userName": "admin",
//   "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY4YWViNGIwLWRkYmMtNDM1NS05Y2Q1LThiYWJjMDc2MDY2ZCIsIm5hbWUiOiJhZG1pbiIsImVtYWlsIjoiMSIsIm5iZiI6MTcyMTQ3NDkxOCwiZXhwIjoxNzI0MDY2OTE4LCJpYXQiOjE3MjE0NzQ5MTgsImlzcyI6Imh0dHBzOi8vd2ViLm1hLWVycC5jb20vIiwiYXVkIjoiaHR0cHM6Ly93ZWIubWEtZXJwLmNvbS8ifQ.lEV9qaBBhdsw29FuCNuNFubJxnjOnDedTO3wZIGHgyjjA50bYAZIfzQpCUQVqcQCOT1OFiD2UXCgplZPseAWIg"
// }