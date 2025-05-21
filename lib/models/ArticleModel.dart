class ArticleModel {
  List<Data>? data;
  int? errorCode;
  String? errorDesc;

  ArticleModel({this.data, this.errorCode, this.errorDesc});

  ArticleModel.fromJson(Map<String, dynamic> json) {
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
  String? artCode;
  String? artNo;
  String? artName;
  String? artDesc;
  String? artImage;

  Data({this.artCode, this.artNo, this.artName, this.artDesc, this.artImage});

  Data.fromJson(Map<String, dynamic> json) {
    artCode = json['artCode'];
    artNo = json['artNo'];
    artName = json['artName'];
    artDesc = json['artDesc'];
    artImage = json['artImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artCode'] = this.artCode;
    data['artNo'] = this.artNo;
    data['artName'] = this.artName;
    data['artDesc'] = this.artDesc;
    data['artImage'] = this.artImage;
    return data;
  }
}
