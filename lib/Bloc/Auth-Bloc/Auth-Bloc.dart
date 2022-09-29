import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';

import 'package:mia_app/Bloc/Auth-Bloc/Auth-Event.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-State.dart';

import 'dart:async';

import 'package:mia_app/repo/Loginrepo.dart';
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  
  AuthenticationBloc({ this.userRepository})
      : assert(userRepository != null);
  
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();
  
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final String hasToken = await userRepository.hasToken();
      if(hasToken!=null){
        yield AuthenticationAuthenticated();
      }
      else{
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
       
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
      
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}