import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-Event.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-State.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/modal/Member-profile.dart';
import 'package:mia_app/modal/Bussiness-modal.dart';
import 'package:mia_app/modal/login-response-modal.dart';
import 'package:mia_app/repo/Profile-Repo.dart';
import 'package:http/http.dart'as http;
class ProfileBloc extends Bloc<ProfileEvent,ProfileState>{
  
  ProfileState get initialState=>ProfileInitial();

  Stream<ProfileState>mapEventToState(ProfileEvent event)async*{
    if(event is FetchProfile){
      print("hi");
     
     yield ProfileLoading();
     
     try{
      
           MemberProfile  data = await getprofile();
           print(data.userData);
           if(data.userData.isEmpty){
             yield ProfileFailure("User not found");
           }else{
             yield ProfileLoaded(data);
           }

     }catch(error){
       print(error);
           yield ProfileFailure("something went wrong");
     }
        

       

    }
  }
}

Future<MemberProfile> getprofile()async{
     final FlutterSecureStorage storage = new FlutterSecureStorage();
     String value = await storage.read(key: 'token');
      print("val:"+value.toString());
     
     
     
     http.Response response= await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.getSingleMember+value.toString()));
       print(response.statusCode);
       print(response.body);
      if(response.statusCode==200){

       var data=jsonDecode(response.body);

        MemberProfile profile = MemberProfile.fromJson(data);
        
        return profile;
      }
     return null;
    
   } 
