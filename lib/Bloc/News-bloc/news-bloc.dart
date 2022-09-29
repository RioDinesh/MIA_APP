import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-Event.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-State.dart';
import 'package:mia_app/Bloc/News-bloc/news-Event.dart';
import 'package:mia_app/Bloc/News-bloc/news-State.dart';


import 'package:mia_app/Utils/ApiBase.dart';

import 'package:http/http.dart'as http;
import 'package:mia_app/modal/events-modal.dart';
import 'package:mia_app/modal/news-modal.dart';
class News_Bloc extends Bloc<News_Event,NewsState>{
  @override
  // TODO: implement initialState
  NewsState get initialState =>  NewsLoading();

  @override
  Stream<NewsState> mapEventToState(News_Event event)async*{
     
     if(event is News_Event){
       yield NewsLoading();

       try{
         print("datttata");
         List<NewsData> data= await getNews();
         //print("length"+ data.length.toString());
         if(data!=null){
           yield NewsLoaded(News: data);
         }else{
           yield NewsFailue(error: "No Event Found");
         }

       }catch(e){
         yield NewsFailue(error: "Something went wrong");
       }
       
     }
  }
}

Future<List<NewsData>> getNews()async{
   
   http.Response response =await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.News));
   
   print(response.body);
   if(response.statusCode==200){
      var data=jsonDecode(response.body);
     if(data["news_data"]!=null){
       List<NewsData> events=News.fromJson(data).newsData;
       
       return events;

     }else{
       return null;
     }
      

   }

   return null;

}