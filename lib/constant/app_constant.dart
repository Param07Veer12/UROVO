class AppConstants {
  static const String APP_NAME = 'QR Scan';
  static const double APP_VERSION = 1.0;
  static const String baseUrl = 'http://150.242.202.190:90';
  static const String login = baseUrl + '/Account/Login';
  static const String selectCompanyFinYear = baseUrl + '/Account/SelectCompanyFinYear';
  static const String webLogin = baseUrl + '/Account/WebLogin';
  static const String getFinancialYear = baseUrl + '/Account/GetFinanceYear';
  static const String getCompanyMst = baseUrl + '/Account/GetCompanyMst';
  static const String getBills = baseUrl + "/Bill/GetBills";
  static const String getBillty = baseUrl + "/api/Transaction/GetBuilty";
  static const String getDashboard= baseUrl + "/Dashboard/GetDashboard?DateRangeId=";

  static const String getArticle = baseUrl + "/api/Master/GetArticleImage";
  static const String uploadBillty = baseUrl + "/api/Transaction/PostBuilty";
    static const String uploadArticle= baseUrl + "/api/Master/PostArticleImage";

  static const String getPartyNameByGST = baseUrl + "/Bill/GetPartyNameByGST";
  //GetPartyNameByGST
}
