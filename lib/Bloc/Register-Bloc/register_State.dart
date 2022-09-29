import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class RegisterState extends Equatable{
  const RegisterState();

  @override
  List<Object>get props=>[];
}

class RegisterInitial extends RegisterState{}
class RegisterLoading extends RegisterState{}
class Registered extends RegisterState{}
class RegisterFailed extends RegisterState{
  final String error;

  RegisterFailed({ this.error});

  @override
  List<Object>get props=>[error];
}