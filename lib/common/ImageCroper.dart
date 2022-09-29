import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CropImage extends StatefulWidget {
 
 
  @override
  _CropImageState createState() => _CropImageState();
}

//_image = await ImagePicker().getImage(source: ImageSource.gallery)
class _CropImageState extends State<CropImage> {
  final ImagePicker picker = ImagePicker();
  File imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Upload Image",style: TextStyle(
          fontFamily: "Nunito-Bold",
          color: Colors.black,
          fontSize: 16.sp
        ),),
      ),
      body: Container(
        child:Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(MainColor),
                      ),
                      onPressed: () async {
                        final XFile image =
                            await picker.pickImage(source: ImageSource.gallery);
                        print(image.path);
                        if (image.path != null) {
                          File croppedFile = await ImageCropper.cropImage(
                              sourcePath: image.path,
                              aspectRatioPresets: [
                                CropAspectRatioPreset.square,
                                
                              ],
                              androidUiSettings: AndroidUiSettings(
                                  toolbarTitle: 'Cropper',
                                  toolbarColor: Colors.white,
                                  toolbarWidgetColor: Colors.black,
                                  initAspectRatio:
                                      CropAspectRatioPreset.original,
                                  lockAspectRatio: false),
                              iosUiSettings: IOSUiSettings(
                                minimumAspectRatio: 1.0,
                              ));

                          setState(() {
                            imagePath = croppedFile;
                          });
                        }
                      },
                      child: Text("Select Image"),
                    ),
                  ),
                  imagePath != null
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Container(
                                child: Image.file(
                                  File(imagePath.path),
                                  width: 400.w,
                                  height: 400.h,
                                ),
                              ),

                              InkWell(
                                onTap: (){
                                
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(color:MainColor),
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.upload_file,color:MainColor,),
                                      SizedBox(width: 10.w,),
                                      Text('Upload',style: TextStyle(fontFamily: "Nunito-Bold",fontSize: 16.sp,color:MainColor),),
                                    ],
                                  ),
                                ),
                              )

                            ],
                          ),
                        )
                      : Container(),
                ],
              )
      ),
    );
  }
}
