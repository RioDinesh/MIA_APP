import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mia_app/Bloc/Edit-Profile/Edit_Profile-Event.dart';
import 'package:mia_app/Bloc/Edit-Profile/Edit_Profile-State.dart';
import 'package:http/http.dart' as http;
import 'package:mia_app/Utils/ApiBase.dart';
class EditProfileBloc extends Bloc <EditEvent,EditState>{
  @override
  // TODO: implement initialState
  EditState get initialState => EditInitial();

  @override
  Stream<EditState> mapEventToState(EditEvent event)async* {
   if(event is OnEditPress){
     yield EditLoading();
     try{
       print(event.company_email);
       print("id:"+event.id);
       print("member_instagram"+event.member_instagram!=null?event.member_instagram:"NA",);
       print(ApiBase.MainUrl+"edit_profile.php");
        http.Response response= await http.post(Uri.parse(ApiBase.MainUrl+ApiBase.edit),body: {
          "member_id":event.id,
         "address":event.company_address!=null||event.company_address!=" "?event.company_address:"NA",
         "city":event.company_city!=null||event.company_city!=" "?event.company_city:"NA",
         "state":event.company_state!=null||event.company_state!=" "?event.company_state:"NA",
         "country":event.company_country!=null||event.company_country!=" "?event.company_country:"NA",
         "member_website":event.member_website!=null||event.member_website!=" "?event.member_website:"NA",
         "member_linkedin":event.member_linkedin!=null||event.member_linkedin!=" "?event.member_linkedin:"NA",
         "member_instagram":event.member_instagram!=null||event.member_instagram!=" "?event.member_instagram:"NA",
         "member_facebook":event.member_facebook!=null||event.member_facebook!=" "?event.member_facebook:"NA",
         "company_name":event.companyname!=null||event.companyname!=" "?event.companyname:"NA",
         "member_type":event.membertype!=null||event.membertype!=" "?event.membertype:"NA",
         "belong_to":event.webelongto!=null||event.webelongto!=" "?event.webelongto:"NA",
         "export_to":event.import_export!=null||event.import_export!=" "?event.import_export:"NA",
         "last_year_turn_over":event.last_year_turn_over!=null||event.last_year_turn_over!=" "?event.last_year_turn_over:"NA",
         "expected_turn_over":" ",
         "qual_mgmt":event.qual_mgmt!=null||event.qual_mgmt!=""?event.qual_mgmt:"NA",
         "no_of_employees":event.no_of_employees!=null||event.no_of_employees!=""?event.no_of_employees:"NA",
         "year_of_establishment":event.year_of_establishment!=null||event.year_of_establishment!=""?event.year_of_establishment:"NA",
         "scale":event.industryType!=null||event.industryType!=""?event.industryType:"NA",
         "cin":event.cinnumber!=null||event.cinnumber!=""?event.cinnumber:"NA",
         "pan":event.pan!=null||event.pan!=""?event.pan:"NA",
         "founder_qual":event.founder_qual!=null||event.founder_qual!=""?event.founder_qual:"NA",
         "company_address":event.company_address!=null||event.company_address!=""?event.company_address:"NA",
         "company_city":event.company_city!=null||event.company_city!=""?event.company_city:"NA",
         "company_phone":event.company_phone!=null||event.company_phone!=""?event.company_phone:"NA",
         "company_email":event.company_email!=null||event.company_email!=" "?event.company_email:"NA",
         "company_state":event.company_state!=null||event.company_state!=""?event.company_state:"NA",
         "company_country":event.company_country!=null||event.company_country!=""?event.company_country:"NA",
         "company_description":event.company_description!=null||event.company_description!=""?event.company_description:"NA",
        });
       print("hi");
       print(response.statusCode);
       print(response.body);
       if(response.statusCode==200){
         var json= jsonDecode(response.body);
         if(json["status"]=="true"){
           yield Edited(msg:json["message"].toString());
         }else{
           yield EditFailed(error: json["message"].toString());
         }
       }

     }catch(e){
       print(e);
       yield EditFailed(error: "Something went wrong");
     }
      
   }
  }
}

Future<bool>update({member_id,address})async{
  print("gg");
  http.Response response= await http.post(Uri.parse('http://miaindia.net/api/edit_profile(2).php'),body: {
         "member_id":"387",
         
         

       });
       print("hi");
       print(response.statusCode);
       print(response.body);
       if(response.statusCode==200){
         var json= jsonDecode(response.body);
         if(json["status"]=="true"){
           return true;
         }else{
           return false;
         }
       }
}