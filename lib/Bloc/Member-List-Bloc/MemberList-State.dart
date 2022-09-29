import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mia_app/modal/Member-profile.dart';


abstract class MemberListState extends Equatable{
  const MemberListState();

  @override 
  List<Object> get props =>[];
}

class MemberListInitial extends MemberListState{}
class MemberListLoading extends MemberListState{}
class MemberListLoaded extends MemberListState{
  final List<UserDatas> data;
  MemberListLoaded({ this.data});

  @override
  List<Object> get props=>[data];
}
class MemberListfailure extends MemberListState{
  final String error;
  
  MemberListfailure( this.error);

  @override
  List<Object> get props=>[];

}
class MemberListSearch extends MemberListState{
  final List<UserDatas> data;
  MemberListSearch( this.data);
   @override
  List<Object> get props=>[data];
}
class MemberListSearchInfo extends MemberListState{
  final String info;
  
  MemberListSearchInfo( this.info);

  @override
  List<Object> get props=>[info];
   
}