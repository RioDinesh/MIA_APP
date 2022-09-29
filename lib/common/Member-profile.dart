import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Edit-Profile/Edit_Profile-Bloc.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/modal/Member-profile.dart';
import 'package:mia_app/screens/EditProfile.dart';
import 'package:mia_app/screens/memberlistview.dart';
import 'package:mia_app/screens/profileview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MemberView extends StatelessWidget {
  MemberProfile profile;
  MemberView(@required this.profile);

  @override
  Widget build(BuildContext context ) {
    
    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                           onTap: (){
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => EditProfileBloc(),
                                        child: EditProfile(
                                          profile: profile,
                                        ),
                                      )));
                           },
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
                            height: 100.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                                              image: profile.userData[0].imgName!=null && profile.userData[0].imgName!="" ?NetworkImage(ApiBase.imgmember+ profile.userData[0].imgName)
                                                :AssetImage("assets/images/blank.png"),
                                              fit: BoxFit.cover)),
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
                                               width: 180.w,
                                               child: RichText(
                                                  strutStyle: StrutStyle(fontSize: 12.0),
                                                 overflow: TextOverflow.ellipsis,
                                                 maxLines: 1,
                                                 text: TextSpan(
                                                   
                                                    text:  profile.userData[0].memberName!=null?profile.userData[0].memberName:"",
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
                                                    text:  profile.userData[0].email!=null?profile.userData[0].email:"",
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
                                              profile.userData[0].city!=null?profile.userData[0].city:"",
                                              style: TextStyle(
                                                  fontFamily: "Nunito-Regular",
                                                  fontSize: 14.sp),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                 
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: MainColor,
                                    )
                              ],
                            ),
                          ),
                        ),
                      );
  }
}

class MembersViewList extends StatelessWidget {
  List<UserDatas> profile;
  int index;
  MembersViewList(@required this.profile,@required index);

  @override
  Widget build(BuildContext context) {
    return Padding(
                        padding: const EdgeInsets.all(8.0),
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
                          height: 100.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                            image: profile[index].imgName!=null && profile[index].imgName!="" ?NetworkImage(ApiBase.imgmember+ profile[index].imgName)
                                              :AssetImage("assets/images/blank.png"),
                                            fit: BoxFit.cover)),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       Text(
                                          profile[index].memberName!=null?profile[index].memberName:"",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              fontSize: 18.sp),
                                        ),
                                      
                                      Padding(
                                        padding: EdgeInsets.only(left: 4),
                                        child: Text(
                                          profile[index].email!=null?profile[index].email:"",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Regular",
                                              fontSize: 14.sp),
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
                                            profile[index].city!=null?profile[index].city:"",
                                            style: TextStyle(
                                                fontFamily: "Nunito-Regular",
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MemberListProfilepage(profile[index])));
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: MainColor,
                                  ))
                            ],
                          ),
                        ),
                      );
  }
}