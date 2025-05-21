import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:urovo/constant/app_constant.dart';
import 'pref_service.dart';

class CommonService {
  final String noInternetMessage =
      'Connection to API server failed due to internet connection';
  Future<Response> apiGetBuyers() async {
    var ur = Uri.parse(AppConstants.getPartyNameByGST);
    var token = PreferenceUtils.getString("token");
    try {
      final response2 = await http.get(ur, headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer $token',
      });
      if (kDebugMode) {
        print(response2.body);
      }
      return Response(
          statusCode: response2.statusCode,
          data: response2.body,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    } on SocketException catch (e) {
      return Response(
          statusCode: 1,
          statusMessage: noInternetMessage,
          requestOptions: RequestOptions(
            method: 'POST',
          ));
    }
  }

 }