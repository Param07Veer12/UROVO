class PiChartResponse {
  final List<PiChartData>? piChat;
  final TotalSales? totalSales;
  final double receipt;
  final int errorCode;
  final String errorDesc;

  PiChartResponse({
    required this.piChat,
    required this.totalSales,
    required this.receipt,
    required this.errorCode,
    required this.errorDesc,
  });

  factory PiChartResponse.fromJson(Map<String, dynamic> json) {
    return PiChartResponse(
      piChat: (json['piChat'] as List?)
          ?.map((data) => PiChartData.fromJson(data))
          .toList(),
      totalSales: json['totalSales'] != null
          ? TotalSales.fromJson(json['totalSales'])
          : null,
      receipt: (json['receipt'] ?? 0).toDouble(),
      errorCode: json['errorCode'] ?? 0,
      errorDesc: json['errorDesc'] ?? '',
    );
  }
}


class PiChartData {
  final int salesCount;
  final String partyName;
  final String sumOfAmount; // Changed to String
  final double sumOfQty;
  final double salesPercent;

  PiChartData({
    required this.salesCount,
    required this.partyName,
    required this.sumOfAmount,
    required this.sumOfQty,
    required this.salesPercent,
  });

  // Factory constructor for parsing JSON
  factory PiChartData.fromJson(Map<String, dynamic> json) {
    return PiChartData(
      salesCount: json['salesCount'],
      partyName: json['partyName'],
      sumOfAmount: json['sumOfAmount'].toString(), // Convert to String
      sumOfQty: json['sumOfQty'],
      salesPercent: json['salesPercent'],
    );
  }
}

class TotalSales {
  final int salesCount;
  final String sumOfAmount;
  final String sumOfQty;

  TotalSales({
    required this.salesCount,
    required this.sumOfAmount,
    required this.sumOfQty,
  });

  // Factory constructor for parsing JSON
  factory TotalSales.fromJson(Map<String, dynamic> json) {
    return TotalSales(
      salesCount: json['salesCount'],
      sumOfAmount: json['sumOfAmount'].toString(),
      sumOfQty: json['sumOfQty'].toString(),
    );
  }
}
