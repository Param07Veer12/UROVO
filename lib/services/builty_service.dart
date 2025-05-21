import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:urovo/models/ArticleModel.dart';
import 'package:urovo/models/BuiltyModel.dart';
import 'dart:convert';

import '../constant/app_constant.dart';
import '../models/BillsModel.dart';
import 'pref_service.dart';

class ApiBuiltyService {
  Future<BuiltyModel> apiGetBillls() async {
    BuiltyModel? response ;
    var token = PreferenceUtils.getString("token");
    var ur = Uri.parse(AppConstants.getBillty );
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
    
          response = BuiltyModel.fromJson(data2);

        return response ?? BuiltyModel();

      default:
        return response ?? BuiltyModel();
        break;
    }
  }
}

class ApiArticleService {
  Future<ArticleModel?> apiArticleData(String articalNo) async {
    ArticleModel? response ;
    var token = PreferenceUtils.getString("token");
    var mainUrl = AppConstants.getArticle + "?ArtNo=" + articalNo;
    var ur = Uri.parse(mainUrl);
    final response2 = await http.post(ur, headers: {
      "content-type": "application/json",
      'Authorization': 'Bearer ' + token,
    });
    if (kDebugMode) {
      print(response2.body);
    }

    switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);

       if (data2["errorCode"] == 0)
       {
         if (data2["data"].length != 0)
         {
          response = ArticleModel.fromJson(data2);

         }


       }
    

        return response ?? null;

      default:
        return response ?? null;
        break;
    }
  }

  Future<dynamic> uploadArticleData(String artNo,String artName,String imageStr) async {
    var url = AppConstants.uploadArticle ;
    print(url);
     print(imageStr);
    var ur = Uri.parse(url );
   
        var token = PreferenceUtils.getString("token");
  var body = {"artNo": artNo, "artName": artName,  "imageStr": imageStr,
 
};
print(body);
     final response2 = await http.post(ur,
        body: jsonEncode(body),
       
        headers: {
          "content-type": "application/json",
                'Authorization': 'Bearer ' + token,

        });
    if (kDebugMode) {
      print(response2.body);
    }

   

   switch (response2.statusCode) {
      case 200:
        var data2 = jsonDecode(response2.body);
        return data2;
        break;

      default:
        return {};
        break;
    }
  }
}
