import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mia_app/modal/manufacturing.dart';
import 'package:mia_app/modal/services.dart';

abstract class WeAreIntoState extends Equatable{
  const WeAreIntoState();

  @override
  List<Object> get props=>[];
}

class WeLoading extends WeAreIntoState{}
class WeFailed extends WeAreIntoState{}
class WeAreServices extends WeAreIntoState{
  final List<ServiceCatData> data;

  WeAreServices({ this.data});
  @override
  List<Object> get props=>[data];
}
class WeAreManufacture extends WeAreIntoState{
  final List<ManufactureCategoryData> data;

  WeAreManufacture({ this.data});

  @override
  List<Object> get props=>[data];
}