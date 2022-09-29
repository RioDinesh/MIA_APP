import 'package:flutter/material.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProileShimmer extends StatelessWidget {
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
                  ),
                  child: Shimmer.fromColors(
                   baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                    child: Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                     highlightColor: Colors.grey[100],
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        height:MediaQuery.of(context).size.width * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6.h,),
                     Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                     highlightColor: Colors.grey[100],
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.50,
                        height:MediaQuery.of(context).size.width * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 6.h,),
                     Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                     highlightColor: Colors.grey[100],
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height:MediaQuery.of(context).size.width * 0.04,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
