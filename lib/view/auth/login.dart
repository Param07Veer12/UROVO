import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urovo/components/dropdown.dart';
import 'package:urovo/controllers/bottombar_controller.dart';
import 'package:urovo/models/CompanyModel.dart';
import 'package:urovo/models/FinancialYearModel.dart';
import 'package:urovo/services/login_service.dart';
import 'package:urovo/services/pref_service.dart';
import 'package:urovo/view/home/home.dart';
import 'package:urovo/view/home/main_screen.dart';

import '../../components/button.dart';
import '../../components/textfield.dart';
import '../../constant/app_theme.dart';
import '../../services/shared_preferences_class.dart';
import '../home/bottombar.dart';
    var randomQuote = "Sign In";

class LoginScreeen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Image.asset(
                "assets/images/Applogo.jpeg",
                height: 120,
              ),
              SizedBox(
                height: 12,
              ),
            
              const SignInForm(),
            ]),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  bool passwordLoginVisibility = false;
  bool isRemember = false;
  final emailController = TextEditingController();
  final password = TextEditingController();
      String companyValue = "Choose Company";
    List<String> companyValueList = ["Choose Company"];
     List<String> dbNameValueList = ["Choose Company"];

      String financialYearValue = "Choose Finacial Year";
    List<String> financialYearValueList = ["Choose Finacial Year"];
    var dbName = "";

  @override
  void initState() {
    super.initState();

    initialization();

    getRememberDetails();
    _getCompanyMst();
    _getFinanceYear();

  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
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
      final service = ApiLoginPasswordService();
      service.ApiLoginService(emailController.text, password.text,dbName,financialYearValue)
          .then((value) {
        Navigator.pop(context);
        if (value.isNotEmpty) {
          if (value[0]["code"] == 0) {
           SharedPreferencesClass.prefs.setString("token", value[0]["token"].toString());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainScreen()));
            // Get.offAllNamed("/");
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      });
    }
  }

   void _getFinanceYear() {
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
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      });
     
   
  }

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
      companyValueList.add("Choose Company");
      dbNameValueList.add("Choose Company");

for (var companyModel in companyValueModel!.data!.data) {
  companyValueList.add(companyModel.companyName);
  dbNameValueList.add(companyModel.dbName);
}
companyValue = companyValueModel.data.data[0].companyName;
dbName= companyValueModel.data.data[0].dbName;
setState(() {
});
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Credentials",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                textColor: Colors.white);
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              backgroundColor: Colors.red,
              gravity: ToastGravity.TOP,
              textColor: Colors.white);
        }
      });
     
   
  }

    

  Future<void> getRememberDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    emailController.text = (sharedPreferences.getString('username') ?? "");
    password.text = (sharedPreferences.getString('password') ?? "");
    isRemember = (sharedPreferences.getBool('isRemember') ?? false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Form(
        key: _formKey,
        onChanged: () {
          // final isValid = _formKey.currentState!.validate();
          // if (_isValid != isValid) {
          //   setState(() {
          //     _isValid = isValid;
          //   });
          // }
        },
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                randomQuote,
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: AppTheme.whiteBackgroundColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 20,
              ),
           Text(
            "Company Name",
            style: AppTextStyles.lable,
          ),
            SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
    
    decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                

    border: Border.all(color: Colors.grey)
  ),                
            child: dropDownWidget(
                    initialValue: companyValue,
                    dropDownValueList: companyValueList,
                    onChanged: (String? newValue) {
                      setState(() {
                        companyValue = newValue!;
                        dbName= dbNameValueList[companyValueList.indexOf(newValue)];

                      });
                    },
                  ),
          ),
            SizedBox(
            height: 8,
          ),
                Text(
            "Financial Year",
            style: AppTextStyles.lable,
          ),
            SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
    
    decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                

    border: Border.all(color: Colors.grey)
  ),                
            child: dropDownWidget(
                    initialValue: financialYearValue,
                    dropDownValueList: financialYearValueList,
                    onChanged: (String? newValue) {
                      setState(() {
                        financialYearValue = newValue!;
                      });
                    },
                  ),
          ),
    SizedBox(
            height: 8,
          ),
          Text(
            "User Name / Email / Mobile Number",
            style: AppTextStyles.lable,
          ),
          MyTextField(
              textEditingController: emailController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return "Username is required";
                }
                return null;
              },
              hintText: "",
              color: const Color(0xff585A60)),
          SizedBox(
            height: 10,
          ),
          Text(
            "Password",
            style: AppTextStyles.lable,
          ),
          MyTextField(
              textEditingController: password,
              isSuffixIcon: true,
              obsecureText: !passwordLoginVisibility,
              ontapSuffix: () {
                passwordLoginVisibility = !passwordLoginVisibility;
                setState(() {});
                // _controller.showPassword();
              },
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }
                return null;
              },
              hintText: "********",
              color: const Color(0xff585A60)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CupertinoSwitch(
                        // This bool value toggles the switch.
                        //  inactiveThumbColor: AppTheme.backGround2,
                      //  activeTrackColor: AppTheme.primaryColor,
                        activeColor: AppTheme.primaryColor,
                        //  inactiveTrackColor: AppTheme.backGround2,
                        value: isRemember,
                        // trackOutlineWidth: 20,
                        //   trackColor: MaterialStatePropertyAll<Color>(
                        //       AppTheme.primaryColor),
                        //   thumbColor:
                        //       const MaterialStatePropertyAll<Color>(Colors.white),
                        onChanged: (bool value) {
                          setState(() {
                            isRemember = !isRemember;
                          });
                          // This is called when the user toggles the switch.
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {},
                      child: Text(
                        "  Remember Me",
                        style: AppTextStyles.hintText,
                      )),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 30,
            ),
            child: RoundedButton(
              ontap: () {
                _submit();
              },
              textcolor: Colors.black,
              title: "Sign In",
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              child: Text("Forgot Password?",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
            
            ),
          )
        ]),
      ),
    );
  }
}
