import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-Event.dart';
import 'package:mia_app/Bloc/Member-List-Bloc/MemberList-State.dart';
import 'package:mia_app/Utils/ApiBase.dart';

import 'package:http/http.dart'as http;
import 'package:mia_app/modal/Member-profile.dart';
class MemberListBloc extends Bloc<MemberListEvent,MemberListState>{

   @override
   MemberListState get initialState => MemberListInitial();

  @override
  Stream<MemberListState> mapEventToState(MemberListEvent event) async*{
     
     if(event is FetchMemberList){
       print("inhere");
        yield MemberListLoading();
       try{
          print("in");
           List<UserDatas> datas= await getlistprofile();
           print(datas[0].memberName);
           if(datas.isNotEmpty){
             yield MemberListLoaded(data: datas);
           }else {
             yield MemberListfailure("Something went wrong");
           }

      
       }catch(error){
           yield MemberListfailure("Something went wrong");
       }


     }
     if(event is SearchMemberList){
       print("search");
       List<UserDatas> datas= await getlistprofile();
       List<UserDatas> Searched_data=[];
       UserDatas userDatas;
       yield MemberListLoaded(data: datas);

       try{
          if(event.name!=null&&event.name.length!=0){
            /* datas.forEach((member) {
                String memname=member.memberName;
                
               if(memname.toLowerCase()==event.name.toLowerCase()){
                 Searched_data.add(member);
               }
             });*/

             Searched_data=datas.where((element) => element.memberName.toString().toLowerCase().startsWith(event.name) ).toList();

             if(Searched_data.length!=0){
               yield MemberListSearch(Searched_data);
             }else{
               yield MemberListSearchInfo("No search result");
             }
           
            
             
          }else{
            yield MemberListLoaded(data: datas);
          }

       }catch(e){
         print(e);

       }
      
     
      

     }
     

  }
}


Future<List<UserDatas>> getlistprofile()async{
    
     List<UserDatas> data;
     try{
       print('hi');
       http.Response response= await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.memberlist));
       print(response.statusCode);
       print(response.body);
      if(response.statusCode==200){

       var data=jsonDecode(response.body);
        print("hello");
        List<UserDatas> profile = MemberProfile.fromJson(data).userData;
       // print("response "+profile[0].memberName);
        return profile;
      }
     return data ;
     }catch(err){
       print( err.toString());
     }
     
     
    
   } 
