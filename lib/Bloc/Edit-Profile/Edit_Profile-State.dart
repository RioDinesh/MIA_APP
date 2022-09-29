import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class EditState extends Equatable{
  const EditState();

  @override
  List<Object>get props=>[];
}

class EditInitial extends EditState{}
class EditLoading extends EditState{}
class Edited extends EditState{
  final String msg;

  Edited({ this.msg});

  @override
  List<Object> get props=>[msg];
}
class EditFailed extends EditState{
  final String error;

  EditFailed({ this.error});

  @override
  List<Object>get props=>[error];
}