import 'package:carousel_slider/carousel_slider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    Divider(
                      thickness: 1,
                    ),
                  /*  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MainColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 2))
                              ]),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              //borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    Center(
                                      child: Text(
                                        "Next Meeting",
                                        style: TextStyle(
                                            fontFamily: "Nunito-Regular",
                                            fontSize: 16.sp),
                                      ),
                                    ),
                                    Icon(
                                      Icons.visibility_outlined,
                                      color: MainColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Tuesday,Septem,21,2021",
                                  style: TextStyle(
                                      fontFamily: "Nunito-Bold",
                                      fontSize: 18.sp,
                                      color: MainColor),
                                ),
                              ],
                            ),
                          )),
                    ),
                    */
                    
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          //height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MainColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 2))
                              ]),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            //height: 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              //borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Text(
                                      "Mia India",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Regular",
                                          fontSize: 16.sp),
                                    ),
                                    Icon(
                                      Icons.business_sharp,
                                      color: MainColor,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1, color: MainColor)),
                                          child: Icon(
                                            Icons.person_outline,
                                            color: MainColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Members",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "344",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Bold",
                                          color: MainColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1, color: MainColor)),
                                          child: Icon(
                                            Icons.work_outline,
                                            color: MainColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Turnover in Crores",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "47.76",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Bold",
                                          color: MainColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1, color: MainColor)),
                                          child: Icon(
                                            Icons.location_city_outlined,
                                            color: MainColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Business Firms",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "23",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Bold",
                                          color: MainColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1, color: MainColor)),
                                          child: Icon(
                                            Icons.emoji_emotions_outlined,
                                            color: MainColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Work Force",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "2",
                                      style: TextStyle(
                                          fontFamily: "Nunito-Bold",
                                          color: MainColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                    BlocListener<BlogBloc, BlogState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      child: BlocBuilder<BlogBloc, BlogState>(
                        // ignore: missing_return
                        builder: (context, state) {
                          if(state is BlogLoading){
                            return CircularProgressIndicator();
                          }else if(state is BlogFailue){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Divider(),
                                    Text("Latest Blog",style: TextStyle(fontFamily: "Nunito-Bold"),),
                                    Icon(Icons.info_outline,color: Colors.red,),
                                    Text(
                                              state.error,
                                              style: TextStyle(
                                                  fontFamily: "Nunito-Light",
                                                  fontSize: 12.sp),
                                            ),
                                            Divider(),
                                  ],
                                ),
                              ),
                            );
                          }else if(state is BlogLoaded){
                            
                             return SizedBox(
                            width: 390.w,
                            height: 330.h,
                            child: CarouselSlider.builder(
                              itemCount: state.blog.length,
                              itemBuilder:
                                  (BuildContext context, index, int pageViewIndex) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    height: 220.h,
                                    width: 390.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MainColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 20,
                                              offset: Offset(0, 2))
                                        ]),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(60),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        //borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 0,
                                              ),
                                              Text(
                                                "Latest Blog",
                                                style: TextStyle(
                                                    fontFamily: "Nunito-Regular",
                                                    fontSize: 16.sp),
                                              ),
                                              Icon(
                                                Icons.message_outlined,
                                                color: MainColor,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Container(
                                            width: double.infinity / 1,
                                            height: 140.h,
                                            // padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                //color: Colors.purple.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        ApiBase.imgblog+state.blog[index].blogImage),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Divider(),
                                          Text(
                                            state.blog[index].blogTitle,
                                            style: TextStyle(
                                                fontFamily: "Nunito-Bold",
                                                fontSize: 16.sp),
                                          ),
                                           Text(
                                           state.blog[index].description!=""&&state.blog[index].description!=null? state.blog[index].description.substring(0,20)+"...":"...",
                                            style: TextStyle(
                                                fontFamily: "Nunito-Light",
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReadMore(blogData: state.blog[index],)));
                                            },
                                            child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: MainColor),
                                                    borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  child: Text(
                                                    "Read More",
                                                    style: TextStyle(
                                                        fontFamily: "Nunito-Bold",
                                                        color: MainColor),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              options: CarouselOptions(
                                autoPlay: true,
                                height: 300.h,
                              ),
                            ),
                          );
                          }
                        
                          
                        },
                      ),
                    ),
    
                    BlocListener<Event_Bloc, EventState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      child: BlocBuilder<Event_Bloc, EventState>(
                        // ignore: missing_return
                        builder: (context, state) {
                          if(state is EventLoading){
                            return CircularProgressIndicator();
                          }else if(state is EventFailue){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Divider(),
                                    Text("Events",style: TextStyle(fontFamily: "Nunito-Bold"),),
                                    Icon(Icons.info_outline,color: Colors.red,),
                                    Text(
                                              state.error,
                                              style: TextStyle(
                                                  fontFamily: "Nunito-Light",
                                                  fontSize: 12.sp),
                                            ),
                                            Divider(),
                                  ],
                                ),
                              ),
                            );
                          }else if(state is EventLoaded){
                            
                             return SizedBox(
                           // width: 390.w,
                            height: 320.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.Event.length,
                              itemBuilder:
                                  (context ,index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    height: 240.h,
                                    width: 340.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MainColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 20,
                                              offset: Offset(0, 2))
                                        ]),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(60),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        //borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 0,
                                              ),
                                              Text(
                                                "Events",
                                                style: TextStyle(
                                                    fontFamily: "Nunito-Regular",
                                                    fontSize: 16.sp),
                                              ),
                                              Icon(
                                                Icons.message_outlined,
                                                color: MainColor,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Container(
                                            width: double.infinity / 1,
                                            height: 140.h,
                                            // padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                //color: Colors.purple.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        ApiBase.imgblog+state.Event[index].eventImage),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Divider(),
                                          Text(
                                            state.Event[index].eventTitle,
                                            style: TextStyle(
                                                fontFamily: "Nunito-Bold",
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                            state.Event[index].description.substring(0,100)+"...",
                                            style: TextStyle(
                                                fontFamily: "Nunito-Light",
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Event_Readme(eventData: state.Event[index],)));
                                            },
                                            child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Container(
                                                   padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: MainColor),
                                                    borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  child: Text(
                                                    "Read More",
                                                    style: TextStyle(
                                                        fontFamily: "Nunito-Bold",
                                                        color: MainColor),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                             
                            ),
                          );
                          }
                        
                          
                        },
                      ),
                    ),
                    BlocListener<News_Bloc, NewsState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      child: BlocBuilder<News_Bloc, NewsState>(
                        // ignore: missing_return
                        builder: (context, state) {
                          if(state is NewsLoading){
                            return CircularProgressIndicator();
                          }else if(state is NewsFailue){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  children: [
                                    Divider(),
                                    Text("News",style: TextStyle(fontFamily: "Nunito-Bold"),),
                                    Icon(Icons.info_outline,color: Colors.red,),
                                    Text(
                                              state.error,
                                              style: TextStyle(
                                                  fontFamily: "Nunito-Light",
                                                  fontSize: 12.sp),
                                            ),
                                            Divider(),
                                  ],
                                ),
                              ),
                            );
                          }else if(state is NewsLoaded){
                            
                             return SizedBox(
                           // width: 390.w,
                            height: 320.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.News.length,
                              itemBuilder:
                                  (context ,index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    height: 200.h,
                                    width: 340.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: MainColor,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 20,
                                              offset: Offset(0, 2))
                                        ]),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(60),
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        //borderRadius: BorderRadius.only(topLeft: Radius.circular(10))
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 0,
                                              ),
                                              Text(
                                                "News",
                                                style: TextStyle(
                                                    fontFamily: "Nunito-Regular",
                                                    fontSize: 16.sp),
                                              ),
                                              Icon(
                                                Icons.message_outlined,
                                                color: MainColor,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6.h,
                                          ),
                                          Container(
                                            width: double.infinity / 1,
                                            height: 140.h,
                                            // padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                //color: Colors.purple.shade300,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        ApiBase.imgblog+state.News[index].newsImage),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Divider(),
                                          Text(
                                            state.News[index].newsTitle,
                                            style: TextStyle(
                                                fontFamily: "Nunito-Bold",
                                                fontSize: 16.sp),
                                          ),
                                          Text(
                                             state.News[index].description!=""&&state.News[index].description!=null? state.News[index].description.substring(0,100)+"...":"......",
                                            style: TextStyle(
                                                fontFamily: "Nunito-Light",
                                                fontSize: 12.sp),
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>News_Readme(newsData: state.News[index],)));
                                            },
                                            child: Align(
                                                alignment: Alignment.bottomRight,
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: MainColor),
                                                    borderRadius: BorderRadius.circular(8)
                                                  ),
                                                  child: Text(
                                                    
                                                    "Read More",
                                                    style: TextStyle(
                                                        fontFamily: "Nunito-Bold",
                                                        color: MainColor),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                             
                            ),
                          );
                          }
                        
                          
                        },
                      ),
                    ),
                    
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 180.h,
                      child: CarouselSlider.builder(
                        itemCount: obj.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          height: 140.h,
                        ),
                        itemBuilder:
                            (BuildContext context, index, int pageViewIndex) {
                          return Container(
                            padding: EdgeInsets.all(2),
                            //height: 40.h,
                            width: 260.w,
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.purple),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 2))
                              ],
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(obj[index]["img"]),
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.6),
                                    BlendMode.darken,
                                  )),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  /*Container(
                                     height: 60.h,
                                     width: double.infinity,
                                     decoration: BoxDecoration(
                                       //shape: BoxShape.circle,
                                       
                                     ),
                                   ), */
                                  Container(
                                      decoration: BoxDecoration(),
                                      child: Text(" " + obj[index]["title"],
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              color: Colors.white,
                                              fontSize: 14.sp))),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      /*Container(
                                         padding: EdgeInsets.all(4),
                                         decoration: BoxDecoration(
                                           color: MainColor,
                                           shape: BoxShape.circle
                                         ),
                                         child: Text("0",style: TextStyle(fontFamily: "Nunito-Bold"),),
                                       ),*/
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Flexible(
                                          child: Text(
                                        "is simply dummy text is simply dummy text",
                                        style: TextStyle(
                                            fontFamily: "Nunito-Regular",
                                            color: Colors.white),
                                      )),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle),
                                        child: Text(
                                          obj[index]["count"],
                                          style:
                                              TextStyle(fontFamily: "Nunito-Bold"),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.purple,
                    ),
                    /*  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 1, color: Colors.purple)),
                                child: Icon(
                                  Icons.person_outline,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "Members",
                                style: TextStyle(
                                    fontFamily: "Nunito-Bold",
                                    color: Colors.black,
                                    fontSize: 10.sp),
                              ),
                              Text(
                                "344",
                                style: TextStyle(
                                    fontFamily: "Nunito-Regular",
                                    color: Colors.black),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 1, color: Colors.purple)),
                                child: Icon(
                                  Icons.build_outlined,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "Turnover in Crores",
                                style: TextStyle(
                                    fontFamily: "Nunito-Bold",
                                    color: Colors.black,
                                    fontSize: 10.sp),
                              ),
                              Text(
                                "47.76",
                                style: TextStyle(
                                    fontFamily: "Nunito-Regular",
                                    color: Colors.black),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 1, color: Colors.purple)),
                                child: Icon(
                                  Icons.home_outlined,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "Business Firms",
                                style: TextStyle(
                                    fontFamily: "Nunito-Bold",
                                    color: Colors.black,
                                    fontSize: 10.sp),
                              ),
                              Text(
                                "23",
                                style: TextStyle(
                                    fontFamily: "Nunito-Regular",
                                    color: Colors.black),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 1, color: Colors.purple)),
                                child: Icon(
                                  Icons.emoji_emotions_outlined,
                                  color: Colors.purple,
                                ),
                              ),
                              Text(
                                "Work Force",
                                style: TextStyle(
                                    fontFamily: "Nunito-Bold",
                                    color: Colors.black,
                                    fontSize: 10.sp),
                              ),
                              Text(
                                "4",
                                style: TextStyle(
                                    fontFamily: "Nunito-Regular",
                                    color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                    ),*/
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
      ),
    );
  }
}
