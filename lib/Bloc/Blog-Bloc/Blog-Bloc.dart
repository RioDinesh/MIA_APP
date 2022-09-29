import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Blog-Bloc/Blog-Event.dart';
import 'package:mia_app/Bloc/Blog-Bloc/Blog-State.dart';
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/modal/BlogList-modal.dart';
import 'package:http/http.dart'as http;
class BlogBloc extends Bloc<BlogEvent,BlogState>{
  @override
  // TODO: implement initialState
  BlogState get initialState =>  BlogLoading();

  @override
  Stream<BlogState> mapEventToState(BlogEvent event)async*{
     
     if(event is FetchBlog){
       yield BlogLoading();

       try{
         List<BlogData> data= await getblog();
         
         if(data!=null){
           yield BlogLoaded(blog: data);
         }else{
           yield BlogFailue(error: "No Blog Found");
         }

       }catch(e){
         yield BlogFailue(error: "Something went wrong");
       }
       
     }
  }
}

Future<List<BlogData>> getblog()async{
   
   http.Response response =await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.Blog));

   if(response.statusCode==200){
      var data=jsonDecode(response.body);
     if(data["blog_data"]!=null){
       List<BlogData> blogs= BlogList.fromJson(data).blogData;
       
       return blogs;

     }else{
       return null;
     }
      

   }

   return null;

}