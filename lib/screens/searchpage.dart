import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Bloc.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Event.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-State.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/common/profile-shimmer.dart';
import 'package:mia_app/screens/memberlistview.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  MemberListBloc memberListBloc;
  TextEditingController search= new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memberListBloc=BlocProvider.of<MemberListBloc>(context);
    memberListBloc.add(FetchMemberList());

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope( onWillPop: (){
      Navigator.popUntil(context, (route) => route.isFirst);
    },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Search Anything",
            style: TextStyle(fontFamily: "Nunito-Bold", color: Colors.black),
          ),
          elevation: 0,
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              BlocListener<MemberListBloc, MemberListState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                child: BlocBuilder<MemberListBloc, MemberListState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if(state is MemberListLoaded){
                       return Expanded(
                         child: Column(
                                             children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: search,
                              onChanged: (String){
                                //print(String);
                                 memberListBloc=BlocProvider.of<MemberListBloc>(context);
                             memberListBloc.add(SearchMemberList(String));
                           
                              },
                              decoration: InputDecoration(
                                  
                                  hintText: "Search here",
                                  hintStyle: TextStyle(fontFamily: "Nunito-Bold"),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: state.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                     Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MemberListProfilepage(state.data[index])));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                    height: 100.h,
                                    child: 
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 80.w,
                                              height: 80.h,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: state.data[index].imgName!=null && state.data[index].imgName!="" ?NetworkImage(ApiBase.imgmember+ state.data[index].imgName)
                                                        :AssetImage("assets/images/blank.png"),
                                                      fit: BoxFit.contain)),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                 
                                                   Flexible(
                                                     child: Container(
                                                       width: 180.w,
                                                       child: RichText(
                                                          strutStyle: StrutStyle(fontSize: 12.0),
                                                         overflow: TextOverflow.ellipsis,
                                                         maxLines: 1,
                                                         text: TextSpan(
                                                           
                                                            text:  state.data[index].memberName!=null?state.data[index].memberName:"",
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontFamily: "Nunito-Bold",
                                                                  fontSize: 16.sp),
                                                            
                                                            
                                                             
                                                          ),
                                                       ),
                                                     ),
                                                   ),
                                                 
                                                
                                                 Flexible(
                                                    child: Container(
                                                      width: 180.w,
                                                      child: RichText(
                                                         strutStyle: StrutStyle(fontSize: 12.0),
                                                          overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                            text:  state.data[index].email!=null?state.data[index].email:"",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                                fontFamily: "Nunito-Regular",
                                                                fontSize: 14.sp,
                                                                ),
                                                              
                                                          ),
                                                      ),
                                                    ),
                                                  ),
                                                  
                                                
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_pin,
                                                      color: MainColor,
                                                    ),
                                                    Text(
                                                      state.data[index].city!=null?state.data[index].city:"",
                                                      style: TextStyle(
                                                          fontFamily: "Nunito-Regular",
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                             Icon(
                                            Icons.arrow_forward_ios,
                                            color: MainColor,
                                            size: 20.sp,
                                          )
                                          ],
                                        ),
                                       
                                      
                                  ),
                                ),
                              );
                                  }))
                                             ],
                                           ),
                       );
                    }else if(state is MemberListLoading){
                      return Expanded(
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ProileShimmer();
                                }));
                    }else if(state is MemberListInitial){
                       return Expanded(
                            child: ListView.builder(
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return ProileShimmer();
                                }));
                    }else if(state is MemberListfailure){
                      return Center(child: Text(state.error));
                    }else if(state is MemberListSearch){
    
                        return  Expanded(
                          child: Column(
                                              children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              controller: search,
                              onChanged: (String){
                                //print(String);
                                 memberListBloc=BlocProvider.of<MemberListBloc>(context);
                              memberListBloc.add(SearchMemberList(String));
                            
                              },
                              decoration: InputDecoration(
                                  
                                  hintText: "Search here",
                                  hintStyle: TextStyle(fontFamily: "Nunito-Bold"),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search)),
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: state.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                     Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MemberListProfilepage(state.data[index])));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                    height: 100.h,
                                    child: 
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 80.w,
                                              height: 80.h,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: state.data[index].imgName!=null && state.data[index].imgName!="" ?NetworkImage(ApiBase.imgmember+ state.data[index].imgName)
                                                        :AssetImage("assets/images/blank.png"),
                                                      fit: BoxFit.contain)),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                 
                                                   Flexible(
                                                     child: Container(
                                                       width: 180.w,
                                                       child: RichText(
                                                          strutStyle: StrutStyle(fontSize: 12.0),
                                                         overflow: TextOverflow.ellipsis,
                                                         maxLines: 1,
                                                         text: TextSpan(
                                                           
                                                            text:  state.data[index].memberName!=null?state.data[index].memberName:"",
                                                              style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontFamily: "Nunito-Bold",
                                                                  fontSize: 16.sp),
                                                            
                                                            
                                                             
                                                          ),
                                                       ),
                                                     ),
                                                   ),
                                                 
                                                
                                                 Flexible(
                                                    child: Container(
                                                      width: 180.w,
                                                      child: RichText(
                                                         strutStyle: StrutStyle(fontSize: 12.0),
                                                          overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                            text:  state.data[index].email!=null?state.data[index].email:"",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                                fontFamily: "Nunito-Regular",
                                                                fontSize: 14.sp,
                                                                ),
                                                              
                                                          ),
                                                      ),
                                                    ),
                                                  ),
                                                  
                                                
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_pin,
                                                      color: MainColor,
                                                    ),
                                                    Text(
                                                      state.data[index].city!=null?state.data[index].city:"",
                                                      style: TextStyle(
                                                          fontFamily: "Nunito-Regular",
                                                          fontSize: 14.sp),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                             Icon(
                                            Icons.arrow_forward_ios,
                                            color: MainColor,
                                            size: 20.sp,
                                          )
                                          ],
                                        ),
                                       
                                      
                                  ),
                                ),
                              );
                                  }))
                                              ],
                                            ),
                        ); 
                    }else if(state is MemberListSearchInfo){
                      return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10))
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: search,
                            onChanged: (String){
                              //print(String);
                               memberListBloc=BlocProvider.of<MemberListBloc>(context);
                           memberListBloc.add(SearchMemberList(String));
    
                            },
                            decoration: InputDecoration(
                                
                                hintText: "Search here",
                                hintStyle: TextStyle(fontFamily: "Nunito-Bold"),
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search)),
                          ),
                        ),
                        SizedBox(height: 100.h,),
                        Center(
                          child: Text(state.info),
                        ),
                      ],
                    ); 
                    }
                    
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
