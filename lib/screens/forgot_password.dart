
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mia_app/Bloc/ForgotPassword/forgot_passwordBloc.dart';

import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/screens/forgotpassword2.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class ForgotPassword extends StatefulWidget {
 

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String mobileno;
  var loading = false;
  var error = false;
  var userexception = '';
  var _resend_otp;
  String otpcode;
  String vid;
  var change = false;
  var firebase = FirebaseAuth.instance;
  var merr;
  var CountryCode;
  Widget EditTextField(
    controller,
    err,
    Icon,
    label,
  ) {
    return Container(
      decoration: BoxDecoration(),
      child: TextField(
        onChanged: (controller) {
          setState(() {
            controller = controller;
          });
        },
        keyboardType: TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontFamily: "Nunito-Bold"),
            errorText: err,
            prefixIcon: Icon),
        style: TextStyle(fontFamily: "Nunito-Bold"),
      ),
    );
  }

  TextEditingController num = new TextEditingController();
  // TextEditingController fee2 = new TextEditingController();
  var _fee = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(20),
        child: loading != false
            ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Container(
                       
                        width:40.w,
                        height: 40.h,
                        color: Colors.white,
                        child:CircularProgressIndicator(),
                      ),
                    
                ],
              ),
            )
            : error != true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      change == false
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "Forgot password",
                                  style: TextStyle(
                                      fontFamily: "Nunito-Bold",
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "Please Enter Email Address",
                                  style: TextStyle(
                                      fontFamily: "Nunito-Light",
                                      fontSize: 16.sp),
                                ),
                                SizedBox(
                                  height: 40.h,
                                ),
                               // EditTextField(num, merr, Icon(MdiIcons.phone),

                                  // "Mobile no"),
                                  TextField(
                                                  controller: num,
                                                  
                                                  
    decoration: InputDecoration(
       errorText: merr,
        labelText: 'Email ID',
        border: OutlineInputBorder(
            borderSide: BorderSide(),
        ),
    ),
    
    onChanged: (phone) {
      setState(() {
        merr=null;
        
      });
        
         
          
                
    },
),
                                SizedBox(
                                  height: 40.h,
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (num.text != '' 
                                        ) {
                                      setState(() {
                                        mobileno = num.text;
                                       // loading = true;
                                        change=true;
                                      });
                                     
                                     setState(() {
                                       change=true;
                                     });
                                    } else {
                                      setState(() {
                                        merr =
                                            "Please Provide vaild Email Address";
                                        loading = false;
                                      });
                                    }
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                               MainColor
                                                    .withOpacity(0.6),
                                                MainColor
                                                    .withOpacity(0.7),
                                                MainColor
                                                    .withOpacity(0.8),
                                                MainColor
                                                    .withOpacity(0.9),
                                              ])),
                                      child: Text(
                                        "Change",
                                        style: TextStyle(
                                            fontFamily: "Nunito-Bold",
                                            color: Colors.white,
                                            fontSize: 18.sp),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Text(
                                  "Forgot password",
                                  style: TextStyle(
                                      fontFamily: "Nunito-Bold",
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  "The update requires email otp",
                                  style: TextStyle(
                                      fontFamily: "Nunito-Light",
                                      fontSize: 16.sp),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PinCodeTextField(
                                   mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                               animationType: AnimationType.fade,
                                               animationDuration: Duration(milliseconds: 300),
                                                onCompleted:
                                                    (String verificationCode) {
                                                  setState(() {
                                                    otpcode = verificationCode;
                                                  });
                                                  print(otpcode);
                                                }, appContext: context,
                                                 onChanged: (String value) {  }, 
                                                 length: 6, // end o
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      "Didn't receive a code?",
                                      style: TextStyle(
                                          fontFamily: 'Nunito-Regular',
                                          color: Colors.black,
                                          fontSize: 12.sp),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                       Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (context) =>
                                                          ForgotPassBloc(),
                                                      child: Forgot_pass_ield(number: mobileno,),
                                                    )));
                                      },
                                      child: Text(
                                        "RESEND OTP",
                                        style: TextStyle(
                                            fontFamily: 'Nunito-Bold',
                                            color: Colors.green,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // print(otpcode.length);
                                  
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (context) =>
                                                          ForgotPassBloc(),
                                                      child: Forgot_pass_ield(number: mobileno,),
                                                    )));
                                       
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 10.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            MainColor.withOpacity(0.8),
                                            MainColor.withOpacity(0.7),
                                            MainColor.withOpacity(0.6),
                                            MainColor.withOpacity(0.5),
                                            MainColor.withOpacity(0.4),
                                          ],
                                        )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Verify",
                                          style: TextStyle(
                                              fontFamily: 'Nunito-Bold',
                                              color: Colors.white,
                                              fontSize: 18.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  )
                : SafeArea(
                    child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline,color: Colors.red,size: 48.sp,),
                        SizedBox(height: 10.h,),
                        Text(userexception,style: TextStyle(fontFamily: "Nunito-Bold"),),
                        SizedBox(height: 10.h,),
                        GestureDetector(
                          onTap: (){
                            Navigator.popUntil(context, (route) => route.isFirst);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                             color: MainColor,
                             borderRadius: BorderRadius.circular(4)
                        
                            ),
                            child: Text("okay",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white),),
                          ),
                        ),

                      ],
                    ),
                  )),
      )),
    );
  }
}
