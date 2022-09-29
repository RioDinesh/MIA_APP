import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class EditEvent extends Equatable{
  const EditEvent();

  @override
  List<Object>get props=>[];
}


class OnEditPress extends EditEvent{
  
  final String companyname;
  final String membertype;
  final String last_year_turn_over;
  final String no_of_employees;
  final String year_of_establishment;
  final String scale;
  final String pan;
  final String webelongto;
  final String gstnumber;
  final String founder_qual;
  final String qual_mgmt;
  final String company_address;
  final String company_city;
  final String company_state;
  final String company_country;
  final String company_phone;
  final String company_email;
  final String company_description;
  final String memshiptype;
  final String member_website;
  final String member_linkedin;
  final String member_instagram;
  final String member_facebook;
  final String aadhaarnumber;
  final String import_export;
  final String cinnumber;
  final String id;
  final String Weareinto; 
  final String industryType;
  const OnEditPress({
   
     this.companyname,
     this.membertype,
    
     this.last_year_turn_over,
     this.no_of_employees,
     this.year_of_establishment,
     this.scale,
     this.id,
     this.pan,
    
     this.gstnumber,
     this.founder_qual,
     this.qual_mgmt,
     this.company_address,
     this.company_city,
     this.company_state,
     this.company_country,
     this.company_phone,
     this.company_email,
     this.company_description,
     this.memshiptype,
     this.member_website,
     this.member_linkedin,
     this.member_facebook,
     this.member_instagram,
     this.aadhaarnumber,
     this.cinnumber,
     this.import_export,
   
     this.Weareinto,
     this.webelongto,
     this.industryType,
    });

    @override
    List<Object>get props=>[
      id,
      companyname,memshiptype,last_year_turn_over,
      no_of_employees,year_of_establishment,scale,pan,gstnumber,founder_qual,qual_mgmt,
      company_address,company_city,
      company_state,company_country,company_phone,
      company_email,
      company_description,membertype,member_website,member_linkedin,member_facebook,
      member_instagram,aadhaarnumber,cinnumber,import_export,Weareinto];
}