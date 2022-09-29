import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-Bloc.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Bloc.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/screens/Eventslistview.dart';
import 'package:mia_app/screens/MoreMenu.dart';
import 'package:mia_app/screens/bussinesslistview.dart';
import 'package:mia_app/screens/searchpage.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
class More extends StatefulWidget {
 final String url;
 final String name;
 More({@required this.url,@required this.name}); 
 
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  
   
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(widget.name,style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.black),),
        ),
      body: SafeArea(

        child: Container(
          width: size.width,
          height: size.height,
          child: WebviewScaffold(
            
              url: widget.url,
             useWideViewPort: true,
             
            
          ),
        ),
      ),
      //floatingActionButton: FloatingActionButton(),
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
                        Navigator.pop(context);
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
                        Navigator.pop(context);
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
                        Navigator.pop(context);
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