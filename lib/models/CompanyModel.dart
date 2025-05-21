// To parse this JSON data, do
//
//     final companyModel = companyModelFromJson(jsonString);

import 'dart:convert';

CompanyModel companyModelFromJson(String str) => CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
    Data data;

    CompanyModel({
        required this.data,
    });

    factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
    };
}

class Data {
    List<Datum> data;
    int errorCode;
    String errorDesc;

    Data({
        required this.data,
        required this.errorCode,
        required this.errorDesc,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorCode: json["errorCode"],
        errorDesc: json["errorDesc"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errorCode": errorCode,
        "errorDesc": errorDesc,
    };
}

class Datum {
    int companyId;
    String companyName;
    String dbName;

    Datum({
        required this.companyId,
        required this.companyName,
        required this.dbName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        companyId: json["companyId"],
        companyName: json["companyName"],
        dbName: json["dbName"],
    );

    Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
        "dbName": dbName,
    };
}
