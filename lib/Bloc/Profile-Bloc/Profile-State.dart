import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mia_app/modal/Member-profile.dart';
import 'package:mia_app/modal/Bussiness-modal.dart';

abstract class ProfileState extends Equatable{
  const ProfileState();

  @override
  List<Object> get props =>[];
}

class ProfileInitial extends ProfileState{}

class ProfileLoading extends ProfileState{}
class ProfileLoaded extends ProfileState{
 
 final MemberProfile profile;

 ProfileLoaded( this.profile);

 @override 
 List<Object> get props =>[profile];

}
class ProfileFailure extends ProfileState{
  final String error;

  ProfileFailure( this.error);

  @override
  List<Object>get props=>[error];


}