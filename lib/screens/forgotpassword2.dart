
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mia_app/Bloc/ForgotPassword/forgot_passwordBloc.dart';
import 'package:mia_app/Bloc/ForgotPassword/forgot_passwordEvent.dart';
import 'package:mia_app/Bloc/ForgotPassword/forgot_passwordState.dart';

import 'package:mia_app/Utils/Apptheme.dart';


class Forgot_pass_ield extends StatefulWidget {
  final String number;
  Forgot_pass_ield({@required this.number});
  @override
  _Forgot_pass_ieldState createState() => _Forgot_pass_ieldState();
}

class _Forgot_pass_ieldState extends State<Forgot_pass_ield> {
  TextEditingController pass = new TextEditingController();
  TextEditingController cnfrm_pass = new TextEditingController();
  var _pass;
  var _cpass;
  Widget inputfield(
      {@required String hint,
      controller,
      TextInputType,
      icon,
      readonly,
      h,
      err,
      ob}) {
    return TextField(
      obscureText: ob,
      readOnly: readonly,
      controller: controller,
      keyboardType: TextInputType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: Colors.grey, width: 0)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          filled: true,
          fillColor: Colors.transparent,
          //hintText: hint,
          labelText: hint,
          hintText: h == null ? '' : h.toString().substring(0, 11),
          labelStyle:
              TextStyle(color: Colors.black, fontFamily: 'Nunito-Regular'),
          suffixIcon: icon,
          errorText: err),
      style: TextStyle(color: Colors.black, fontFamily: 'Nunito-Regular'),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.number);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child:BlocListener<ForgotPassBloc, ForgotPassState>(
                listener: (context, state) {
                  if(state is FPFail){
                     Fluttertoast.showToast(msg: state.error);
                  }
                  
                  // TODO: implement listener
                },
                child: BlocBuilder<ForgotPassBloc, ForgotPassState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if(state is FPInital ||state is FPFail){
                      return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          "Forgot password",
                          style: TextStyle(
                              fontFamily: "Nunito-Bold", fontSize: 18.sp),
                        ),
                        Text(
                          "Create new and strong password",
                          style: TextStyle(
                              fontFamily: "Nunito-Regular", fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        inputfield(
                            hint: "Password",
                            controller: pass,
                            readonly: false,
                            err: _pass,
                            ob: true),
                        SizedBox(
                          height: 14.h,
                        ),
                        inputfield(
                            hint: "confirm Password",
                            controller: cnfrm_pass,
                            readonly: false,
                            err: _cpass,
                            ob: true),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: (){
                            if(pass.text.isNotEmpty &&cnfrm_pass.text.isNotEmpty){
                              if(pass.text==cnfrm_pass.text){
                                 BlocProvider.of<ForgotPassBloc>(context).add(
                                      PostPass(pass: pass.text, number: widget.number));
                              }else{
                                Fluttertoast.showToast(msg: "Confirm password not match",gravity: ToastGravity.CENTER);
                              }

                              


                            }else{
                              Fluttertoast.showToast(msg: "Please fill all required fields",gravity: ToastGravity.CENTER);
                            }
                            
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      MainColor.withOpacity(0.6),
                                      MainColor.withOpacity(0.7),
                                      MainColor.withOpacity(0.8),
                                      MainColor.withOpacity(0.9),
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
                      ],
                    );
                    }else if(state is FPLoding){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      );
                    }else if(state is FPPosted){
                      return  Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        Icon(Icons.done_outline,color: Colors.green,size: 48.sp,),
                        SizedBox(height: 10.h,),
                        Text("Password Changed Successfully",style: TextStyle(fontFamily: "Nunito-Bold"),),
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
                    );
                      
                    }
                    
                  },
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
