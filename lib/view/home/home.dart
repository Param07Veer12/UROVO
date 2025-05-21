import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urovo/models/pie_chart_model.dart';
import 'package:urovo/services/builty_service.dart';
import 'package:urovo/services/dashboard_service.dart';
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
chartData = convertToChartData(pieModel!.piChat);
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
String selectedOption = "Today";
int selectedOptionIndex = 1;

double heightView = 1500.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Dashboard",
            style: AppTextStyles.headline1,
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
              var piChat = pieModel!.piChat[index];
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
                            piChat.partyName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Sales Count: ${piChat.salesCount}"),
                          Text("Sum of Amount: ${piChat.sumOfAmount}"),
                          Text("Sum of Qty: ${piChat.sumOfQty}"),
                          Text("Sales Percent: ${piChat.salesPercent.toStringAsFixed(2)}%"),
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
      pieModel!.totalSales!.salesCount.toString(),
      CupertinoIcons.chart_bar_fill,
    ),
    buildCard(
      "Sum of Amount",
      pieModel!.totalSales!.sumOfAmount.toString(),
      CupertinoIcons.money_dollar_circle,
    ),
    buildCard(
      "Sum of Quantity",
      pieModel!.totalSales!.sumOfQty.toString(),
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
