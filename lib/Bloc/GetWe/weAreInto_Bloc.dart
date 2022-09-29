import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/GetWe/weAreInto_Event.dart';
import 'package:mia_app/Bloc/GetWe/weAreInto_State.dart';
import 'package:mia_app/Utils/ApiBase.dart';

import 'package:mia_app/modal/manufacturing.dart';
import 'package:http/http.dart'as http;
import 'package:mia_app/modal/services.dart';
class WeAreIntoBloc extends Bloc<WeAreIntoEvent,WeAreIntoState>{
  @override
  // TODO: implement initialState
  WeAreIntoState get initialState => WeLoading();

  @override
  Stream<WeAreIntoState> mapEventToState(WeAreIntoEvent event)async* {
    if(event is GetServices){
      yield WeLoading();
      try{
        List<ServiceCatData> data =await services();
        
        yield WeAreServices(data: data);

      }catch(e){
        print(e);
        yield WeFailed();
      }
    }
    if(event is GetManufacturing){
      print("bloc");
      yield WeLoading();
      try{
        List<ManufactureCategoryData> data =await manufacturing();
        
        yield WeAreManufacture(data: data);

      }catch(e){
        print(e);
        yield WeFailed();
      }
    }
  }
}
Future<List<ManufactureCategoryData>>manufacturing()async{
 print('hi');
  http.Response response=await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.getManufacturing));
   print(response.body);
    if(response.statusCode==200){
      var json=jsonDecode(response.body);
      List<ManufactureCategoryData> data=ManufacturingModel.fromJson(json).manufactureCategoryData;
      return data; 
    }
}

Future<List<ServiceCatData>>services()async{

  http.Response response=await http.get(Uri.parse(ApiBase.MainUrl+ApiBase.getservice));

    if(response.statusCode==200){
      var json=jsonDecode(response.body);
      List<ServiceCatData> data=ServicesModel.fromJson(json).serviceCatData;
      return data; 
    }
}