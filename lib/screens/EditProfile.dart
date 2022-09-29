import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-Bloc.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-Event.dart';
import 'package:mia_app/Bloc/Blog-Bloc/Blog-Bloc.dart';
import 'package:mia_app/Bloc/Edit-Profile/Edit_Profile-Bloc.dart';
import 'package:mia_app/Bloc/Edit-Profile/Edit_Profile-Event.dart';
import 'package:mia_app/Bloc/Edit-Profile/Edit_Profile-State.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-Bloc.dart';
import 'package:mia_app/Bloc/News-bloc/news-bloc.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-Bloc.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mia_app/modal/Member-profile.dart';
import 'package:mia_app/screens/dashboad.dart';

class EditProfile extends StatefulWidget {
  final MemberProfile profile;

  EditProfile({@required this.profile});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  int pagecount = 1;
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
  EditProfileBloc _editProfileBloc;
  var text;
  String Foundquali;
  String QMC;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      
      BussinessName.text = widget.profile.userData[0].companyName == null ||
              widget.profile.userData[0].companyName == ""
          ? "NA"
          : widget.profile.userData[0].companyName;
      TurnOver.text = widget.profile.userData[0].lastYearTurnOver == null ||
              widget.profile.userData[0].lastYearTurnOver == ""
          ? "NA"
          : widget.profile.userData[0].lastYearTurnOver;
      NoofEmployees.text = widget.profile.userData[0].noOfEmployees == null ||
              widget.profile.userData[0].noOfEmployees == ""
          ? "NA"
          : widget.profile.userData[0].noOfEmployees;
      YearofEstablishment.text =
          widget.profile.userData[0].yearOfEstablishment == null ||
                  widget.profile.userData[0].yearOfEstablishment == ""
              ? "NA"
              : widget.profile.userData[0].yearOfEstablishment;
      IndustryType.text = widget.profile.userData[0].scale == null ||
              widget.profile.userData[0].scale == ""
          ? "NA"
          : widget.profile.userData[0].scale;
      PAN.text = widget.profile.userData[0].pan == null ||
              widget.profile.userData[0].pan == ""
          ? "NA"
          : widget.profile.userData[0].pan;
      CompanyInfo.text =
          widget.profile.userData[0].companyDescription == null ||
                  widget.profile.userData[0].companyDescription == ""
              ? "NA"
              : widget.profile.userData[0].companyDescription;
      Website.text = widget.profile.userData[0].memberWebsite == null ||
              widget.profile.userData[0].memberWebsite == ""
          ? "NA"
          : widget.profile.userData[0].memberWebsite;
      Linkedin.text = widget.profile.userData[0].memberLinkedin == null ||
              widget.profile.userData[0].memberLinkedin == ""
          ? "NA"
          : widget.profile.userData[0].memberLinkedin;
      Instagram.text = widget.profile.userData[0].memberInstagram == null ||
              widget.profile.userData[0].memberInstagram == ""
          ? "NA"
          : widget.profile.userData[0].memberInstagram;
      Facebook.text = widget.profile.userData[0].memberFacebook == null ||
              widget.profile.userData[0].memberFacebook == ""
          ? "NA"
          : widget.profile.userData[0].memberFacebook;
      City.text = widget.profile.userData[0].city == null ||
              widget.profile.userData[0].city == ""
          ? "NA"
          : widget.profile.userData[0].city;
      State.text = widget.profile.userData[0].state == null ||
              widget.profile.userData[0].state == ""
          ? "NA"
          : widget.profile.userData[0].state;
      Country.text = widget.profile.userData[0].country == null ||
              widget.profile.userData[0].country == ""
          ? "NA"
          : widget.profile.userData[0].country;
      CompanyPhone.text = widget.profile.userData[0].companyPhone == null ||
              widget.profile.userData[0].companyPhone == ""
          ? "NA"
          : widget.profile.userData[0].companyPhone;
      CompanyEmail.text = widget.profile.userData[0].companyEmail == null ||
              widget.profile.userData[0].companyEmail == ""
          ? "NA"
          : widget.profile.userData[0].companyEmail;
      cinNumber.text = widget.profile.userData[0].cin == null ||
              widget.profile.userData[0].cin == ""
          ? "NA"
          : widget.profile.userData[0].cin;
      aadharnumber.text = widget.profile.userData[0].aadhar == null ||
              widget.profile.userData[0].aadhar == ""
          ? "NA"
          : widget.profile.userData[0].aadhar;
      gstnumber.text = widget.profile.userData[0].gstnumber == null ||
              widget.profile.userData[0].gstnumber == ""
          ? "NA"
          : widget.profile.userData[0].gstnumber;
    });
  }

  bool failed = false;
  AuthenticationBloc _authenticationBloc;
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
              child: BlocListener<EditProfileBloc, EditState>(
                listener: (context, state) {
                  if(state is EditFailed){
                    Fluttertoast.showToast(msg: state.error);
                  }else if(state is Edited){

                    Fluttertoast.showToast(msg: state.msg);
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MultiBlocProvider(
                      providers: [
                      BlocProvider<ProfileBloc>(
                        create: (BuildContext context) => ProfileBloc(),
                      ),
                       BlocProvider<BlogBloc>(
                        create: (BuildContext context) => BlogBloc(),
                      ),
                       BlocProvider<Event_Bloc>(
                        create: (BuildContext context) => Event_Bloc(),
                      ),
                      BlocProvider<News_Bloc>(
                        create: (BuildContext context) => News_Bloc(),
                      ),
                    ], child: MyHomePage()
                   
                   
                   )));
                    //_authenticationBloc=BlocProvider.of<AuthenticationBloc>(context);
                    //_authenticationBloc.add(AppStarted());
                  }
                  // TODO: implement listener
                },
                child: BlocBuilder<EditProfileBloc, EditState>(
                  builder: (context, state) {
                    if(state is EditLoading){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(state is EditInitial||state is EditFailed||state is Edited){
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
                                  if (pagecount != 1) {
                                    if (pagecount == 2) {
                                      setState(() {
                                        pagecount = 1;
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
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
                                      fontFamily: "Nunito-Bold",
                                      fontSize: 20.sp),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (pagecount != 2) {
                                    if (pagecount == 1) {
                                      setState(() {
                                        pagecount = 2;
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

                                    /*  InkWell(
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
                                                                  if (Password.text == RepeatPassword.text &&
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
                                                                    borderRadius: BorderRadius.circular(10)),
                                                                child: Text(
                                                                  "Next",
                                                                  style: TextStyle(
                                                                      fontFamily: "Nunito-Bold",
                                                                      color: Colors.white,
                                                                      fontSize: 18.sp),
                                                                ),
                                                              ),
                                                            ),*/
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
                                        /*  DropdownButtonFormField<String>(
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
                                                                      borderRadius: BorderRadius.circular(10),
                                                                    ),
                                                                  ),
                                                                  onChanged: (String newValue) {
                                                                    // print(newValue);
                                                                    setState(() {
                                                                      //  value=newValue;
                                                                      WeAreInto = newValue;
                                                                    });
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
                              
                                                                WeAreInto == null ||
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
                                                                            "We Belong To"),
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
                                                                ),*/
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
                                        /* list(FounderQualifications, text, Foundquali,
                                                                    "Founder Qualification"),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),
                                                                list(Certificate, text, QMC,
                                                                    "Quality management certification"),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),*/
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
                                        /*  Align(
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
                                                                                    source:
                                                                                        ImageSource.gallery);
                                                                            print(image.path);
                                                                            if (image.path != null) {
                                                                              File croppedFile = await ImageCropper
                                                                                  .cropImage(
                                                                                      sourcePath: image.path,
                                                                                      aspectRatioPresets: [
                                                                                        CropAspectRatioPreset
                                                                                            .square,
                                                                                      ],
                                                                                      androidUiSettings:
                                                                                          AndroidUiSettings(
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
                                                                                logo = croppedFile;
                                                                              });
                                                                            }
                                                                          },
                                                                          child: Icon(LineIcons.image))
                                                                      : Image.file(File(logo.path)),
                                                                ),*/
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        /* InkWell(
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
                                                                ),*/
                                      ],
                                    )
                                  : Column(
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
                                        /* Align(
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
                                                                    ),*/
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

                                        /* Align(
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
                                                                    ),*/
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
                                        /* Align(
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
                                                                    ),*/

                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        /* InkWell(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          pagecount = 3;
                                                                        });
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
                                                                    ),*/
                                      ],
                                    ),

                          InkWell(
                            onTap: () {
                              if (BussinessName.text.isNotEmpty &&
                                  TurnOver.text.isNotEmpty &&
                                  NoofEmployees.text.isNotEmpty &&
                                  YearofEstablishment.text.isNotEmpty &&
                                  IndustryType.text.isNotEmpty &&
                                  PAN.text.isNotEmpty &&
                                  CompanyInfo.text.isNotEmpty &&
                                  Website.text.isNotEmpty &&
                                  Linkedin.text.isNotEmpty &&
                                  Instagram.text.isNotEmpty &&
                                  Facebook.text.isNotEmpty &&
                                  City.text.isNotEmpty &&
                                  State.text.isNotEmpty &&
                                  Country.text.isNotEmpty &&
                                  CompanyEmail.text.isNotEmpty &&
                                  CompanyPhone.text.isNotEmpty &&
                                  cinNumber.text.isNotEmpty &&
                                  aadharnumber.text.isNotEmpty &&
                                  gstnumber.text.isNotEmpty) {

                                    print(Email.text);
                                    if(Email.text.isNotEmpty){
                                      print("in");
                                          if (RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(Email.text)) {
                                        setState(() {
                                          _Email =
                                              "Please provide valid email address";
                                        });
                                      }else{
                                        _editProfileBloc =
                                    BlocProvider.of<EditProfileBloc>(context);
                                _editProfileBloc.add(OnEditPress(
                                  id: widget.profile.userData[0].memberId,
                                    companyname: BussinessName.text,
                                    membertype: "",
                                    last_year_turn_over: TurnOver.text,
                                    no_of_employees: NoofEmployees.text,
                                    year_of_establishment:
                                        YearofEstablishment.text,
                                    scale: IndustryType.text,
                                    pan: PAN.text,
                                    gstnumber: gstnumber.text,
                                    founder_qual:
                                        widget.profile.userData[0].founderQual!=null|| widget.profile.userData[0].founderQual!=" "? widget.profile.userData[0].founderQual:"NA",
                                    qual_mgmt: "",
                                    company_address: "",
                                    company_city: City.text,
                                    company_state: State.text,
                                    company_country: Country.text,
                                    company_phone: CompanyPhone.text,
                                    company_email: CompanyEmail.text,
                                    company_description: CompanyInfo.text,
                                    memshiptype: " ",
                                    member_website: Website.text,
                                    member_linkedin: Linkedin.text,
                                    member_facebook: Facebook.text,
                                    member_instagram: Instagram.text,
                                    aadhaarnumber: aadharnumber.text,
                                    cinnumber: cinNumber.text,
                                    import_export: "",
                                    Weareinto: "",
                                    webelongto: "",
                                    industryType: IndustryType.text));

                                      }
                                    }else{
                                      _editProfileBloc =
                                    BlocProvider.of<EditProfileBloc>(context);
                                _editProfileBloc.add(OnEditPress(
                                  id: widget.profile.userData[0].memberId,
                                    companyname: BussinessName.text,
                                    membertype: "",
                                    last_year_turn_over: TurnOver.text,
                                    no_of_employees: NoofEmployees.text,
                                    year_of_establishment:
                                        YearofEstablishment.text,
                                    scale: IndustryType.text,
                                    pan: PAN.text,
                                    gstnumber: gstnumber.text,
                                    founder_qual:
                                        widget.profile.userData[0].founderQual!=null|| widget.profile.userData[0].founderQual!=" "? widget.profile.userData[0].founderQual:"NA",
                                    qual_mgmt: "",
                                    company_address: "",
                                    company_city: City.text,
                                    company_state: State.text,
                                    company_country: Country.text,
                                    company_phone: CompanyPhone.text,
                                    company_email: CompanyEmail.text,
                                    company_description: CompanyInfo.text,
                                    memshiptype: " ",
                                    member_website: Website.text,
                                    member_linkedin: Linkedin.text,
                                    member_facebook: Facebook.text,
                                    member_instagram: Instagram.text,
                                    aadhaarnumber: aadharnumber.text,
                                    cinnumber: cinNumber.text,
                                    import_export: "",
                                    Weareinto: "",
                                    webelongto: "",
                                    industryType: IndustryType.text));
                                    }
                                    
                                
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Field cannot be empty please fill every field");
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                  color: MainColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Update",
                                style: TextStyle(
                                    fontFamily: "Nunito-Bold",
                                    color: Colors.white,
                                    fontSize: 18.sp),
                              ),
                            ),
                          ),
                          // Textfield(_Name, Name, "Name",Icons.person_outline),
                        ],
                      ),
                    );
                    }
                    return Center(child: CircularProgressIndicator(),);
                   
                
                
                  },
                ),
              ))),
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
      bottomNavigationBar: Container(),
    );
  }
}
