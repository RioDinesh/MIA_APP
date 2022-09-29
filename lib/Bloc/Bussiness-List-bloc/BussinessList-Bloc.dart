import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-Event.dart';
import 'package:mia_app/Bloc/Bussiness-List-bloc/BussinessList-State.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/modal/Bussiness-modal.dart';
import 'package:http/http.dart'as http;

class BussinessListBloc extends Bloc<BussinessListEvent,BussinessListState>{

   @override
   BussinessListState get initialState => BussinessListInitial();

  @override
  Stream<BussinessListState> mapEventToState(BussinessListEvent event) async*{
     
     if(event is FetchBussinessList){
       print("inhere");
        yield BussinessListLoading();
       try{
          print("in");
           List<BusinessData> datas= await getlist();
           print(datas[0].companyName);
           if(datas.isNotEmpty){
             yield BussinessListLoaded(data: datas);
           }else {
             yield BussinessListfailure("Something went wrong");
           }

      
       }catch(error){
           yield BussinessListfailure("Something went wrong2");
       }


     }
     if(event is SearchBussinessList){
       print("search");
       List<BusinessData> datas= await getlist();
       List<BusinessData> Searched_data=[];
       BusinessData userDatas;
       yield BussinessListLoaded(data: datas);

       try{
          if(event.name!=null&&event.name.length!=0){
            /* datas.forEach((Bussiness) {
                String memname=Bussiness.companyName;
                
               if(memname.toLowerCase()==event.name.toLowerCase()){
                 Searched_data.add(Bussiness);
               }
             });*/
              Searched_data=datas.where((element) => element.companyName.toString().toLowerCase().startsWith(event.name) ).toList();

             if(Searched_data.length!=0){
               yield BussinessListSearch(Searched_data);
             }else{
               yield BussinessListSearchInfo("No search result");
             }
           
            
             
          }else{
            yield BussinessListLoaded(data: datas);
          }

       }catch(e){
         print(e);

       }
      
     
      

     }
     

  }
}

Future<List<BusinessData>> getlist()async{
    
     List<BusinessData> data;
     try{
       http.Response response= await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.bussinesslist));
       print(response.statusCode);
       print(response.body);
      if(response.statusCode==200){

       var data=jsonDecode(response.body);
        print("hello");
        List<BusinessData> profile = Bussiness.fromJson(data).businessData;
       // print("response "+profile[0].memberName);
        return profile;
      }
     return data ;
     }catch(err){
       print( err.toString());
     }
     
     
    
   } 
