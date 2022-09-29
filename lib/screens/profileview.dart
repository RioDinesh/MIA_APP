import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Auth-Bloc/auth.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-Bloc.dart';
import 'package:mia_app/Bloc/Edit-Profile/Edit_Profile-Bloc.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Bloc.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-Bloc.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-Event.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mia_app/common/Member-profile.dart';
import 'package:mia_app/modal/Member-profile.dart';
import 'package:mia_app/screens/EditProfile.dart';
import 'package:mia_app/screens/Eventslistview.dart';
import 'package:mia_app/screens/MoreMenu.dart';
import 'package:mia_app/screens/bussiness.dart';
import 'package:mia_app/screens/bussinesslistview.dart';
import 'package:mia_app/screens/searchpage.dart';

class ProfileView extends StatefulWidget {
  final MemberProfile profile;

  ProfileView(@required this.profile);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "My Profile",
          style: TextStyle(fontFamily: "Nunito-Bold", color: Colors.black),
        ),
        actions: [
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
                    Text(
                      "logout",
                      style: TextStyle(
                          color: MainColor, fontFamily: "Nunito-Bold"),
                    ),
                    Icon(
                      Icons.exit_to_app,
                      color: MainColor,
                    )
                  ],
                )),
          ),
        ],
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
                  //height: 120.h,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                        create: (context) => EditProfileBloc(),
                                        child: EditProfile(
                                          profile: widget.profile,
                                        ),
                                      )));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Edit",
                              style: TextStyle(
                                  color: MainColor, fontFamily: "Nunito-Bold"),
                            ),
                            Icon(
                              Icons.edit,
                              color: MainColor,
                              size: 14.sp,
                            )
                          ],
                        ),
                      ),
                      Row(
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
                                      builder: (_) => ImageDialog(
                                          widget.profile.userData[0].imgName));
                                },
                                child: Container(
                                  width: 80.w,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: widget.profile.userData[0]
                                                          .imgName !=
                                                      null &&
                                                  widget.profile.userData[0]
                                                          .imgName !=
                                                      ""
                                              ? NetworkImage(ApiBase.imgmember +
                                                  widget.profile.userData[0]
                                                      .imgName)
                                              : AssetImage(
                                                  "assets/images/blank.png"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 220.w,
                                    // padding:  EdgeInsets.only(left: 1),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          widget.profile.userData[0]
                                                      .memberName !=
                                                  null
                                              ? widget.profile.userData[0]
                                                  .memberName
                                              : "",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Bold",
                                              fontSize: 18.sp,
                                              color: MainColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 220.w,
                                    padding: EdgeInsets.only(left: 4),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          widget.profile.userData[0].email !=
                                                  null
                                              ? widget.profile.userData[0].email
                                              : "",
                                          style: TextStyle(
                                              fontFamily: "Nunito-Regular",
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " City",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].city != null &&
                                  widget.profile.userData[0].city != ""
                              ? widget.profile.userData[0].city
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
                      ),
                      Text(
                        " State",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].state != null &&
                                  widget.profile.userData[0].state != ""
                              ? widget.profile.userData[0].state
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Country",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].country != null &&
                                  widget.profile.userData[0].country != ""
                              ? widget.profile.userData[0].country
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Mobile",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].mobile != null &&
                                  widget.profile.userData[0].mobile != ""
                              ? widget.profile.userData[0].mobile
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Website",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].memberWebsite != null &&
                                  widget.profile.userData[0].memberWebsite != ""
                              ? widget.profile.userData[0].memberWebsite
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Linkedin",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].memberLinkedin != null &&
                                  widget.profile.userData[0].memberLinkedin !=
                                      ""
                              ? widget.profile.userData[0].memberLinkedin
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Instagram",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].memberInstagram != null &&
                                  widget.profile.userData[0].memberInstagram !=
                                      ""
                              ? widget.profile.userData[0].memberInstagram
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        " Facebook",
                        style: TextStyle(
                          fontFamily: "Nunito-Bold",
                          fontSize: 16.sp,
                          color: MainColor,
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MainColor.withOpacity(0.1)),
                        child: Text(
                          widget.profile.userData[0].memberFacebook != null &&
                                  widget.profile.userData[0].memberFacebook !=
                                      ""
                              ? widget.profile.userData[0].memberFacebook
                              : "NA",
                          style: TextStyle(fontFamily: "Nunito-Bold"),
                        ),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Eventslist_view()));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoreMenu()));
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
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: image != null && image != ""
                    ? NetworkImage(image)
                    : AssetImage("assets/images/blank.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
