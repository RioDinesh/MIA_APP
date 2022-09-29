import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-Bloc.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Bloc.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/modal/BlogList-modal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mia_app/screens/Eventslistview.dart';
import 'package:mia_app/screens/MoreMenu.dart';
import 'package:mia_app/screens/bussinesslistview.dart';
import 'package:mia_app/screens/searchpage.dart';
class ReadMore extends StatefulWidget {
  final BlogData blogData;
  ReadMore({@required this.blogData});
  @override
  _ReadMoreState createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Blog",style: TextStyle(fontFamily: "Nunito-Regular",color: Colors.black),),
      ),
      body: SafeArea(
        child: Container(
          
          width: size.width,
          height: size.height,

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                  Container(
                      padding:  EdgeInsets.all(10),
                    decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 20,
                                          offset: Offset(0, 2))
                                    ],
                             borderRadius: BorderRadius.circular(10),
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h,),
                          Container(
                            
                            padding: EdgeInsets.all(10),
                            height: 200.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            blurRadius: 20,
                                            offset: Offset(0, 2))
                                      ],
                               borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(ApiBase.imgblog+widget.blogData.blogImage),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          SizedBox(height: 10.h,),
                         
                              
                              Text("Author : "+widget.blogData.blogAuthor,style: TextStyle(fontFamily: "Nunito-Bold",fontSize: 14.sp,color: MainColor),),
                              Text("Date : "+widget.blogData.createdAt.substring(0,11),style: TextStyle(fontFamily: "Nunito-Light",fontSize: 12.sp,color: MainColor),)
                          
                        ],
                      ),
                    ),
                  
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 2))
                                ],
                         borderRadius:BorderRadius.circular(20),),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Container(
                          
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color:MainColor)),
                          ),
                          child: Text(widget.blogData.blogTitle,style: TextStyle(fontFamily: "Nunito-Bold",fontSize: 18.sp),)),
                      
                 SizedBox(
                       height: 10.h,
                 ),
                      Text(widget.blogData.description,style: TextStyle(fontFamily: "Nunito-Light"),),
                        ],
                      ),
                    ),
                  ),
                 
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
    );
  }
}