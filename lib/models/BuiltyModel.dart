class BuiltyModel {
  List<Data>? data;
  int? errorCode;
  String? errorDesc;

  BuiltyModel({this.data, this.errorCode, this.errorDesc});

  BuiltyModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorDesc'] = this.errorDesc;
    return data;
  }
}

class Data {
  int? simNo;
  String? simSeries;
  String? simDate;
  String? simGRDate;
  String? simGRNo;

  Data(
      {this.simNo, this.simSeries, this.simDate, this.simGRDate, this.simGRNo});

  Data.fromJson(Map<String, dynamic> json) {
    simNo = json['simNo'];
    simSeries = json['simSeries'];
    simDate = json['simDate'];
    simGRDate = json['simGRDate'];
    simGRNo = json['simGRNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['simNo'] = this.simNo;
    data['simSeries'] = this.simSeries;
    data['simDate'] = this.simDate;
    data['simGRDate'] = this.simGRDate;
    data['simGRNo'] = this.simGRNo;
    return data;
  }
}
