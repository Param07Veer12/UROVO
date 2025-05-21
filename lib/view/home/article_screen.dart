import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:urovo/components/textfield.dart';
import 'package:urovo/models/ArticleModel.dart';
import 'package:urovo/services/builty_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:convert';



class ArticleScreen extends StatefulWidget {
  @override
  State<ArticleScreen> createState() => _nameState();
}

class _nameState extends State<ArticleScreen> {
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
   TextEditingController _articleNoController = TextEditingController();
      TextEditingController _articleNoMainController = TextEditingController();

      TextEditingController _articleNameController = TextEditingController();

   ArticleModel? _articleModel;
       Uint8List? imageBytes ;

  @override
  void initState() {
    super.initState();

    _scrollController2 = ScrollController();
    _scrollController = ScrollController();
  //  _getBuiltyAPI();
  }
  bool isLoading = false;
 dynamic convertToBase64(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    return base64Image;
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
    Widget textField(
      {required TextEditingController controller,
      required bool isReadonly,
      void Function(String)? onChanged,
      required List<TextInputFormatter> inputFormatters,
      TextInputType? keyboardType,
      Color? fillColor,
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
                
                fillColor: fillColor == null ? const Color.fromARGB(255, 228, 227, 227) : fillColor,
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
     


   void _getArticleAPI() {
      setState(() {
      isLoading = true; // Start the loader
    });
                  

      final service = ApiArticleService();
      service.apiArticleData(_articleNoController.text.trim())
          .then((value) {
        if (value != null) {
                 _articleModel = value;
                 _articleNoMainController.text = _articleNoController.text.trim();
                 _articleNameController.text = _articleModel?.data?[0].artName ?? "";
if (_articleModel?.data?[0].artImage != null && _articleModel?.data?[0].artImage != "")
{
  imageString = _articleModel?.data?[0].artImage ?? "";
    imageBytes = base64Decode(imageString);

}

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
   File? _pickedImage ;
  List <File?> _pickedImages = <File?> [];
  Future<void> _pickAndCropImageGallery() async {
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
          _pickedImage = File(croppedFile.path);
           imageString = convertToBase64(_pickedImage!);

        });
      }
    }
  }
    Future<void> _pickAndCropImageCamera() async {
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
          _pickedImage = File(croppedFile.path);
           imageString = convertToBase64(_pickedImage!);

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

  var imageString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "",
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
            :  _articleModel == null ?  Padding(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text("Enter Article Number",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                   SizedBox(height: 20,),
                  MyTextField(
              textEditingController: _articleNoController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                return null;
              },
              hintText: "",
              color: const Color(0xff585A60)),
               
                  SizedBox(height: 25,),
                  MaterialButton(onPressed: (){
                    if (_articleNoController.text == "")
                    {
                        Fluttertoast.showToast(
              msg: "Please enter article number",
              backgroundColor: Colors.white,
              gravity: ToastGravity.CENTER,
              textColor: Colors.black);
                    }
                    else
                    {
                       _getArticleAPI();
          
              
              
                    }
                          
              
                  },
                  height: 40,
                  minWidth: 150,
                  color: Colors.white,
                  child: const Text('Search',style: TextStyle(color: Colors.black,fontSize: 17),),
              
                  ),
                  
                  
              
              //    _articleModel == null ? 
              
              
                ],
              ),
            )  : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Container(child: Column(
                  children: [
                                       SizedBox(height: 20,),
              
                     Text("Article Number",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                     SizedBox(height: 20,),
                  MyTextField(
              textEditingController: _articleNoMainController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                return null;
              },
              hintText: "",
              color: const Color(0xff585A60)),
                
                                   const SizedBox(height: 30,),
                  const  Text("Article Image",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              
                  const  SizedBox(height: 30,),
                    Center(child: SizedBox(child:  ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),

                      child:   _pickedImage != null ? GestureDetector(
                        onTap: ()
                        {                           
                              Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, _, __) => FullImageDialogBoxWithoutUrl(
                                        pickedImage: _pickedImage!,
                                      )));

                        },
                        child: Image.file(_pickedImage!,height: 200,width: 200,)) : imageBytes != null  ?   GestureDetector(
                        onTap: ()
                        {
                               Navigator.of(context).push(PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (BuildContext context, _, __) => FullImageDialogBox(
                                        imageBytes: imageBytes!,
                                      )));
                        },
                          child: Image.memory(
                                    imageBytes!,
                                    fit: BoxFit.cover,
                                  ),
                        )      : Image.asset("assets/images/placeholder.jpg")),height: 200,width: 200,)),
                     SizedBox(height: 30,),
                     MaterialButton(onPressed: (){
                    
                    
              
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
                                                              _pickAndCropImageCamera(),
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
                                                             _pickAndCropImageGallery(),
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
                    height: 40,
                    minWidth: 150,
                    color: Colors.white,
                    child: const Text('Set Image',style: TextStyle(color: Colors.black,fontSize: 17),),
              
                    ),
                    SizedBox(height: 30,),
              
                     Text("Article Name",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                     SizedBox(height: 20,),
                MyTextField(
              textEditingController: _articleNameController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                return null;
              },
              hintText: "",
              color: const Color(0xff585A60)),
                 
              
                     SizedBox(height: 40,),
                     MaterialButton(onPressed: (){
                      if (_articleNoMainController.text == "")
                      {
                        Fluttertoast.showToast(
                msg: "Please enter article number",
                backgroundColor: Colors.white,
                gravity: ToastGravity.CENTER,
                textColor: Colors.black);
                      }
                      else  if (imageString == "")
                      {
                 Fluttertoast.showToast(
                msg: "Please upload article image",
                backgroundColor: Colors.white,
                gravity: ToastGravity.CENTER,
                textColor: Colors.black);
                     
              
                      }
                           else if (_articleNameController.text == "")
                      {
                 Fluttertoast.showToast(
                msg: "Please enter article name",
                backgroundColor: Colors.white,
                gravity: ToastGravity.CENTER,
                textColor: Colors.black);
                     
              
                      }
                      else
                      {
                        
final service = ApiArticleService();

      service.uploadArticleData(_articleNoMainController.text,_articleNameController.text,imageString)
          .then((value) {
        if (value.isNotEmpty) {
          if (value["errorCode"] == 0) {
             Fluttertoast.showToast(
                msg: "Sucessfully Uploaded",
                backgroundColor: Colors.green,
                gravity: ToastGravity.CENTER,
                textColor: Colors.white);
                _articleModel = null;
                setState(() {
                  _articleNoController.text = "";
                });
        
            

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
                    height: 40,
                    minWidth: 200,
                    color: Colors.white,
                    child: const Text('SUBMIT',style: TextStyle(color: Colors.black,fontSize: 17),),
              
                    ),
                    SizedBox(height: 50,)
              
                //    _articleModel == null ? 
                
                
                  ],
                )
                ),
              ),
            ) );
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

class FullImageDialogBox extends StatefulWidget {
  FullImageDialogBox({Key? key, required this.imageBytes})
      : super(key: key);

      final Uint8List imageBytes ;

  @override
  _FullImageDialogBoxState createState() => _FullImageDialogBoxState();
}

class _FullImageDialogBoxState extends State<FullImageDialogBox> {
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
   Image.memory(
                                    widget.imageBytes!,
                                    height: double.infinity,
                                  )
  
    ));

    }


}