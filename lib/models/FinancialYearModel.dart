// To parse this JSON data, do
//
//     final finacialYearModel = finacialYearModelFromJson(jsonString);

import 'dart:convert';

FinacialYearModel finacialYearModelFromJson(String str) => FinacialYearModel.fromJson(json.decode(str));

String finacialYearModelToJson(FinacialYearModel data) => json.encode(data.toJson());

class FinacialYearModel {
    Data data;

    FinacialYearModel({
        required this.data,
    });

    factory FinacialYearModel.fromJson(Map<String, dynamic> json) => FinacialYearModel(
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
    int transId;
    String fnYearCode;
    String fnStartDate;
    String fnEndDate;
    String isCurrentYear;

    Datum({
        required this.transId,
        required this.fnYearCode,
        required this.fnStartDate,
        required this.fnEndDate,
        required this.isCurrentYear,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        transId: json["transID"],
        fnYearCode: json["fnYearCode"],
        fnStartDate: json["fnStartDate"],
        fnEndDate: json["fnEndDate"],
        isCurrentYear: json["isCurrentYear"],
    );

    Map<String, dynamic> toJson() => {
        "transID": transId,
        "fnYearCode": fnYearCode,
        "fnStartDate": fnStartDate,
        "fnEndDate": fnEndDate,
        "isCurrentYear": isCurrentYear,
    };
}
