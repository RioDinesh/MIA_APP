import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-Bloc.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-Event.dart';
import 'package:mia_app/Bloc/Login-bloc/Login-Event.dart';
import 'package:mia_app/repo/Loginrepo.dart';
import 'Login-state.dart';
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
     this.userRepository,
     this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.Logincall(
          event.email,
          event.password,
        );
        if(token==null){
          yield LoginFailure(error: "login Failed");
        }else if(token.status==false){
          yield LoginFailure(error: "Wrong Credentials");
        
        }else{
           authenticationBloc.add(LoggedIn(token: token));
           yield LoginInitial();
        }
        
      } catch (error) {
        print(error);
        yield LoginFailure(error: "Something Went Wrong");
      }
    }
  }
}