import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ForgotPassState extends Equatable{
  const ForgotPassState();

  @override
  List<Object>get props=>[];
}

class FPLoding extends ForgotPassState{}
class FPInital extends ForgotPassState{}
class FPPosted extends ForgotPassState{}
class FPFail extends ForgotPassState{
  final String error;

  FPFail({ this.error});

  @override
  List<Object>get props=>[];
}

