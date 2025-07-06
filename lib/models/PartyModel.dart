class GetPartyNameModel {
  List<LstPartyNames>? lstPartyNames;
  int? errorCode;
  String? errorDesc;

  GetPartyNameModel({this.lstPartyNames, this.errorCode, this.errorDesc});

  GetPartyNameModel.fromJson(Map<String, dynamic> json) {
    if (json['lstPartyNames'] != null) {
      lstPartyNames = <LstPartyNames>[];
      json['lstPartyNames'].forEach((v) {
        lstPartyNames!.add(new LstPartyNames.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorDesc = json['errorDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lstPartyNames != null) {
      data['lstPartyNames'] =
          this.lstPartyNames!.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorDesc'] = this.errorDesc;
    return data;
  }
}

class LstPartyNames {
  int? id;
  String? code;
  String? partyName;

  LstPartyNames({this.id, this.code, this.partyName});

  LstPartyNames.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    partyName = json['partyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['partyName'] = this.partyName;
    return data;
  }
}
