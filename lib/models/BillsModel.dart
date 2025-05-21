class BillsModel {
  BillsModel({
      this.bilLNO, 
      this.dated, 
      this.series, 
      this.type, 
      this.partYNAME, 
      this.accEmail, 
      this.bilLCITY, 
      this.deLCITY, 
      this.totaLQTY, 
      this.taxablEAMOUNT, 
      this.taXAMOUNT, 
      this.totaLBILLAMOUNT, 
      this.ewaYNO, 
      this.gRNO, 
      this.siminvoiceon, 
      this.transID, 
      this.acccode, 
      this.contact, 
      this.customeRNAME, 
      this.transporter, 
      this.transwebsite, 
      this.transmobile, 
      this.transcontact,});

  BillsModel.fromJson(dynamic json) {
    bilLNO = json['bilL_NO'].toString();
    dated = json['dated'];
    series = json['series'];
    type = json['type'];
    partYNAME = json['partY_NAME'];
    accEmail = json['accEmail'];
    bilLCITY = json['bilL_CITY'];
    deLCITY = json['deL_CITY'];
    totaLQTY = json['totaL_QTY'];
    taxablEAMOUNT = json['taxablE_AMOUNT'];
    taXAMOUNT = json['taX_AMOUNT'];
    totaLBILLAMOUNT = json['totaL_BILL_AMOUNT'].toString();
    ewaYNO = json['ewaY_NO'];
    gRNO = json['gR_NO'];
    siminvoiceon = json['siminvoiceon'];
    transID = json['transID'];
    acccode = json['acccode'];
    contact = json['contact'];
    customeRNAME = json['customeR_NAME'];
    transporter = json['transporter'];
    transwebsite = json['transwebsite'];
    transmobile = json['transmobile'];
    transcontact = json['transcontact'];
  }
  String? bilLNO;
  String? dated;
  String? series;
  String? type;
  String? partYNAME;
  String? accEmail;
  String? bilLCITY;
  dynamic deLCITY;
  int? totaLQTY;
  double? taxablEAMOUNT;
  double? taXAMOUNT;
  String? totaLBILLAMOUNT;
  String? ewaYNO;
  String? gRNO;
  String? siminvoiceon;
  int? transID;
  String? acccode;
  String? contact;
  String? customeRNAME;
  String? transporter;
  String? transwebsite;
  String? transmobile;
  String? transcontact;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bilL_NO'] = bilLNO;
    map['dated'] = dated;
    map['series'] = series;
    map['type'] = type;
    map['partY_NAME'] = partYNAME;
    map['accEmail'] = accEmail;
    map['bilL_CITY'] = bilLCITY;
    map['deL_CITY'] = deLCITY;
    map['totaL_QTY'] = totaLQTY;
    map['taxablE_AMOUNT'] = taxablEAMOUNT;
    map['taX_AMOUNT'] = taXAMOUNT;
    map['totaL_BILL_AMOUNT'] = totaLBILLAMOUNT;
    map['ewaY_NO'] = ewaYNO;
    map['gR_NO'] = gRNO;
    map['siminvoiceon'] = siminvoiceon;
    map['transID'] = transID;
    map['acccode'] = acccode;
    map['contact'] = contact;
    map['customeR_NAME'] = customeRNAME;
    map['transporter'] = transporter;
    map['transwebsite'] = transwebsite;
    map['transmobile'] = transmobile;
    map['transcontact'] = transcontact;
    return map;
  }

}