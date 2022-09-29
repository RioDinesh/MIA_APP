import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mia_app/Bloc/GetWe/weAreInto_Bloc.dart';
import 'package:mia_app/Bloc/GetWe/weAreInto_Event.dart';
import 'package:mia_app/Bloc/GetWe/weAreInto_State.dart';

import 'package:mia_app/Bloc/Register-Bloc/register_Bloc.dart';
import 'package:mia_app/Bloc/Register-Bloc/register_Event.dart';
import 'package:mia_app/Bloc/Register-Bloc/register_State.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mia_app/modal/manufacturing.dart';
import 'package:mia_app/modal/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Razorpay _razorpay;
  final ImagePicker picker = ImagePicker();
  TextEditingController Name = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController Phone = new TextEditingController();
  TextEditingController Password = new TextEditingController();
  TextEditingController RepeatPassword = new TextEditingController();
  var _Name;
  var _Email;
  var _Phone;
  var _Password;
  var _RepeatPassword;
  TextEditingController BussinessName = new TextEditingController();
  TextEditingController TurnOver = new TextEditingController();
  TextEditingController NoofEmployees = new TextEditingController();
  TextEditingController YearofEstablishment = new TextEditingController();
  TextEditingController IndustryType = new TextEditingController();
  TextEditingController PAN = new TextEditingController();
  TextEditingController CompanyInfo = new TextEditingController();
  TextEditingController Website = new TextEditingController();
  TextEditingController Linkedin = new TextEditingController();
  TextEditingController Instagram = new TextEditingController();
  TextEditingController Facebook = new TextEditingController();
  TextEditingController City = new TextEditingController();
  TextEditingController State = new TextEditingController();
  TextEditingController Country = new TextEditingController();
  TextEditingController CompanyPhone = new TextEditingController();
  TextEditingController CompanyEmail = new TextEditingController();
  var _BussinessName;
  var _TurnOver;
  var _NoofEmployees;
  var _YearofEstablishment;
  var _IndustryType;
  var _PAN;
  var _CompanyInfo;
  var _Website;
  var _Linkedin;
  var _Instagram;
  var _Facebook;
  var _City;
  var _State;
  var _Countrty;
  var _CompanyPhone;
  var _CompanyEmail;
  TextEditingController cinNumber = new TextEditingController();
  TextEditingController aadharnumber = new TextEditingController();
  TextEditingController gstnumber = new TextEditingController();
  var _dummy;
  File logo;
  File cin;
  File aadhaar;
  File others;
  int pagecount = 0;
  String selectedval;
  String WeAreInto;
  String _WeAreInto;
  String Webelongtomani;
  String Webelongtoservice;
  String export_import;
  var _export_import;
  Widget Textfield(error, TextEditingController c, lab, icon,
      TextInputType type, bool password) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: TextField(
        obscureText: password,
        keyboardType: type,
        controller: c,
        decoration: InputDecoration(
          errorText: error != null ? error : null,
          prefixIcon: Icon(
            icon,
            color: MainColor,
          ),
          labelText: lab,
          labelStyle: TextStyle(fontFamily: "Nunito-Bold", fontSize: 14.sp),
        ),
      ),
    );
  }

  List<String> import_exportList = [
    "Domestic",
    "Apac",
    "EU Middle east",
    "Africa",
    "North America",
    "Latin America",
    "All"
  ];
  List<String> weareinto = ["Manufacturing", "Others", "Services"];
  List<String> FounderQualifications = [
    "Education",
    "Pre University",
    "Undergraduate",
    "Graduate",
    "Postgraduate",
    "PhD Holder"
  ];
  List<String> Certificate = [
    "others",
    "not certified but planning to get it done",
    "ISO 9001:2015",
    "Not applicable on us",
    "ISO 9004:2008",
    "ISO 15504-4: 2005",
    "BPR",
    "Quality circle",
    "TQM",
    "TRIZ",
    "QFD",
    "Kaizen",
    "Zero Defect Program",
    "Six Sigma",
    "PDCA",
    "Taguchi methods",
    "The Toyota Production System",
    "Top Down & Bottom Up Approaches",
    "OQRM",
    "Kansei Engineering"
  ];
  List<String> weblongtomanufacturing = [
    "Casting",
    "Imaging & Coating",
    "Moulding",
    "Forming (Metal Working)",
    "Machining",
    "Joining",
    "Additive Manufacturing",
    "Chemical Manufacturing",
    "Quarrying",
    "Matchmaking",
    "Interior designing ",
    "Builders Hardware & Paints"
  ];
  List<String> weblongtoService = [
    "Construction",
    "Hotel",
    "Information Technology",
    "Investment",
    "Leasing",
    "Hire Purchase",
    "Banking",
    "Merchant Banking",
    "Service Segment",
    "Builders",
    "Hardware & Paints",
  ];
  var text;
  String Foundquali;
  String QMC;
  bool showWe=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  RegisterBloc registerBloc;
  void openCheckout(amt, name) async {
    // final String patientname = await storage.read(key: 'pt_name');
    // print(patientname);
    var options = {
      'key': ApiBase.RazorpayKeyID,
      'amount': num.parse(amt) * 100,
      'name': name,
      'description': 'Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  bool failed = false;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("hi");
    registerBloc = BlocProvider.of<RegisterBloc>(context);
    registerBloc.add(OnRegisterPress(
        name: Name.text,
        email: Email.text,
        mobile: Phone.text,
        password: '123',
        companyname: BussinessName.text,
        Weareinto: WeAreInto,
        import_export: export_import,
        webelongto: Webelongtoservice,
        last_year_turn_over: TurnOver.text,
        no_of_employees: NoofEmployees.text,
        year_of_establishment: YearofEstablishment.text,
        industryType: IndustryType.text,
        pan: PAN.text,
        founder_qual: Foundquali,
        qual_mgmt: QMC,
        company_description: CompanyInfo.text,
        member_website: Website.text,
        member_facebook: Facebook.text,
        member_linkedin: Linkedin.text,
        member_instagram: Instagram.text,
        company_city: City.text,
        company_state: State.text,
        company_country: Country.text,
        company_phone: CompanyPhone.text,
        company_email: CompanyEmail.text,
        logo: logo,
        cinnumber: cinNumber.text,
        cin: cin,
        aadhaarnumber: aadharnumber.text,
        aadhaar: aadhaar,
        gstnumber: gstnumber.text,
        others: others,
        company_address: "",
        scale: "",
        memshiptype: "",
        membertype: ""));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed", gravity: ToastGravity.CENTER);
    print(response.message);
    setState(() {
      failed = true;
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }
 WeAreIntoBloc weAreIntoBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Join MIA",
          style: TextStyle(color: Colors.black, fontFamily: "Nunito-Bold"),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailed) {
              Fluttertoast.showToast(msg: state.error);
            } else if (state is Registered) {
              Fluttertoast.showToast(msg: "account created successfully");
              Navigator.popUntil(context, (route) => route.isFirst);
            }
            // TODO: implement listener
          },
          child: BlocBuilder<RegisterBloc, RegisterState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is RegisterInitial || state is RegisterFailed) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            // splashColor: MainColor.withOpacity(0.2),
                            onTap: () {
                              if (pagecount != 0) {
                                if (pagecount == 1) {
                                  setState(() {
                                    pagecount = 0;
                                  });
                                } else if (pagecount == 2) {
                                  setState(() {
                                    pagecount = 1;
                                  });
                                } else if (pagecount == 3) {
                                  setState(() {
                                    pagecount = 2;
                                  });
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: MainColor,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: MainColor))),
                            child: Text(
                              pagecount == 0
                                  ? "Basic Information"
                                  : pagecount == 1
                                      ? "Company Information"
                                      : pagecount == 2
                                          ? "Company Docs"
                                          : pagecount == 3
                                              ? "Membership Type"
                                              : "",
                              style: TextStyle(
                                  fontFamily: "Nunito-Bold", fontSize: 20.sp),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (pagecount != 3) {
                                if (pagecount == 0) {
                                  if (Name.text.isNotEmpty &&
                                      Email.text.isNotEmpty &&
                                      Phone.text.isNotEmpty &&
                                      Password.text.isNotEmpty &&
                                      RepeatPassword.text.isNotEmpty) {
                                    if (Password.text == RepeatPassword.text &&
                                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(Email.text)) {
                                      setState(() {
                                        _Name = null;
                                        _Email = null;
                                        _Password = null;
                                        _RepeatPassword = null;
                                      });
                                      setState(() {
                                        pagecount = 1;
                                      });
                                    } else {
                                      if (RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(Email.text)) {
                                        setState(() {
                                          _Email =
                                              "Please provide valid email address";
                                        });
                                      }
                                      if (Password.text !=
                                          RepeatPassword.text) {
                                        setState(() {
                                          _Password = "Password Not Match";
                                          _RepeatPassword =
                                              "Password Not Match";
                                        });
                                      }
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please complete the Basic Information");
                                  }
                                } else if (pagecount == 1) {
                                  setState(() {
                                    pagecount = 2;
                                  });
                                } else if (pagecount == 2) {
                                  setState(() {
                                    pagecount = 3;
                                  });
                                }
                              }
                            },
                            child: Container(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: MainColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20.h,
                      ),
                      pagecount == 0
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Textfield(
                                    _Name,
                                    Name,
                                    "Name",
                                    Icons.person_outline,
                                    TextInputType.name,
                                    false),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Textfield(
                                    _Email,
                                    Email,
                                    "Email",
                                    Icons.email_outlined,
                                    TextInputType.emailAddress,
                                    false),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Textfield(
                                    _Phone,
                                    Phone,
                                    "Phone Number",
                                    Icons.phone_outlined,
                                    TextInputType.phone,
                                    false),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Textfield(
                                    _Password,
                                    Password,
                                    "Password",
                                    Icons.password_outlined,
                                    TextInputType.multiline,
                                    true),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Textfield(
                                    _RepeatPassword,
                                    RepeatPassword,
                                    "Repeat Password",
                                    Icons.password_outlined,
                                    TextInputType.visiblePassword,
                                    true),
                                SizedBox(
                                  height: 20.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    print(Phone.text.length);
                                    setState(() {
                                      _Name = null;
                                      _Email = null;
                                      _Password = null;
                                      _RepeatPassword = null;
                                      _Phone = null;
                                    });
                                    if (Name.text.isNotEmpty &&
                                        Email.text.isNotEmpty &&
                                        Phone.text.isNotEmpty &&
                                        Password.text.isNotEmpty &&
                                        RepeatPassword.text.isNotEmpty) {
                                      if (Password.text ==
                                              RepeatPassword.text &&
                                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(Email.text) &&
                                          Phone.text.length == 10) {
                                        setState(() {
                                          _Name = null;
                                          _Email = null;
                                          _Password = null;
                                          _RepeatPassword = null;
                                          _Phone = null;
                                        });
                                        setState(() {
                                          pagecount = 1;
                                        });
                                      } else {
                                        if (RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(Email.text)) {
                                        } else {
                                          setState(() {
                                            _Email =
                                                "Please provide valid email address";
                                          });
                                        }
                                        if (Password.text !=
                                            RepeatPassword.text) {
                                          setState(() {
                                            _Password = "Password Not Match";
                                            _RepeatPassword =
                                                "Password Not Match";
                                          });
                                        }
                                        if (Phone.text.length < 10) {
                                          setState(() {
                                            _Phone =
                                                "Please provide valid phone address";
                                          });
                                        }
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please complete the Basic Information");
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                        color: MainColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Bold",
                                          color: Colors.white,
                                          fontSize: 18.sp),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : pagecount == 1
                              ? Column(
                                  children: [
                                    Textfield(
                                        _BussinessName,
                                        BussinessName,
                                        "Business Name",
                                        Icons.business_sharp,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    DropdownButtonFormField<String>(
                                      //isDense: true,

                                      //hint: Text('Specialist',style: ,),
                                      //value: selectedvalue,
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Nunito-Regular"),

                                      decoration: InputDecoration(
                                        labelText: "We Are Into",
                                        labelStyle: TextStyle(
                                            fontFamily: "Nunito-Regular",
                                            color: MainColor),
                                        errorText: _WeAreInto,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onChanged: (String newValue) {
                                        
                                        // print(newValue);
                                       if(newValue=="Manufacturing"){
                                         setState(() {
                                          WeAreInto="1";
                                        });
                                        weAreIntoBloc = BlocProvider.of<WeAreIntoBloc>(context);
                                        
                                        weAreIntoBloc.add(GetManufacturing());
                                        setState(() {
                                          showWe=true;
                                        });
                                       }else if(newValue=="Services"){
                                         setState(() {
                                          WeAreInto="2";
                                        });
                                            weAreIntoBloc =BlocProvider.of<WeAreIntoBloc>(context);
                                            weAreIntoBloc.add(GetServices());
                                            setState(() {
                                              showWe=true;
                                            });
                                       }else{
                                         setState(() {
                                          WeAreInto="3";
                                        });
                                          setState(() {
                                              showWe=false;
                                            });
                                       }
                                        //print(selectedvalue);
                                        print(WeAreInto);
                                      },
                                      items: weareinto
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                    //  list(weareinto, text, WeAreInto, ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                   showWe==true? BlocListener<WeAreIntoBloc, WeAreIntoState>(
                                      listener: (context, westate) {
                                        print(westate.toString());
                                        // TODO: implement listener
                                      },
                                      child: BlocBuilder<WeAreIntoBloc, WeAreIntoState>(
                                        builder: (context, westate) {
                                          if(westate is WeLoading){
                                            return Text("WeBelongTo");
                                          }else if(westate is WeFailed){
                                            return Container();
                                          }else if(westate is WeAreServices){
                                            
                                            return DropdownButtonFormField<
                                              ServiceCatData>(
                                            //isDense: true,

                                            //hint: Text('Specialist',style: ,),
                                            //value: selectedvalue,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Nunito-Regular"),

                                            decoration: InputDecoration(
                                              labelText: "We Are Into",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Nunito-Regular",
                                                  color: MainColor),
                                              errorText: _WeAreInto,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onChanged: (ServiceCatData newValue) {
                                              // print(newValue);
                                              setState(() {
                                                //  value=newValue;
                                                Webelongtoservice = newValue.serCatName;
                                              });
                                              //print(selectedvalue);
                                              print(WeAreInto);
                                            },
                                            items: westate.data
                                                .map<DropdownMenuItem<ServiceCatData>>(
                                                    (ServiceCatData value) {
                                              return DropdownMenuItem<ServiceCatData>(
                                                value: value,
                                                child: Text(value.serCatName),
                                              );
                                            }).toList(),
                                          );
                                          }else if(westate is WeAreManufacture){
                                             return DropdownButtonFormField<
                                              ManufactureCategoryData>(
                                            //isDense: true,

                                            //hint: Text('Specialist',style: ,),
                                            //value: selectedvalue,
                                            icon: Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.black,
                                            ),
                                            iconSize: 24,
                                            elevation: 16,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Nunito-Regular"),

                                            decoration: InputDecoration(
                                              labelText: "We Are Into",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Nunito-Regular",
                                                  color: MainColor),
                                              errorText: _WeAreInto,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onChanged: (ManufactureCategoryData newValue) {
                                              // print(newValue);
                                              setState(() {
                                                //  value=newValue;
                                                Webelongtoservice = newValue.manCatName;
                                              });
                                              //print(selectedvalue);
                                              print(WeAreInto);
                                            },
                                            items: westate.data
                                                .map<DropdownMenuItem<ManufactureCategoryData>>(
                                                    (ManufactureCategoryData value) {
                                              return DropdownMenuItem<ManufactureCategoryData>(
                                                value: value,
                                                child: Text(value.manCatName),
                                              );
                                            }).toList(),
                                          );
                                          }
                                          return Container();
                                          
                                        },
                                      ),
                                    ):Container(),
                                    /* WeAreInto == null ||
                                          WeAreInto == "" ||
                                          WeAreInto == "Others"
                                      ? Container()
                                      : WeAreInto == "Manufacturing"
                                          ? list(weblongtomanufacturing, text,
                                              Webelongtomani, "We Belong To")
                                          : list(
                                              weblongtoService,
                                              text,
                                              Webelongtoservice,
                                              "We Belong To"),*/
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    list(
                                        import_exportList,
                                        _export_import,
                                        export_import,
                                        "We Export to /Import from"),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Textfield(
                                        _TurnOver,
                                        TurnOver,
                                        "Turn Over (In Lakhs)",
                                        Icons.money_rounded,
                                        TextInputType.number,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _NoofEmployees,
                                        NoofEmployees,
                                        "No. of Employees",
                                        Icons.person_outline,
                                        TextInputType.number,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _YearofEstablishment,
                                        YearofEstablishment,
                                        "Year of Establishment",
                                        Icons.calendar_today_outlined,
                                        TextInputType.datetime,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _IndustryType,
                                        IndustryType,
                                        "Industry Type",
                                        Icons.merge_type,
                                        TextInputType.visiblePassword,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _PAN,
                                        PAN,
                                        "PAN",
                                        Icons.card_membership,
                                        TextInputType.number,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    list(FounderQualifications, text,
                                        Foundquali, "Founder Qualification"),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    list(Certificate, text, QMC,
                                        "Quality management certification"),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _CompanyInfo,
                                        CompanyInfo,
                                        "Company Info",
                                        Icons.business_sharp,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _Website,
                                        Website,
                                        "Website",
                                        LineIcons.edgeBrowser,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _Linkedin,
                                        Linkedin,
                                        "Linkedin",
                                        LineIcons.linkedin,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _Instagram,
                                        Instagram,
                                        "Instagram",
                                        LineIcons.instagram,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _Facebook,
                                        Facebook,
                                        "Facebook",
                                        LineIcons.facebook,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _City,
                                        City,
                                        "City",
                                        LineIcons.city,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _State,
                                        State,
                                        "State",
                                        LineIcons.city,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _Countrty,
                                        Country,
                                        "Country",
                                        LineIcons.map,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _CompanyPhone,
                                        CompanyPhone,
                                        "Phone",
                                        LineIcons.phone,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Textfield(
                                        _CompanyEmail,
                                        CompanyEmail,
                                        "Email",
                                        Icons.email_outlined,
                                        TextInputType.text,
                                        false),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Logo",
                                          style: TextStyle(
                                            fontFamily: "Nunito-Bold",
                                          ),
                                          textAlign: TextAlign.start,
                                        )),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 14.h, horizontal: 4.w),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: MainColor)),
                                      child: logo == null
                                          ? InkWell(
                                              onTap: () async {
                                                final XFile image =
                                                    await picker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                print(image.path);
                                                if (image.path != null) {
                                                  File croppedFile = await ImageCropper
                                                      .cropImage(
                                                          sourcePath:
                                                              image.path,
                                                          aspectRatioPresets: [
                                                            CropAspectRatioPreset
                                                                .square,
                                                          ],
                                                          androidUiSettings: AndroidUiSettings(
                                                              toolbarTitle:
                                                                  'Cropper',
                                                              toolbarColor:
                                                                  Colors.white,
                                                              toolbarWidgetColor:
                                                                  Colors.black,
                                                              initAspectRatio:
                                                                  CropAspectRatioPreset
                                                                      .original,
                                                              lockAspectRatio:
                                                                  false),
                                                          iosUiSettings:
                                                              IOSUiSettings(
                                                            minimumAspectRatio:
                                                                1.0,
                                                          ));

                                                  setState(() {
                                                    logo = croppedFile;
                                                  });
                                                }
                                              },
                                              child: Icon(LineIcons.image))
                                          : Image.file(File(logo.path)),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _BussinessName = null;
                                          _WeAreInto = null;
                                        });
                                        print(WeAreInto);
                                        if (BussinessName.text.isNotEmpty &&
                                            WeAreInto != null) {
                                          setState(() {
                                            pagecount = 2;
                                          });
                                        } else {
                                          if (BussinessName.text.isEmpty) {
                                            setState(() {
                                              _BussinessName =
                                                  "Please provide valid business name";
                                            });
                                          }
                                          if (_WeAreInto == null) {
                                            setState(() {
                                              _WeAreInto =
                                                  "Please select a category";
                                            });
                                          }
                                        }
                                        /* setState(() {
                                                    pagecount = 2;
                                                  });*/
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 12.h),
                                        decoration: BoxDecoration(
                                            color: MainColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Next",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              color: Colors.white,
                                              fontSize: 18.sp),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pagecount == 2
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        // Textfield(_Name, Name, "CIN", Icons.email_outlined),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Textfield(
                                            _dummy,
                                            cinNumber,
                                            "Cin Number",
                                            Icons.verified_outlined,
                                            TextInputType.number,
                                            false),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "CIN",
                                            style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: MainColor)),
                                          child: cin != null
                                              ? Image.file(File(cin.path))
                                              : InkWell(
                                                  onTap: () async {
                                                    final XFile image =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    print(image.path);
                                                    if (image.path != null) {
                                                      File croppedFile = await ImageCropper
                                                          .cropImage(
                                                              sourcePath:
                                                                  image.path,
                                                              aspectRatioPresets: [
                                                                CropAspectRatioPreset
                                                                    .square,
                                                              ],
                                                              androidUiSettings: AndroidUiSettings(
                                                                  toolbarTitle:
                                                                      'Cropper',
                                                                  toolbarColor:
                                                                      Colors
                                                                          .white,
                                                                  toolbarWidgetColor:
                                                                      Colors
                                                                          .black,
                                                                  initAspectRatio:
                                                                      CropAspectRatioPreset
                                                                          .original,
                                                                  lockAspectRatio:
                                                                      false),
                                                              iosUiSettings:
                                                                  IOSUiSettings(
                                                                minimumAspectRatio:
                                                                    1.0,
                                                              ));

                                                      setState(() {
                                                        cin = croppedFile;
                                                      });
                                                    }
                                                  },
                                                  child: Icon(LineIcons.image)),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Textfield(
                                            _dummy,
                                            aadharnumber,
                                            "Aadhaar Number",
                                            Icons.verified_outlined,
                                            TextInputType.number,
                                            false),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        //  Textfield(_Name, Name, "Udhyog Aadhaar", Icons.email_outlined),

                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Udhyog Aadhaar",
                                              style: TextStyle(
                                                fontFamily: "Nunito-Bold",
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: MainColor)),
                                          child: aadhaar != null
                                              ? Image.file(File(aadhaar.path))
                                              : InkWell(
                                                  onTap: () async {
                                                    final XFile image =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    print(image.path);
                                                    if (image.path != null) {
                                                      File croppedFile = await ImageCropper
                                                          .cropImage(
                                                              sourcePath:
                                                                  image.path,
                                                              aspectRatioPresets: [
                                                                CropAspectRatioPreset
                                                                    .square,
                                                              ],
                                                              androidUiSettings: AndroidUiSettings(
                                                                  toolbarTitle:
                                                                      'Cropper',
                                                                  toolbarColor:
                                                                      Colors
                                                                          .white,
                                                                  toolbarWidgetColor:
                                                                      Colors
                                                                          .black,
                                                                  initAspectRatio:
                                                                      CropAspectRatioPreset
                                                                          .original,
                                                                  lockAspectRatio:
                                                                      false),
                                                              iosUiSettings:
                                                                  IOSUiSettings(
                                                                minimumAspectRatio:
                                                                    1.0,
                                                              ));

                                                      setState(() {
                                                        aadhaar = croppedFile;
                                                      });
                                                    }
                                                  },
                                                  child: Icon(LineIcons.image)),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        //Textfield(_Name, Name, "GST Number", Icons.email_outlined),
                                        Textfield(
                                            _dummy,
                                            gstnumber,
                                            "Gst Number",
                                            Icons.verified_outlined,
                                            TextInputType.number,
                                            false),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Others",
                                              style: TextStyle(
                                                fontFamily: "Nunito-Bold",
                                              ),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 14.h, horizontal: 4.w),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: MainColor)),
                                          child: others != null
                                              ? Image.file(File(others.path))
                                              : InkWell(
                                                  onTap: () async {
                                                    final XFile image =
                                                        await picker.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    print(image.path);
                                                    if (image.path != null) {
                                                      File croppedFile = await ImageCropper
                                                          .cropImage(
                                                              sourcePath:
                                                                  image.path,
                                                              aspectRatioPresets: [
                                                                CropAspectRatioPreset
                                                                    .square,
                                                              ],
                                                              androidUiSettings: AndroidUiSettings(
                                                                  toolbarTitle:
                                                                      'Cropper',
                                                                  toolbarColor:
                                                                      Colors
                                                                          .white,
                                                                  toolbarWidgetColor:
                                                                      Colors
                                                                          .black,
                                                                  initAspectRatio:
                                                                      CropAspectRatioPreset
                                                                          .original,
                                                                  lockAspectRatio:
                                                                      false),
                                                              iosUiSettings:
                                                                  IOSUiSettings(
                                                                minimumAspectRatio:
                                                                    1.0,
                                                              ));

                                                      setState(() {
                                                        others = croppedFile;
                                                      });
                                                    }
                                                  },
                                                  child: Icon(LineIcons.image)),
                                        ),

                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              pagecount = 3;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 12.h),
                                            decoration: BoxDecoration(
                                                color: MainColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "Next",
                                              style: TextStyle(
                                                  fontFamily: "Nunito-Bold",
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            openCheckout("1000", Name.text);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "30 - Days Membership - Rs. 1000",
                                                style: TextStyle(
                                                    fontFamily: "Nunito-Bold",
                                                    fontSize: 16.sp),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: MainColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: MainColor,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            openCheckout("3000", Name.text);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "365 - Days Membership - Rs. 3000",
                                                style: TextStyle(
                                                    fontFamily: "Nunito-Bold",
                                                    fontSize: 16.sp),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                color: MainColor,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            registerBloc =
                                                BlocProvider.of<RegisterBloc>(
                                                    context);
                                            registerBloc.add(OnRegisterPress(
                                                name: Name.text,
                                                email: Email.text,
                                                mobile: Phone.text,
                                                password: '123',
                                                companyname: BussinessName.text,
                                                Weareinto: WeAreInto,
                                                import_export: export_import,
                                                webelongto: Webelongtoservice,
                                                last_year_turn_over:
                                                    TurnOver.text,
                                                no_of_employees:
                                                    NoofEmployees.text,
                                                year_of_establishment:
                                                    YearofEstablishment.text,
                                                industryType: IndustryType.text,
                                                pan: PAN.text,
                                                founder_qual: Foundquali,
                                                qual_mgmt: QMC,
                                                company_description:
                                                    CompanyInfo.text,
                                                member_website: Website.text,
                                                member_facebook: Facebook.text,
                                                member_linkedin: Linkedin.text,
                                                member_instagram:
                                                    Instagram.text,
                                                company_city: City.text,
                                                company_state: State.text,
                                                company_country: Country.text,
                                                company_phone:
                                                    CompanyPhone.text,
                                                company_email:
                                                    CompanyEmail.text,
                                                logo: logo,
                                                cinnumber: cinNumber.text,
                                                cin: cin,
                                                aadhaarnumber:
                                                    aadharnumber.text,
                                                aadhaar: aadhaar,
                                                gstnumber: gstnumber.text,
                                                others: others,
                                                company_address: "",
                                                scale: "",
                                                memshiptype: "",
                                                membertype: ""));
                                            setState(() {
                                              pagecount = 3;
                                            });
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 12.h),
                                            decoration: BoxDecoration(
                                                color: MainColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              "Proceed to Payment",
                                              style: TextStyle(
                                                  fontFamily: "Nunito-Bold",
                                                  color: Colors.white,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                      // Textfield(_Name, Name, "Name",Icons.person_outline),
                    ],
                  ),
                );
              } else if (state is RegisterLoading) {
                Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is Registered) {
                return Container();
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      )),
    );
  }

  Widget list(
    List<String> values,
    err,
    String selectedvalue,
    title,
  ) {
    return DropdownButtonFormField<String>(
      //isDense: true,

      //hint: Text('Specialist',style: ,),
      //value: selectedvalue,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.black, fontFamily: "Nunito-Regular"),

      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(fontFamily: "Nunito-Regular", color: MainColor),
        errorText: err,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (String newValue) {
        // print(newValue);
        setState(() {
          //  value=newValue;
          selectedvalue = newValue;
        });
        //print(selectedvalue);
        print(WeAreInto);
      },
      items: values.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class CropImage extends StatefulWidget {
  @override
  _CropImageState createState() => _CropImageState();
}

//_image = await ImagePicker().getImage(source: ImageSource.gallery)
class _CropImageState extends State<CropImage> {
  final ImagePicker picker = ImagePicker();
  File imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Upload Image",
          style: TextStyle(
              fontFamily: "Nunito-Bold", color: Colors.black, fontSize: 16.sp),
        ),
      ),
      body: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(MainColor),
              ),
              onPressed: () async {
                final XFile image =
                    await picker.pickImage(source: ImageSource.gallery);
                print(image.path);
                if (image.path != null) {
                  File croppedFile = await ImageCropper.cropImage(
                      sourcePath: image.path,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.square,
                      ],
                      androidUiSettings: AndroidUiSettings(
                          toolbarTitle: 'Cropper',
                          toolbarColor: Colors.white,
                          toolbarWidgetColor: Colors.black,
                          initAspectRatio: CropAspectRatioPreset.original,
                          lockAspectRatio: false),
                      iosUiSettings: IOSUiSettings(
                        minimumAspectRatio: 1.0,
                      ));

                  setState(() {
                    imagePath = croppedFile;
                  });
                }
              },
              child: Text("Select Image"),
            ),
          ),
          imagePath != null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        child: Image.file(
                          File(imagePath.path),
                          width: 400.w,
                          height: 400.h,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: MainColor),
                              borderRadius: BorderRadius.circular(6)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: MainColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                'Upload',
                                style: TextStyle(
                                    fontFamily: "Nunito-Bold",
                                    fontSize: 16.sp,
                                    color: MainColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      )),
    );
  }
}
