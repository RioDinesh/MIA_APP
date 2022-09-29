import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:mia_app/Bloc/GetWe/weAreInto_Bloc.dart';

import 'package:mia_app/Bloc/Login-bloc/Login-Bloc.dart';
import 'package:mia_app/Bloc/Login-bloc/Login-Event.dart';
import 'package:mia_app/Bloc/Login-bloc/Login-state.dart';
import 'package:mia_app/Bloc/Register-Bloc/register_Bloc.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/screens/Register.dart';
import 'package:mia_app/screens/dashboad.dart';
import 'package:mia_app/screens/forgot_password.dart';

class Login_Page extends StatefulWidget {
  @override
  _Login_PageState createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _email = false;
  bool _password = false;
  bool _showpassword = true;
  _onlogin() {
    if (email.text.isNotEmpty || password.text.isNotEmpty) {
      setState(() {
        // _email=false;
        _password = false;
      });
      if (RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email.text)) {
        setState(() {
          _email = false;
          // _password=false;
        });
        BlocProvider.of<LoginBloc>(context).add(
            LoginButtonPressed(email: email.text, password: password.text));
      } else {
        setState(() {
          _email = true;
        });
      }
    } else {
      setState(() {
        _email = true;
        _password = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is LoginFailure) {
                  print("ok");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.error,
                            style: TextStyle(
                                fontFamily: "Nunito-Bold", color: Colors.red),
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Colors.red,
                          )
                        ],
                      ),
                      backgroundColor: Colors.white,
                    ),
                  );
                }
              },
              child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: size.height * 0.44,
                        //color: Colors.blueAccent,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              hex.withOpacity(0.8),
                              MainColor.withOpacity(0.7),
                              MainColor.withOpacity(0.6),
                              MainColor.withOpacity(0.5),
                              MainColor.withOpacity(0.4),
                            ])),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/logo.png',
                                    fit: BoxFit.contain,
                                    width: 48,
                                    height: 48,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Text("MIA",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Bold",
                                          color: Colors.white,
                                          fontSize: 32.sp)),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text("Propelling Entrepreneurship to New Heights",
                                  style: TextStyle(
                                      fontFamily: "Nunito-Regular",
                                      color: Colors.white,
                                      fontSize: 20.sp)),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 200,
                        left: 20,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          width: size.width * 0.90,
                          height: size.height * 0.50,
                          //color: Colors.white,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.blueAccent))),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: "Nunito-Bold",
                                      fontSize: 20.sp),
                                ),
                              ),
                              SizedBox(
                                height: 50.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(
                                            10)) //BorderRadius.circular(10)
                                    ),
                                child: TextField(
                                  controller: email,
                                  decoration: InputDecoration(
                                    errorText: _email == true
                                        ? "Please Provide valid email"
                                        : null,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: MainColor,
                                    ),
                                    labelText: "Email Address",
                                    labelStyle: TextStyle(
                                        fontFamily: "Nunito-Bold",
                                        fontSize: 14.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(
                                            10)) //BorderRadius.circular(10)
                                    ),
                                child: TextField(
                                  obscureText: _showpassword,
                                  controller: password,
                                  decoration: InputDecoration(
                                    errorText: _password == true
                                        ? "Please Provide Password"
                                        : null,
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: MainColor,
                                    ),

                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          print("show");
                                          if (_showpassword == true) {
                                            setState(() {
                                              _showpassword = false;
                                            });
                                          } else {
                                            setState(() {
                                              _showpassword = true;
                                            });
                                          }
                                        },
                                        icon: _showpassword != true
                                            ? Icon(Icons.visibility_outlined)
                                            : Icon(
                                                Icons.visibility_off_outlined)),
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                        fontFamily: "Nunito-Bold",
                                        fontSize: 14.sp),
                                    // disabledBorder: new InputBorder(borderSide: )
                                    //border: InputBorder.none//OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    onTap:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                                    },
                                    child: Text(
                                      "Forgot password",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Regular",
                                          fontSize: 12.sp,
                                          color: MainColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 450.h,
                          left: 154.w,
                          child: FloatingActionButton(
                            backgroundColor: MainColor,
                            onPressed: () {
                              _onlogin();

                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));*/
                            },
                            child: state is LoginLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Icon(Icons.arrow_forward),
                          )),
                     /* Positioned(
                        top: 580.h,
                        left: 90.w,
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                "Don't have accouct",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Nunito-Regular",
                                    fontSize: 14.sp),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MultiBlocProvider(
                                                providers: [
                                                  BlocProvider(
                                                    create: (context) =>
                                                        RegisterBloc(),
                                                  ),
                                                  BlocProvider(
                                                    create: (context) =>
                                                        WeAreIntoBloc(),
                                                  ),
                                                ],
                                                child: RegisterPage(),
                                              )));
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      color: MainColor,
                                      fontFamily: "Nunito-Bold",
                                      fontSize: 16.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),*/
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
