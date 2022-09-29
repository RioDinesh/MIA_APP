import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mia_app/modal/Bussiness-modal.dart';



abstract class BussinessListState extends Equatable{
  const BussinessListState();

  @override 
  List<Object> get props =>[];
}

class BussinessListInitial extends BussinessListState{}
class BussinessListLoading extends BussinessListState{}
class BussinessListLoaded extends BussinessListState{
  final List<BusinessData> data;
  BussinessListLoaded({ this.data});

  @override
  List<Object> get props=>[data];
}
class BussinessListfailure extends BussinessListState{
  final String error;
  
  BussinessListfailure( this.error);

  @override
  List<Object> get props=>[];

}
class BussinessListSearch extends BussinessListState{
  final List<BusinessData> data;
  BussinessListSearch( this.data);
   @override
  List<Object> get props=>[data];
}
class BussinessListSearchInfo extends BussinessListState{
  final String info;
  
  BussinessListSearchInfo( this.info);

  @override
  List<Object> get props=>[info];
   
}