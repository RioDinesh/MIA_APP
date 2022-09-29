import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BussinessListEvent extends Equatable{
  BussinessListEvent();
   @override
  List<Object> get props => [];
}

class FetchBussinessList extends BussinessListEvent{}

class SearchBussinessList extends BussinessListEvent{
  final String name;

  SearchBussinessList( this.name);

  @override
  List<Object> get props=>[];
} 