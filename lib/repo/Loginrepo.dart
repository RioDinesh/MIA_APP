import 'dart:convert';


import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mia_app/Utils/ApiBase.dart';
import 'package:mia_app/modal/login-response-modal.dart';



class UserRepository {
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  //final Dio _dio = Dio();

  Future<String> hasToken() async {
    var value = await storage.read(key: 'token');
    return value;
  }

  Future<void> persistToken(LoginResponse token) async {
    await storage.write(key: 'token', value: token.userData.memberId);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

 Future<LoginResponse>Logincall(String email,String password)async{
 
 http.Response response =await http.post(Uri.parse(ApiBase.MainUrl+ApiBase.Login),
 body: {
  'email':email,
  'password':password
 });

 if(response.statusCode ==200){
   print(response.body);
   var data=jsonDecode(response.body);
   
   
    
   LoginResponse Callresponse= LoginResponse.fromJson(data); 
   return Callresponse;   
 }

 return null;

} 
}
