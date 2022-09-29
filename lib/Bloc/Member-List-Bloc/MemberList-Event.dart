import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class MemberListEvent extends Equatable{
  MemberListEvent();
   @override
  List<Object> get props => [];
}

class FetchMemberList extends MemberListEvent{}

class SearchMemberList extends MemberListEvent{
  final String name;

  SearchMemberList( this.name);

  @override
  List<Object> get props=>[];
} 