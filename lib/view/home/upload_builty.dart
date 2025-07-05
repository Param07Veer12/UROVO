import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:urovo/models/BuiltyModel.dart';
import 'package:urovo/services/bill_service.dart';
import 'package:urovo/services/builty_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../components/textfield.dart';
import '../../constant/app_theme.dart';


class UploadBuilty extends StatefulWidget {
  @override
  State<UploadBuilty> createState() => _nameState();
}

class _nameState extends State<UploadBuilty> {
    String? _scannedSerialNumber;
  final MobileScannerController _scannerController = MobileScannerController();

  final statusid = TextEditingController();
  List getStatus = [];
   File? imageFile;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final _formKey = GlobalKey<FormState>();
  int id = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  late ScrollController _scrollController;
  late ScrollController _scrollController2;
   List<TextEditingController> _builtyNumberController = <TextEditingController>[];
   List<TextEditingController> _builtyDateController = <TextEditingController>[];

   BuiltyModel? _builtyModel;
  @override
  void initState() {
    super.initState();

    _scrollController2 = ScrollController();
    _scrollController = ScrollController();
    _getBuiltyAPI();
  }

  bool isLoading = false;

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
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }
  
    Widget textField(
      {required TextEditingController controller,
      required bool isReadonly,
      void Function(String)? onChanged,
      required List<TextInputFormatter> inputFormatters,
      TextInputType? keyboardType,
      Color? color,
      void Function()? onTap,
      Key? key,
      FocusNode? focusNode}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Column(
        children: [
          // Align(alignment: Alignment.centerLeft, child: Text(titleText)),
          TextFormField(
            key: key,
            focusNode: focusNode,
            cursorColor: Colors.black,
            textInputAction: TextInputAction.done,
            // keyboardType: const TextInputType.numberWithOptions(signed: true),
            inputFormatters: inputFormatters,
            readOnly: isReadonly,
            controller: controller,
            keyboardType: keyboardType,
              style: TextStyle(color: Colors.black),

            decoration: InputDecoration(
                isDense: true,
                hintText: '',
                
                fillColor: const Color.fromARGB(255, 228, 227, 227),
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(
                  13,
                  8,
                  8,
                  8,
                ),
                focusedBorder: buildOutlineInputBorder(),
                disabledBorder: buildOutlineInputBorder(),
                enabledBorder: buildOutlineInputBorder(),
                errorBorder: buildOutlineInputBorder(),
                focusedErrorBorder: buildOutlineInputBorder(),
                border: buildOutlineInputBorder()),
            onChanged: onChanged,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
  OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.circular(10));
}
     


   void _getBuiltyAPI() {
      setState(() {
      isLoading = true; // Start the loader
    });
                      _builtyNumberController.clear();
                 _builtyDateController.clear();
                 _pickedImages.clear();

      final service = ApiBuiltyService();
      service.apiGetBillls()
          .then((value) {
        if (value != null) {
                 _builtyModel = value;
                 for ( int i = 0 ; i < _builtyModel!.data!.length ; i++)
                 {
                _builtyNumberController.add(TextEditingController());
                _builtyDateController.add(TextEditingController());
                _pickedImages.add(null);
                _builtyNumberController[i].text = _builtyModel!.data![i].simGRNo!;
                _builtyDateController[i].text = _builtyModel!.data![i].simGRDate!;

                 }
                 
                 setState(() {
                         isLoading = false; // Start the loader

                 });

        } else {
          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.CENTER,
              textColor: Colors.white);
        }
      });
     
   
  }
  List <File?> _pickedImages = <File?> [];
  Future<void> _pickAndCropImageGallery(int index) async {
     Navigator.pop(context);
    // Pick an image
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Crop the image
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
      
      );

      if (croppedFile != null) {
        setState(() {
          _pickedImages[index] = File(croppedFile.path);
        });
      }
    }
  }
    Future<void> _pickAndCropImageCamera(int index) async {
      Navigator.pop(context);
    // Pick an image
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Crop the image
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
      
      );

      if (croppedFile != null) {
        setState(() {
          _pickedImages[index] = File(croppedFile.path);
        });
      }
    }
  }
  DateTime selectedDate = DateTime.now();

   Future<void> _selectDate(
      {required BuildContext context, required int index}) async {
    final DateTime? picked = await showDatePicker(
        context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2100,1));
    if (picked != null) {
      selectedDate = picked;
   

      _builtyDateController[index].text =
          "${selectedDate.day.toString().padLeft(2, "0")}-${DateFormat("MMM").format(selectedDate)}-${selectedDate.year}";
      setState(() {});
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
            "Builty",
          ),
          // actions: [
          //   InkWell(
          //     onTap: () => _selectDateRange(context),
          //     child: Container(
          //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(8),
          //           border: Border.all(
          //               color: AppTheme.hintTextColor.withOpacity(0.8))),
          //       child: Row(
          //         children: [
          //           Icon(Icons.calendar_month_outlined, size: 16,),
          //           Text(
          //             _selectedDateRange == null
          //                 ? '  Select Dates'
          //                 : '  ${_dateFormat.format(_selectedDateRange!.start)}-${_dateFormat.format(_selectedDateRange!.end)}',
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loader when loading
            :  _builtyModel != null ? _builtyModel!.data!.length == 0 ?  Center(child : Text("No data to show"))  : SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   child: MyTextField(
                //       //  textEditingController: password,
                //       //   isSuffixIcon: true,
                //       // obsecureText: !passwordLoginVisibility,
                //       ontapSuffix: () {
                //         // passwordLoginVisibility = !passwordLoginVisibility;
                //         setState(() {});
                //         // _controller.showPassword();
                //       },
                //       hintText: "Search",
                //       icon: Icon(Icons.search),
                //       color: const Color(0xff585A60)),
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                    'Inv.No.',
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Invoice Date',
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Builty Number',
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    'Builty Date',
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    '',
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text(
                                    '',
                                  ),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                              _builtyModel!.data!.length,
                              (int index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Center(
                                      child: Text(_builtyModel!.data![index].simNo.toString()),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child: Text(_builtyModel!.data![index].simDate!),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      
                                      child:    TextFormField(
            cursorColor: Colors.black,
            textInputAction: TextInputAction.done,
               decoration: InputDecoration(
                    // labelText: 'Product Barcode',
    isDense: true,
                hintText: '',
                
                fillColor: const Color.fromARGB(255, 228, 227, 227),
                filled: true,
                contentPadding: const EdgeInsets.fromLTRB(
                  13,
                  8,
                  8,
                  8,
                ),
                focusedBorder: buildOutlineInputBorder(),
                disabledBorder: buildOutlineInputBorder(),
                enabledBorder: buildOutlineInputBorder(),
                errorBorder: buildOutlineInputBorder(),
                focusedErrorBorder: buildOutlineInputBorder(),
                border: buildOutlineInputBorder(),
                      suffixIcon:
                 IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    color: Colors.black,
                    tooltip: 'Scan Bar Code',
                    onPressed: () async {

String? res = await SimpleBarcodeScanner.scanBarcode(
                  context,
                  barcodeAppBar: const BarcodeAppBar(
                    appBarTitle: 'Scan',
                    centerTitle: false,
                    enableBackButton: true,
                    backButtonIcon: Icon(Icons.arrow_back_ios),
                  ),
                  isShowFlashIcon: true,
                  delayMillis: 2000,
                  cameraFace: CameraFace.back,
                );
                setState(() {
                  if (res != "-1")
                  {
                   _builtyNumberController[index].text = res as String;
                  }
                 

                });
              },
                  )
                  ),
            // keyboardType: const TextInputType.numberWithOptions(signed: true),
            readOnly: false,
            controller: _builtyNumberController[index],
              style: TextStyle(color: Colors.black),

          
            // onChanged: onChanged,
            // onTap: onTap,
          ),
                                      
                          //              textField(
                          // controller: _builtyNumberController[index],
                          // isReadonly: false,
                          // color: Color.fromRGBO(43, 43, 43, 1),
                          // inputFormatters: []),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child:  textField(
                          controller: _builtyDateController[index],
                          isReadonly: true,
                          onTap: () {
_selectDate(context: context,index: index);
                          },
                          color: Color.fromRGBO(43, 43, 43, 1),
                          inputFormatters: []),
                                    ),
                                  ),
                                  DataCell(
                                    Center(
                                      child:   ElevatedButton(
                                onPressed: (){

                                  if (_builtyNumberController[index].text == null || _builtyNumberController[index].text == "")
                                  {
                                      Fluttertoast.showToast(
                msg: "Enter Builty Number First!",
                backgroundColor: Colors.red,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);

                                  }
                                   else if (_builtyDateController[index].text == null || _builtyDateController[index].text == "")
                                  {
                                                    Fluttertoast.showToast(
                msg: "Select Builty Date First!",
                backgroundColor: Colors.red,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);
                                  }
                                  else if (_pickedImages[index] == null)
                                  {
                Fluttertoast.showToast(
                msg: "Please upload Builty first!",
                backgroundColor: Colors.red,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);
                                  }
                                  else
                                  {
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

                                  
final service = ApiBillService();

      service.uploadBuilty(_builtyNumberController[index].text, _builtyDateController[index].text, _builtyModel!.data![index].simNo.toString(), _builtyModel!.data![index].simDate.toString(),_pickedImages[index]!)
          .then((value) {
        if (value.isNotEmpty) {
          if (value["errorCode"] == 0) {
            Navigator.pop(context);
            
            _getBuiltyAPI();
 Fluttertoast.showToast(
                msg: "Sucessfully Uploaded",
                backgroundColor: Colors.green,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);
            // Get.offAllNamed("/");
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.CENTER,
              textColor: Colors.white);
        }
      });
                                  }
                                  

                 
                                },
                                child: Icon(Icons.upload ,color: Colors.white,),
                                
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                    ),
                                  )),
                                  DataCell(
                                    _pickedImages[index] != null ?  Row(children: [
                                      ElevatedButton(
                                                                    onPressed: (){
                                                                       showModalBottomSheet<void>(
                                              context: context,
                                              builder:
                                                  (BuildContext context) {
                                                return Container(
                                                  height: 320,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      // mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        const Text(
                                                          'Upload Builty',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,color: Colors.black,),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        MaterialButton(
                                                        minWidth: 150,
                                                          color: Colors.black,
                                                          child: const Text(
                                                              'Camera',style: TextStyle(color: Colors.white),),
                                                          onPressed: () =>
                                                              _pickAndCropImageCamera(index),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        MaterialButton(
                                                           minWidth: 150,
                                                            color: Colors.black,
                                                          child: const Text(
                                                              'Gallery',style: TextStyle(color: Colors.white)),
                                                          onPressed: () =>
                                                             _pickAndCropImageGallery(index),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                  
                                                        MaterialButton(
                                                            minWidth: 150,
                                                             color: Colors.black,
                                                          child: const Text(
                                                              'Close',style: TextStyle(color: Colors.white)),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                                                   
                                                                    },
                                                                    child:     Icon(Icons.image ,color: Colors.white,),
                                                                    
                                                                  
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: Colors.black,
                                                                    ),
                                                                        ),
                                    
                                                                        GestureDetector(child: Text("View",style: TextStyle(fontWeight: FontWeight.bold),
                                                                        
                                                                        ),onTap: ()
                                                                        {
                                                                            Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, _, __) => FullImageDialogBoxWithoutUrl(
                                        pickedImage: _pickedImages[index]!,
                                      )));

                                                                        },)
                                    
                                    
                                    ],)  : ElevatedButton(
                                                                    onPressed: (){
                                                                       showModalBottomSheet<void>(
                                              context: context,
                                              builder:
                                                  (BuildContext context) {
                                                return Container(
                                                  height: 320,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      // mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        const Text(
                                                          'Upload Builty',
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,color: Colors.black,),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        MaterialButton(
                                                        minWidth: 150,
                                                          color: Colors.black,
                                                          child: const Text(
                                                              'Camera',style: TextStyle(color: Colors.white),),
                                                          onPressed: () =>
                                                              _pickAndCropImageCamera(index),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        MaterialButton(
                                                           minWidth: 150,
                                                            color: Colors.black,
                                                          child: const Text(
                                                              'Gallery',style: TextStyle(color: Colors.white)),
                                                          onPressed: () =>
                                                             _pickAndCropImageGallery(index),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                  
                                                        MaterialButton(
                                                            minWidth: 150,
                                                             color: Colors.black,
                                                          child: const Text(
                                                              'Close',style: TextStyle(color: Colors.white)),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                                                   
                                                                    },
                                                                    child:     Icon(Icons.image ,color: Colors.white,),
                                                                    
                                                                  
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: Colors.black,
                                                                    ),
                                                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                )
              ],
            )) : SizedBox());
  }
}

class FullImageDialogBoxWithoutUrl extends StatefulWidget {
  FullImageDialogBoxWithoutUrl({Key? key, required this.pickedImage})
      : super(key: key);

  final File pickedImage;

  @override
  _FullImageDialogBoxWithoutUrlState createState() => _FullImageDialogBoxWithoutUrlState();
}

class _FullImageDialogBoxWithoutUrlState extends State<FullImageDialogBoxWithoutUrl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
    onPressed
    :
    (
    ) => Navigator.pop(context),
    ),
    title: Text(
    "Full Image View",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold),
    ),
    centerTitle: true,
    ),
    body:Container(
    child:
   Image.file(widget.pickedImage,height: double.infinity,),
  
    ));

    }


}