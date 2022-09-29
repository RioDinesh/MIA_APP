import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-Event.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-State.dart';


import 'package:mia_app/Utils/ApiBase.dart';

import 'package:http/http.dart'as http;
import 'package:mia_app/modal/events-modal.dart';
class Event_Bloc extends Bloc<Event_Event,EventState>{
  @override
  // TODO: implement initialState
  EventState get initialState =>  EventLoading();

  @override
  Stream<EventState> mapEventToState(Event_Event event)async*{
     
     if(event is Event_Event){
       yield EventLoading();

       try{
         print("datttata");
         List<EventData> data= await getEvent();
         //print("length"+ data.length.toString());
         if(data!=null){
           yield EventLoaded(Event: data);
         }else{
           yield EventFailue(error: "No Event Found");
         }

       }catch(e){
         yield EventFailue(error: "Something went wrong");
       }
       
     }
  }
}

Future<List<EventData>> getEvent()async{
   
   http.Response response =await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.Event));
   
   print(response.body);
   if(response.statusCode==200){
      var data=jsonDecode(response.body);
     if(data["event_data"]!=null){
       List<EventData> events=Events.fromJson(data).eventData;
       
       return events;

     }else{
       return null;
     }
      

   }

   return null;

}