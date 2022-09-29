import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart'as http;
import 'package:mia_app/Bloc/ForgotPassword/forgot_passwordEvent.dart';
import 'package:mia_app/Bloc/ForgotPassword/forgot_passwordState.dart';
import 'package:mia_app/Utils/ApiBase.dart';

class ForgotPassBloc extends Bloc<ForgotPassEvent,ForgotPassState>{
  

 

  @override
  // TODO: implement initialState
  ForgotPassState get initialState => FPInital();

  @override
  Stream<ForgotPassState> mapEventToState(ForgotPassEvent event)async* {

   if(event is PostPass){
     try{
       yield FPLoding();
    bool result= await postpass( event.pass,  event.number);
    if(result==true){
      yield FPPosted();
    }else{
      yield FPFail(error: "Failed");
    }
     }catch(e){
           print(e);
       yield FPFail(error: "Something went Wong");    
     }
    
      
   }
  }
}

Future<bool>postpass(pass,number)async{
 
 http.Response response= await http.post(Uri.parse(ApiBase.MainUrl+ApiBase.ForgotPassword),body: {
   "number":number,
   "password":pass
 }); 
  print(response.body);
 if(response.statusCode==200){
    var data=jsonDecode(response.body);
    if(data["status"]=="true"){
      return true;
    }else{
      return false;
    }
 }
 
}