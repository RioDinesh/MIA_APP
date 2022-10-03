import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-Bloc.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Bloc.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/screens/Eventslistview.dart';
import 'package:mia_app/screens/More.dart';
import 'package:mia_app/screens/bussinesslistview.dart';
import 'package:mia_app/screens/searchpage.dart';
class MoreMenu extends StatefulWidget {
  

  @override
  _MoreMenuState createState() => _MoreMenuState();
}

class _MoreMenuState extends State<MoreMenu> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 14.h,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                   height: size.height *0.70,
                   width: size.width,
                   decoration: BoxDecoration(
                     color: MainColor,
                     borderRadius: BorderRadius.circular(20)
                   ),
                   child: Column(
                     children: [
                         Container(
                           padding: EdgeInsets.all(10),
                           child: Text("MIA",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 40.sp),)),
                           Divider(color: Colors.white,),
                           Expanded(child: Container(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.Management,name:"Managing Council" ,)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("Managing Council",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.Women_Entrepreneurship,name:"Women Entrepreneuship (AWE)" ,)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("Women Entrepreneuship (AWE)",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.Institutional_Tieups,name: "Institutional Tie Ups",)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("Institutional Tie Ups",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.Startup_Support,name: "Startup Support",)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("Startup Support",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.Membership_Drive,name: "Events & Memberships",)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("Events & Memberships",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.CSR_Activities,name: "CSR & Fundraising",)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("CSR & Fundraising",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.Business_Networking,name: "Business Network (BNM)",)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("Business Network (BNM)",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                                 InkWell(
                                   onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: ApiBase.Web_Event,name: "Events",)));
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(4),
                                     child: Text("Events",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.white,fontSize: 18.sp),),
                                   ),
                                 ),
                               ],
                             ),
                           )),
                           Divider(color: Colors.white,),
                           SizedBox(height: 10.h,)
                     ],
                   ),
                 ),
               ),
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
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreMenu()));
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