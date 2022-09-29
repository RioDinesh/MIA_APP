import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ForgotPassEvent extends Equatable{
  const ForgotPassEvent();

  @override
  List<Object>get props=>[];
}


class PostPass extends ForgotPassEvent{
  final String pass;
  final String number;

  PostPass({ this.pass, this.number});

  @override
  List<Object>get props=>[];
}