import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urovo/models/PartyModel.dart';
import 'package:urovo/services/bill_service.dart';
import 'package:urovo/view/home/bills.dart';
import 'package:intl/intl.dart';

class SelectPartyScreen extends StatefulWidget {
  @override
  State<SelectPartyScreen> createState() => _SelectPartyScreenState();
}

class _SelectPartyScreenState extends State<SelectPartyScreen> {
  GetPartyNameModel? partyModel;
  LstPartyNames? selectedParty;
  DateTime? fromDate;
  DateTime? toDate;

  @override
  void initState() {
    super.initState();
    getPartyNameByGST();
  }

  void getPartyNameByGST() async {
    final service = ApiBillService();
    final result = await service.apiGetPartyNameByGST();
    if (result != null) {
      setState(() {
        partyModel = result;
      });
    }
  }

  Future<void> _selectDate(bool isFrom) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              surface: Colors.black,
              onSurface: Colors.white,
              primary: Colors.white,
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  Widget buildDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white30),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<LstPartyNames>(
          dropdownColor: Colors.grey.shade900,
          value: selectedParty,
          hint: Text("Select Party", style: TextStyle(color: Colors.white70)),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.white),
          items: partyModel!.lstPartyNames!.map((party) {
            return DropdownMenuItem(
              value: party,
              child: Text(party.partyName ?? "", style: TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              selectedParty = val;
            });
          },
        ),
      ),
    );
  }

Widget buildDateSelector(String label, DateTime? date, VoidCallback onTap) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white30),
    ),
    child: Row(
      children: [
        Icon(Icons.calendar_today, color: Colors.white, size: 18),
        SizedBox(width: 10),
        Text("$label:", style: TextStyle(color: Colors.white70, fontSize: 14)),
        Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Text(
            date == null
                ? "Select Date"
                : DateFormat("dd-MMM-yyyy").format(date),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        )
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text("Select Party",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: partyModel == null
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose Buyer",
                      style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 10),
                  buildDropdown(),
                  SizedBox(height: 20),
                  Text("Select Date Range",
                      style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 10),
                  buildDateSelector("From", fromDate, () => _selectDate(true)),
                  SizedBox(height: 10),
                  buildDateSelector("To", toDate, () => _selectDate(false)),
                  SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: selectedParty != null && fromDate != null && toDate != null
                          ? () {
                              Get.to(() => BillsPage(
                                    selectedParty: selectedParty!,
                                    fromDate: fromDate!,
                                    toDate: toDate!,
                                  ));
                            }
                          : null,
                      child: Text("Continue",
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
