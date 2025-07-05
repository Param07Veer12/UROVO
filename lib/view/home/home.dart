import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urovo/components/dropdown.dart';
import 'package:urovo/models/CompanyModel.dart';
import 'package:urovo/models/FinancialYearModel.dart';
import 'package:urovo/models/pie_chart_model.dart';
import 'package:urovo/services/builty_service.dart';
import 'package:urovo/services/dashboard_service.dart';
import 'package:urovo/services/login_service.dart';
import 'package:urovo/services/shared_preferences_class.dart';
import 'package:urovo/view/home/bottombar.dart';
import 'package:urovo/view/home/product_scan.dart';
import '../../constant/app_theme.dart';
import 'dart:math';
import '../../services/pref_service.dart';

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    PiChartResponse? pieModel  = null;
  @override
  void initState() {
    _getArticleAPI("1");
    // TODO: implement initState
    super.initState();
  }
  bool isLoading = false;
late List<ChartData> chartData ;
   void _getArticleAPI(String value) {
      setState(() {
      isLoading = true; // Start the loader
    });
                  

      final service = ApiDashboardService();
      service.apiGetDashboard(value)
          .then((value) {
        if (value != null) {

      pieModel = value;
chartData = convertToChartData(pieModel?.piChat ?? []);
legendHeight = chartData.length * singleLegendItemHeight;
heightView = (125 * chartData.length).toDouble() + 250;


                 setState(() {
                         isLoading = false; 
                 });

        } else {
             setState(() {
                         isLoading = false; 
                 });

          Fluttertoast.showToast(
              msg: "No Article Found",
              backgroundColor: Colors.red,
              gravity: ToastGravity.CENTER,
              textColor: Colors.white);
        }
      });
     
   
  }
  // Conversion of PiChartData into ChartData
List<ChartData> convertToChartData(List<PiChartData> piChartDataList) {
  return piChartDataList.map((piData) {
    return ChartData(
      piData.partyName, // x (label)
      piData.salesPercent, 
      _getRandomColor()// y (value)
    );
  }).toList();
}
    final double singleLegendItemHeight = 20; // Approximate height of a single legend item
    late double legendHeight;
// Example usage


  Color _getRandomColor() {

  final Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256), // Red component (0-255)
    random.nextInt(256), // Green component (0-255)
    random.nextInt(256), // Blue component (0-255)
    1.0,                 // Fully opaque (alpha value)
  );
}
Widget _buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.black, // Set dark background
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
       DrawerHeader(
  decoration: BoxDecoration(
    color: Colors.black,
  ),
  child: FutureBuilder(
    future: SharedPreferences.getInstance(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return CircularProgressIndicator();
      }
      final prefs = snapshot.data as SharedPreferences;
      final companyName = prefs.getString('companyName') ?? 'No Company';
      final financialYear = prefs.getString('financialYear') ?? 'No Year';

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   height: 50,
            //   width: 50,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/Logo1.ico'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            SizedBox(height: 8),
            // Text('Welcome!', style: TextStyle(color: Colors.white, fontSize: 18)),
            // Text('To Creativeline', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 12),
            Text('$companyName', style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),

            Text('Financial Year: $financialYear', style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    },
  ),
),

        ListTile(
          leading: Icon(Icons.sync_alt, color: Colors.white),
          title: Text('Change Company / Year', style: TextStyle(color: Colors.white)),
          onTap: () {
            Navigator.pop(context);
              showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(50)),
                width: 50,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CupertinoActivityIndicator(
                      color: AppTheme.primaryColor, radius: 14),
                ),
              ),
            ],
          );
        },
      );
            _getCompanyMst();
            // TODO: Show your company/year selection popup
          },
        ),
     
      ],
    ),
  );
}
      String companyValue = "Choose Company";
            int companyId = 0;

    List<String> companyValueList = ["Choose Company"];
        List<int> companyIdList = [0];

     List<String> dbNameValueList = ["Choose Company"];

      String financialYearValue = "Choose Finacial Year";
    List<String> financialYearValueList = ["Choose Finacial Year"];
    var dbName = "";


     void _getCompanyMst() {
           SharedPreferencesClass.initializeSharedPref();

      final service = ApiLoginPasswordService();
      service.getCompanyAPI()
          .then((value) {
       
        if (value.isNotEmpty) {
                var companyValueModel = CompanyModel.fromJson((value));

          if (companyValueModel.data.errorCode == 0) {

      
      companyValueList.clear();
      dbNameValueList.clear();
      companyIdList.clear();
      companyValueList.add("Choose Company");
      dbNameValueList.add("Choose Company");
        companyIdList.add(0);
for (var companyModel in companyValueModel!.data!.data) {
  companyValueList.add(companyModel.companyName);
  dbNameValueList.add(companyModel.dbName);
  companyIdList.add(companyModel.companyId);
}
companyValue = companyValueModel.data.data[0].companyName;
companyId = companyValueModel.data.data[0].companyId;
dbName= companyValueModel.data.data[0].dbName;
 _getFinanceYear();


          } else {
                    Navigator.pop(context);

            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
                  Navigator.pop(context);

          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      });
     
   
  }

     Future<void> _getFinanceYear() async {
               SharedPreferences prefs = await SharedPreferences.getInstance();

      final service = ApiLoginPasswordService();
      service.getFinancialYearAPI()
          .then((value) {
        if (value.isNotEmpty) {
                var financialModel = FinacialYearModel.fromJson((value));

          if (financialModel.data!.errorCode == 0) {
            financialYearValueList.clear();
          financialYearValueList.add("Choose Finacial Year");
for (var financialModel in financialModel!.data!.data) {
  financialYearValueList.add(financialModel.fnYearCode);
   if (financialModel.isCurrentYear == "Y")
   {
     financialYearValue = financialModel.fnYearCode;
     
   }

}
setState(() {
});

showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) {
    String selectedCompany = companyValue;
    String selectedFinancialYear = financialYearValue;

    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Text("Select Company & Financial Year", style: AppTextStyles.lable),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Company Name", style: AppTextStyles.lable),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: dropDownWidget(
                  initialValue: selectedCompany,
                  dropDownValueList: companyValueList,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCompany = newValue!;
                      dbName = dbNameValueList[companyValueList.indexOf(newValue)];
                      companyId = companyIdList[companyValueList.indexOf(newValue)];
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Text("Financial Year", style: AppTextStyles.lable),
              const SizedBox(height: 8),
              Container(
                                padding: EdgeInsets.only(bottom: 10),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: dropDownWidget(
                  initialValue: selectedFinancialYear,
                  dropDownValueList: financialYearValueList,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFinancialYear = newValue!;
                      financialYearValue = newValue;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
             TextButton(
            child: Text("Cancel", style: TextStyle(color: AppTheme.primaryColor)),
            onPressed: () async {
              Navigator.pop(context); // Close dialog

              Navigator.pop(context); // Close dialog

           
            },
          ),
       TextButton(
  child: Text("Submit", style: TextStyle(color: AppTheme.primaryColor)),
  onPressed: () async {

    final service = ApiLoginPasswordService();
    service.selectCompanyFinYear(companyId, dbName, selectedFinancialYear)
        .then((value) async {
      if (value.isNotEmpty) {
        if (value["code"] == 0) {
          // Save token
          prefs.setString("token", value["token"].toString());
          prefs.setString("companyName", selectedCompany);
          prefs.setString("financialYear", selectedFinancialYear);
          prefs.setString("companyId", companyId.toString());

          // Close the dialog first
          Navigator.pop(context);
          Navigator.pop(context);
          // Refresh the dashboard
          _getArticleAPI(selectedOptionIndex.toString());
        } else {
          Fluttertoast.showToast(
            msg: "Invalid Credentials",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Invalid Credentials",
          backgroundColor: Colors.red,
          gravity: ToastGravity.TOP,
          textColor: Colors.white,
        );
      }
    }).catchError((error) {
      // Optional: Handle exceptions like network failure
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red,
        gravity: ToastGravity.TOP,
        textColor: Colors.white,
      );
    });
  },
)

        ],
      );
    });
  },
);

          } else {
                    Navigator.pop(context);

            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
                  Navigator.pop(context);

          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      });
     
   
  }

String selectedOption = "Today";
int selectedOptionIndex = 1;

double heightView = 1500.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Dashboard",
            // style: AppTextStyles.headline1,
          ),
              actions: [
          DropdownButtonHideUnderline(
            
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: DropdownButton<String>(
                value: selectedOption,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedOption = newValue;
                      selectedOptionIndex =  ["Today", "Weekly", "Monthly", "Financial Year"].indexOf(selectedOption) + 1;
                      _getArticleAPI(selectedOptionIndex.toString());
                    });
                  }
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
                dropdownColor: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                items: ["Today", "Weekly", "Monthly", "Financial Year"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(

                    value: value,
                    child: Text(value,style: const TextStyle(color: Colors.white),),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (BuildContext context) => ProductScan()));
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(CupertinoIcons.barcode_viewfinder),
          //     ),
          //   )
          // ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loader when loading
            :  pieModel != null ? SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          //          SizedBox(
          //   height: 300,
          //   child:PieChart(
          //     PieChartData(
          //       sections: pieModel!.piChat.map((data) {
          //         return PieChartSectionData(
          //           value: data.salesPercent,
          //           title: '${data.salesPercent}%',
          //           color: _getRandomColor(),
          //           radius: data.salesPercent,
          //           titleStyle: const TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         );
          //       }).toList(),
          //       sectionsSpace: 4,
          //       centerSpaceRadius: 40,
          //     ),
          //   ),
          // ),
                // ListView.builder(
                //   shrinkWrap: true,
                //   itemCount: pieModel!.piChat.length,
                //   itemBuilder: (context, index) {
                //     final item = pieModel!.piChat[index];
                //     return Card(
                //       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //       child: ListTile(
                //         title: Text(item.partyName),
                //         subtitle: Text(
                //             'Sales Count: ${item.salesCount}\nSum of Amount: ₹${item.sumOfAmount}\nSum of Qty: ${item.sumOfQty}\nSales Percent: ${item.salesPercent}%'),
                //       ),
                //     );
                //   },
                // ),
    //     ),
    
            Container(
               height: heightView,
              child: chartData.length == 0 ?  Center(child: Text("No data available",style: TextStyle(fontSize: 17),))  :  SfCircularChart(
             legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  height: '100%',
                // Set dynamic height
                  overflowMode: LegendItemOverflowMode.wrap, 
                    legendItemBuilder: (String name, dynamic series, dynamic point, int index) {
              var piChat = pieModel!.piChat?[index];
                            final ChartData data = chartData[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: data.color, size: 12),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            piChat?.partyName ?? "",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Sales Count: ${piChat?.salesCount}"),
                          Text("Sum of Amount: ${piChat?.sumOfAmount}"),
                          Text("Sum of Qty: ${piChat?.sumOfQty}"),
                          Text("Sales Percent: ${piChat?.salesPercent.toStringAsFixed(2)}%"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }// Handles overflow if needed
                ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    // Render pie chart \\

                    PieSeries<ChartData, String>(
                    
                     dataSource: chartData,
                      name: "Sales",
                      enableTooltip: true,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                      ),
                      xValueMapper: (ChartData data, _) => data.x,
                      
                      yValueMapper: (ChartData data, _) => data.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                        dataLabelMapper: (ChartData data, _) =>
                        '${data.y.toStringAsFixed(2)}%',
                        

                        )
                 ]),
           ),

            SizedBox(
              height: 20,
            ),
            GridView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 1.05,
                    mainAxisSpacing: 22,
                    crossAxisSpacing: 22),
                children: [
 buildCard(
  "Sales Count",
  pieModel?.totalSales?.salesCount.toString() ?? '0',
  CupertinoIcons.chart_bar_fill,
),
buildCard(
  "Sum of Amount",
  pieModel?.totalSales?.sumOfAmount ?? '0',
  CupertinoIcons.money_dollar_circle,
),
buildCard(
  "Sum of Quantity",
  pieModel?.totalSales?.sumOfQty ?? '0',
  CupertinoIcons.cube_box_fill,
),

    buildCard(
      "Receipt",
      pieModel!.receipt.toString(),
      CupertinoIcons.doc_plaintext,
    ),                ])
          ]),
        ))
        
        
         : Center(child: Text("No data to show.")) );
  }

  buildCard(String title, String count, IconData icon) {
    return GestureDetector(
      onTap: () {
        // if (title == "Collected")
        //   return;
        // else
        //   Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => JobStatusList(
        //             status: title,
        //           )));
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(139, 151, 151, 155).withOpacity(0.1),
                  offset: Offset(1, 1),
                  blurRadius: 2.0,
                  spreadRadius: 1),
            ],
            borderRadius: BorderRadius.circular(12),
            color: Color.fromRGBO(22, 22, 22, 1)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    count.toString(),
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.whiteBackgroundColor),
                  ),
                  Spacer(),
                  Icon(
                    icon,
                    color: AppTheme.lightHintTextColor,
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Flexible(
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.whiteTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
