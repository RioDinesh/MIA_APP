import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mia_app/screens/searchpage.dart';

class Bussiness extends StatefulWidget {
 

  @override
  _BussinessState createState() => _BussinessState();
}

class _BussinessState extends State<Bussiness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
          "Business sector",
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
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
           color: Colors.white
          ),
          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          
            child: Column(
              children: [
                
                Expanded(child: GridView.builder(
  itemCount: 5,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount:2),
  itemBuilder: (BuildContext context, int index) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchpage()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 100.h,
            width: 120.w,
            child: Column(
              children: [
                 ClipRRect(
                   borderRadius: BorderRadius.circular(10),
                   child: Image.asset('assets/images/one.jpg',height: 100.h,fit: BoxFit.fill,)),
                Text("Additive manufacturing",style: TextStyle(fontFamily: "Nunito-Bold",color: Colors.black,fontSize: 12.sp),),
                Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   padding: EdgeInsets.all(4),
                                   decoration: BoxDecoration(
                                     color: Colors.red,
                                     shape: BoxShape.circle
                                   ),
                                   child: Text("0",style: TextStyle(fontFamily: "Nunito-Bold"),),
                                 ),
                                 SizedBox(width: 10.w,),
                                 Text("is simply dummy",style: TextStyle(fontFamily: "Nunito-Regular",color: Colors.black),),
                               ],
                             )
              ],
            ),
          ),
        ),
      ),
    );
  },
),)
          
              ],
            ),
          ),
        
      ),
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            
            decoration: BoxDecoration(
              
            ),
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.home_outlined),
                          Text(
                            'Home',
                            style: TextStyle(
                                fontFamily: 'Nunito-Bold', fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchpage()));
                        // Navigator.push(context, MaterialPageRoute(builder:(context)=>Notification_screen()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.search),
                          Text(
                            'Search',
                            style: TextStyle(
                              fontFamily: 'Nunito-Bold',
                              fontSize: 12.sp,
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
                     
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_city),
                          Text(
                            'Business',
                            style: TextStyle(
                                fontFamily: 'Nunito-Bold', fontSize: 12.sp),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40.w,
                      onPressed: () {
                      
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.menu),
                          Text(
                            'More',
                            style: TextStyle(
                                fontFamily: 'Nunito-Bold', fontSize: 12.sp),
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
    );
  }
}