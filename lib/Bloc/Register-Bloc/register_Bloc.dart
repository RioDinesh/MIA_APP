import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mia_app/Bloc/Register-Bloc/register_Event.dart';
import 'package:mia_app/Bloc/Register-Bloc/register_State.dart';
import 'package:http/http.dart' as http;
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:http_parser/http_parser.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is OnRegisterPress) {
      yield RegisterLoading();
       
       try{
        var data = await register(
          logo: event.logo,
          Cin: event.cin,
          Aadhar: event.aadhaar,
          other: event.others,
          name: event.name,
          Email: event.email,
          PhoneNumber: event.mobile,
          Password: event.password,
          BusinessName: event.companyname,
          Weareinto: event.Weareinto,
          WeBelongTo: event.webelongto,
          turnover:  event.last_year_turn_over,
          noofemp: event.no_of_employees,
          yearofestablish: event.year_of_establishment,
          industrytype: event.industryType,
          pan: event.pan,
          FounderQualification: event.founder_qual,
          companyinfo: event.company_description,
          companyEmail: event.company_email,
          companyPhone: event.company_phone,
          website: event.member_website,
          linkedin: event.member_linkedin,
          facebook: event.member_facebook,
          city: event.company_city,
          state: event.company_state,
          country: event.company_country,
          gstNumber: event.gstnumber,
          cinNumber: event.cinnumber,
          import_export: event.import_export,
          instagram: event.member_instagram,
          Quality_management: event.qual_mgmt,
          aadhaarNumber: event.aadhaarnumber

        );
        print(data);
        if(data==true){
          yield Registered();
        }else{
          yield RegisterFailed(error: "Register failed");
        }

       }catch(e){
         print(e);
         yield RegisterFailed(error: "Something went wrong");
       }

    }
  }
}

Future<bool> register({
  File logo,
  File Cin,
  File Aadhar,
  File other,
  String name,
  String Email,
  String PhoneNumber,
  String Password,
  String BusinessName,
  String Weareinto,
  String WeBelongTo,
  String turnover,
  String noofemp,
  String yearofestablish,
  String industrytype,
  String pan,
  String FounderQualification,
  String Quality_management,
  String companyinfo,
  String website,
  String linkedin,
  String instagram,
  String facebook,
  String city,
  String state,
  String country,
  String companyPhone,
  String companyEmail,
  String aadhaarNumber,
  String gstNumber,
  String cinNumber,
  String import_export,
  
}) async {
  //print(id);
  var d;
  final contents = StringBuffer();
  print(ApiBase.MainUrl + ApiBase.Register);
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(ApiBase.MainUrl+ApiBase.Register),
  );
  Map<String, String> headers = {"Content-type": "multipart/form-data"};
  print("some");
  
  if(logo!=null){
   request.files.add(http.MultipartFile(
    'company_logo',
    logo.readAsBytes().asStream(),
    logo.lengthSync(),
    filename: "company_logo",
    contentType: MediaType('image', 'jpg'),
  ));
  //print("some");
  }
  
if(Cin!=null){
  request.files.add(http.MultipartFile(
    'cinfile',
    Cin.readAsBytes().asStream(),
    Cin.lengthSync(),
    filename: "cinfile",
    contentType: MediaType('image', 'jpg'),
  ));
}
  if(Aadhar!=null){
   request.files.add(http.MultipartFile(
    'aadhaarfile',
    Aadhar.readAsBytes().asStream(),
    Aadhar.lengthSync(),
    filename: "aadhaarfile",
    contentType: MediaType('image', 'jpg'),
  ));
  }
  if(other!=null){
    request.files.add(http.MultipartFile(
    'other_file',
    other.readAsBytes().asStream(),
    other.lengthSync(),
    filename: "other_file",
    contentType: MediaType('image', 'jpg'),
  ));
  }
  request.fields.addAll({
    "name": name,
    "email":Email ,
    "mobile": PhoneNumber,
    "password": Password,
    "memshiptype":"" ,
    "member_type":"" ,
    "belong_to":WeBelongTo!=null? WeBelongTo:" ",
    "export_to":import_export!=null ? import_export :" ",
    "last_year_turn_over":turnover!=null ? turnover :" ",
    "year_of_establishment":yearofestablish!=null ? yearofestablish : " ",
    "scale": "",
    "cin":cinNumber!=null ? cinNumber:" ",
    "pan":pan!=null ? pan:" ",
    "founder_qual":FounderQualification!=null ?FounderQualification:" " ,
    "qual_mgmt":Quality_management!=null ? Quality_management:" ",
    "no_of_employees":noofemp!=null ? noofemp : " ",
    "company_address": "",
    "company_city":city!=null ? city:" ",
    "company_country":country!=null ? country:" ",
    "company_state":state!=null ? state:" ",
    "company_phone":companyPhone!=null ? companyPhone :" ",
    "company_email":companyEmail!=null ? companyEmail :" ",
    "company_description":companyinfo!=null ?companyinfo :" ",
    "company_name":BusinessName!=null ? BusinessName:" ",
    "aadhaar":aadhaarNumber!=null ? aadhaarNumber:" ",
    "gstnumber":gstNumber!=null ?gstNumber:" ",
    "member_website":website !=null ?website:" ",
    "member_linkedin":linkedin!=null? linkedin:" ",
    "member_instagram":instagram!=null ? instagram:" " ,
    "member_facebook":facebook!=null ? facebook :" ",
     "submit":"p"

  });
print("some");
  


  print("request: " + request.toString());
  print("here");
  var res = await request.send();
  print("here1");
    print(res.toString());
  d = await res.stream.transform(utf8.decoder).join();

  print("response"+d.toString());
  var data = jsonDecode(d);
print("here2");
  print(data["status"]);
  if (data["status"] == true) {
    return true;
  } else {
    return false;
  }
}

Future<bool> register2({
  File logo,
  File Cin,
  File Aadhar,
  File other,
  String name,
  String Email,
  String PhoneNumber,
  String Password,
  String BusinessName,
  String Weareinto,
  String WeBelongTo,
  String turnover,
  String noofemp,
  String yearofestablish,
  String industrytype,
  String pan,
  String FounderQualification,
  String Quality_management,
  String companyinfo,
  String website,
  String linkedin,
  String instagram,
  String facebook,
  String city,
  String state,
  String country,
  String companyPhone,
  String companyEmail,
  String aadhaarNumber,
  String gstNumber,
  String cinNumber,
  String import_export,
  
}) async {
  //print(id);
  
  
print(ApiBase.MainUrl + ApiBase.Register);
try{
  print("trying");
  http.Response response = await http.post(Uri.parse('http://miaindia.net/api/register.php'),body: {
    "submit":"p",
    "name": "dinesh3",
    "email":"someemaxdsxil@Gmail.com" ,
    "mobile": "8015017002",
    "password": "123",
    "memshiptype":"" ,
    "member_type":"" ,
    "belong_to": "",
    "export_to": "",
    "last_year_turn_over":"",
    "year_of_establishment": "",
    "scale": "",
    "cin":"",
    "pan": "",
    "founder_qual":"" ,
    "qual_mgmt": "",
    "no_of_employees": noofemp,
    "company_address": "",
    "company_city": city,
    "company_country": country,
    "company_state": state,
    "company_phone": companyPhone,
    "company_email": companyEmail,
    "company_description": companyinfo,
    "company_name": BusinessName,
    "aadhaar":aadhaarNumber ,
    "gstnumber":gstNumber ,
    "member_website":website ,
    "member_linkedin": linkedin,
    "member_instagram": instagram,
    "member_facebook":facebook ,
     

  });
  print(ApiBase.MainUrl + ApiBase.Register);
  print(response.statusCode);
  print(response.body);
   return false;
}catch(e){
  print(e);
   return false;
}
 
  
 //if(r){}
 


  
}
