import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mia_app/Bloc/Auth-Bloc/auth.dart';
import 'package:mia_app/Bloc/Blog-Bloc/Blog-Bloc.dart';
import 'package:mia_app/Bloc/Blog-Bloc/Blog-Event.dart';
import 'package:mia_app/Bloc/Blog-Bloc/Blog-State.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-Bloc.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-Bloc.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-Event.dart';

import 'package:mia_app/Bloc/Event-bloc/Event-State.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Bloc.dart';
import 'package:mia_app/Bloc/News-bloc/news-Event.dart';
import 'package:mia_app/Bloc/News-bloc/news-State.dart';
import 'package:mia_app/Bloc/News-bloc/news-bloc.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-Bloc.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-Event.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-State.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/common/Member-profile.dart';
import 'package:mia_app/common/profile-shimmer.dart';
import 'package:mia_app/modal/Member-profile.dart';
import 'package:mia_app/screens/Eventslistview.dart';
import 'package:mia_app/screens/More.dart';
import 'package:mia_app/screens/MoreMenu.dart';
import 'package:mia_app/screens/NewsRedme.dart';
import 'package:mia_app/screens/Read_more.dart';
import 'package:mia_app/screens/bussiness.dart';
import 'package:mia_app/screens/bussinesslistview.dart';
import 'package:mia_app/screens/event_Readme.dart';
import 'package:mia_app/screens/profileview.dart';
import 'package:mia_app/screens/searchpage.dart';
final flutterWebviewPlugin = new FlutterWebviewPlugin();

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var obj = [
    {"img": "assets/images/mold.jpg", "count": "2", "title": " Iron Casting"},
    {
      "img": "assets/images/tech.jpg",
      "count": "3",
      "title": " Info technology"
    },
    {"img": "assets/images/cons.jpg", "count": "8", "title": " Construction"},
    {
      "img": "assets/images/one.jpg",
      "count": "1",
      "title": "  Additive manufacturing"
    }
  ];
  ProfileBloc profileBloc;
  BlogBloc blog;
  Event_Bloc event_bloc;
  News_Bloc news_bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
flutterWebviewPlugin.reload();
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchProfile());
    blog=BlocProvider.of<BlogBloc>(context);
    blog.add(FetchBlog());
    event_bloc=BlocProvider.of<Event_Bloc>(context);
    event_bloc.add(FetchEvent());
    news_bloc=BlocProvider.of<News_Bloc>(context);
    news_bloc.add(FetchNews());
  }
 

  @override
  Widget build(BuildContext context) {
    DateTime currentBackPressTime;
    Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "Press again to exit",toastLength: Toast.LENGTH_SHORT);
      return Future.value(false);
    }
    return Future.value(true);
  }
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Mia",
            style: TextStyle(fontFamily: "Nunito-Bold", color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                )),
                InkWell(
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      
                      Icon(
                        Icons.exit_to_app,
                        color: MainColor,
                      )
                    ],
                  )),
            ),
          ],
        ),
        body: RefreshIndicator(
          // ignore: missing_return
          onRefresh: ()async{
           await Future.delayed(Duration(milliseconds: 600));
            profileBloc = BlocProvider.of<ProfileBloc>(context);
      profileBloc.add(FetchProfile());
      blog=BlocProvider.of<BlogBloc>(context);
      blog.add(FetchBlog());
      event_bloc=BlocProvider.of<Event_Bloc>(context);
      event_bloc.add(FetchEvent());
      news_bloc=BlocProvider.of<News_Bloc>(context);
      news_bloc.add(FetchNews());
       
          },
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocListener<ProfileBloc, ProfileState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      child: BlocBuilder<ProfileBloc, ProfileState>(
                        // ignore: missing_return
                        builder: (context, state) {
                          if (state is ProfileLoading) {
                            return ProileShimmer();
                          } else if (state is ProfileLoaded) {
                            return MemberView(state.profile);
                          } else if (state is ProfileFailure) {
                            return Text(state.error);
                          } else if (state is ProfileInitial) {
                            return ProileShimmer();
                          }
                        },
                      ),
                    ),
                 SizedBox(
                  height: 20,
                 ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 20,
                      offset: Offset(0, 2))
                          ]),
                          
                      
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height*0.64,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color:MainColor,width: 4 ))
                            ),
                            child: Text("Blog",style: TextStyle(fontFamily: 'Nunito-Bold',
                                      fontSize: 22.sp,
                                      ),),
                          ),
                          SizedBox(height: 10,),
                          Image.asset('assets/images/blo.jpeg'),
                           Divider(),
                            Text("Felicitation of Mrs Khairunissa Sheikh, Executive Director World Trade Centre (Noida) held at MIA Office on 30th September",style: TextStyle(fontFamily: 'Nunito-Bold',
                                    fontSize: 18.sp,
                                    ),),
                                  SizedBox(height:20.h),
                                    Container(
                                      padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                                        ),
                
                                      child: Text("Felicitation of Mrs Khairunissa Sheikh, Executive Director World Trade Centre (Noida) held at MIA Office on 30th September 2022,Discussion took place in various topics related to women empowerment & women entrepreneurship.",style: TextStyle(fontFamily: 'Nunito-Bold',
                                     fontSize: 12.sp,
                                    ),))
                        ],
                      )
                     ),
                   )
                  
                  
                    
                  
                   
                  ],
                ),
              ),
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
                         // flutterWebviewPlugin.close();

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
                          flutterWebviewPlugin.close();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>More(url: "https://miaindia.org/category/events/",name: "Events",)));
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
                          flutterWebviewPlugin.close();
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
      ),
    );
  }
}
