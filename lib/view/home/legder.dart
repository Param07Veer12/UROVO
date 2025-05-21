import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';

import '../../components/textfield.dart';
import '../../constant/app_theme.dart';

class Legder extends StatefulWidget {
  @override
  State<Legder> createState() => _nameState();
}

class _nameState extends State<Legder> {
  final statusid = TextEditingController();
  List getStatus = [];
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final _formKey = GlobalKey<FormState>();
  int id = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late ScrollController _scrollController;
  late ScrollController _scrollController2;
  @override
  void initState() {
    super.initState();
    _scrollController2 = ScrollController();
    _scrollController = ScrollController();
  }

  DateTimeRange? _selectedDateRange;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: _selectedDateRange,
    );

    if (picked != null && picked != _selectedDateRange) {
      setState(() {
        _selectedDateRange = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "Ledger",
          ),
          actions: [
            InkWell(
              onTap: () => _selectDateRange(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppTheme.hintTextColor.withOpacity(0.8))),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_outlined, size: 16,),
                    Text(
                      _selectedDateRange == null
                          ? '  Select Dates'
                          : '  ${_dateFormat.format(_selectedDateRange!.start)}-${_dateFormat.format(_selectedDateRange!.end)}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MyTextField(
                      //  textEditingController: password,
                      //   isSuffixIcon: true,
                      // obsecureText: !passwordLoginVisibility,
                      ontapSuffix: () {
                        // passwordLoginVisibility = !passwordLoginVisibility;
                        setState(() {});
                        // _controller.showPassword();
                      },
                      hintText: "Search",
                      icon: Icon(Icons.search),
                      color: const Color(0xff585A60)),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Scrollbar(
                      thumbVisibility: false,
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Scrollbar(
                          thumbVisibility: false,
                          controller: _scrollController2,
                          child: SingleChildScrollView(
                              controller: _scrollController2,
                              //   scrollDirection: Axis.horizontal,
                              child: DataTable(
                                headingRowColor: MaterialStateProperty.all(
                                    Color.fromRGBO(43, 43, 43, 1)),
                                columnSpacing: 40,
                                headingRowHeight: 40,
                                headingTextStyle: GoogleFonts.inter(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Color.fromRGBO(43, 43, 43, 1),
                                      width: 1,
                                    ),
                                    left: BorderSide(
                                      color: Color.fromRGBO(43, 43, 43, 1),
                                      width: 1,
                                    ),
                                    bottom: BorderSide(
                                      color: Color.fromRGBO(43, 43, 43, 1),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'DATE',
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'PARTICULARS',
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'VOUCHER TYPE',
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'VOUCHER NO',
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'DEBIT',
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'CREDIT',
                                      ),
                                    ),
                                  ),
                                ],
                                rows: List<DataRow>.generate(
                                  2,
                                  (int index) => DataRow(
                                    cells: <DataCell>[
                                      DataCell(
                                        Center(
                                          child: Text('02-07-2024	'),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text('GST Purchases'),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text('Purchase'),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text('033'),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            index % 2 == 0 ? '100' : "0",
                                            style: TextStyle(
                                                color: index % 2 == 0
                                                    ? Colors.red
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Center(
                                          child: Text(
                                            index % 2 != 0 ? '500' : "0",
                                            style: TextStyle(
                                                color: index % 2 != 0
                                                    ? Colors.green
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      )),
                )
              ],
            )));
  }
}
