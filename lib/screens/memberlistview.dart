import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-Bloc.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Bloc.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/modal/Member-profile.dart';
import 'package:mia_app/screens/Eventslistview.dart';
import 'package:mia_app/screens/MoreMenu.dart';
import 'package:mia_app/screens/bussiness.dart';
import 'package:mia_app/screens/bussinesslistview.dart';
import 'package:mia_app/screens/profileview.dart';
import 'package:mia_app/screens/searchpage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MemberListProfilepage extends StatefulWidget {
 final UserDatas profile;
 MemberListProfilepage(@required this.profile);
  @override
  _MemberListProfilepageState createState() => _MemberListProfilepageState();
}

class _MemberListProfilepageState extends State<MemberListProfilepage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Members",style: TextStyle(
          fontFamily: "Nunito-Bold",
          color: Colors.black
          
        ),),
      ),

      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
             Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 2))
                              ]),
                          width: double.infinity,
                          height: 120.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   GestureDetector(
                                     onTap: () async {
               await showDialog(
                context: context,
                builder: (_) => ImageDialog(widget.profile.imgName)
                           );
            },
                                     child: Container(
                                      width: 80.w,
                                      height: 80.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: widget.profile.imgName!=null && widget.profile.imgName!="" ?NetworkImage(ApiBase.imgmember+ widget.profile.imgName)
                                              :AssetImage("assets/images/blank.png"),
                                              fit: BoxFit.cover)),
                                                                     ),
                                   ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Flexible(
                                           child: Container(
                                             width: 220.w,
                                             child: Wrap(
                                               children: [
                                                 Text(
                                                    widget.profile.memberName!=null?widget.profile.memberName:"",
                                                    style: TextStyle(
                                                        fontFamily: "Nunito-Bold",
                                                        fontSize: 18.sp,
                                                        color: MainColor
                                                        ),
                                                  ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       
                                      
                                       Flexible(
                                         child: Container(
                                           width: 220.w,
                                           child: Wrap(
                                             
                                             children: [
                                               Text(
                                                  widget.profile.email!=null?widget.profile.email:"",
                                                  style: TextStyle(
                                                      fontFamily: "Nunito-Regular",
                                                      fontSize: 14.sp),
                                                ),
                                             ],
                                           ),
                                         ),
                                       ),
                                      
                                      
                                    ],
                                  ),
                                ],
                              ),

                              
                            ],
                          ),
                        ),
                      ),
                       
                       SizedBox(height: 20.h,),
                      Expanded(child: Container(
                         padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 2))
                              ]),
                          width: double.infinity,

                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(" City",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.city!=null &&widget.profile.city!="" ?widget.profile.city:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                              Text(" State",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.state!=null &&widget.profile.state!="" ?widget.profile.state:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                              SizedBox(height: 10,),
                              Text(" Country",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.country!=null &&widget.profile.country!="" ?widget.profile.country:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                              SizedBox(height: 10,),
                              Text(" Mobile",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.mobile!=null &&widget.profile.mobile!="" ?widget.profile.mobile:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                              SizedBox(height: 10,),
                              Text(" Website",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.memberWebsite!=null &&widget.profile.memberWebsite!="" ?widget.profile.memberWebsite:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                               SizedBox(height: 10,),
                              Text(" Linkedin",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.memberLinkedin!=null &&widget.profile.memberLinkedin!="" ?widget.profile.memberLinkedin:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                               SizedBox(height: 10,),
                              Text(" Instagram",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.memberInstagram!=null &&widget.profile.memberInstagram!="" ?widget.profile.memberInstagram:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                               SizedBox(height: 10,),
                              Text(" Facebook",style: TextStyle(
                                fontFamily: "Nunito-Bold",
                                fontSize: 16.sp,
                                color: MainColor,
                              ),),
                              SizedBox(height: 1,),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MainColor.withOpacity(0.1)
                                ),
                                child: Text(widget.profile.memberFacebook!=null &&widget.profile.memberFacebook!="" ?widget.profile.memberFacebook:"NA",style: TextStyle(
                                 fontFamily: "Nunito-Bold"
                        
                                ),),
                              ),
                            ],
                          ),
                        ),

                      ))
            ],
        ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: MainColor,
                boxShadow: [
                  BoxShadow(
                      color: MainColor.withOpacity(0.2),
                      blurRadius: 20,
                      offset: Offset(0, 2))
                ]),
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => MemberListBloc(),
                                      child: Searchpage(),
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                     MaterialButton(
                      minWidth: 20.w,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Eventslist_view()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white,
                          ),
                          Text(
                            'Events',
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => BussinessListBloc(),
                                      child: BussinessSearchpage(),
                                    )));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_city,
                            color: Colors.white,
                          ),
                          Text(
                            'Business',
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreMenu()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                          Text(
                            'More',
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class ImageDialog extends StatelessWidget {
  String image;
  ImageDialog(this.image);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent.withOpacity(0.0),
      child: Container(
         width: 400.w,
         height: 400.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            
            image: image !=null &&image!=""?NetworkImage(ApiBase.imgmember+ image):AssetImage("assets/images/blank.png"),
            fit: BoxFit.contain
            
          )
        ),
      ),
    );
  }
}