


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  


  
  const LoginButtonPressed({
     this.email,
     this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginButtonPressed { email: $email, password: $password }';
}