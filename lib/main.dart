import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-Bloc.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-Event.dart';
import 'package:mia_app/Bloc/Auth-Bloc/Auth-State.dart';
import 'package:mia_app/Bloc/Blog-Bloc/Blog-Bloc.dart';
import 'package:mia_app/Bloc/Event-bloc/Event-Bloc.dart';
import 'package:mia_app/Bloc/Login-bloc/Login-Bloc.dart';
import 'package:mia_app/Bloc/News-bloc/news-bloc.dart';
import 'package:mia_app/Bloc/Profile-Bloc/Profile-Bloc.dart';
import 'Bloc/Auth-Bloc/auth.dart';
import 'package:mia_app/Utils/Apptheme.dart';
import 'package:mia_app/repo/Loginrepo.dart';
import 'package:mia_app/screens/dashboad.dart';
import 'package:mia_app/screens/loginpage.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: MyApp(userRepository: userRepository),
  ));
}

class MyApp extends StatefulWidget {
  final UserRepository userRepository;
  final FlutterSecureStorage storage = new FlutterSecureStorage();
  MyApp({Key key, @required this.userRepository}) : super(key: key);
  // This widget is the root of your application.
  // LoginState state;
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: () => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MIA',
            theme: ThemeData(
              primarySwatch: kPrimaryColor,
            ),
            home: AnimatedSplashScreen(
              duration: 2000,
              splash: Image.asset('assets/images/logo.png'),
              nextScreen: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    return MultiBlocProvider(
                      providers: [
                      BlocProvider<ProfileBloc>(
                        create: (BuildContext context) => ProfileBloc(),
                      ),
                       BlocProvider<BlogBloc>(
                        create: (BuildContext context) => BlogBloc(),
                      ),
                       BlocProvider<Event_Bloc>(
                        create: (BuildContext context) => Event_Bloc(),
                      ),
                      BlocProvider<News_Bloc>(
                        create: (BuildContext context) => News_Bloc(),
                      ),
                    ], child: MyHomePage());
                  }
                  if (state is AuthenticationUnauthenticated) {
                    print("here");
                    return BlocProvider(
                      create: (context) {
                        return LoginBloc(
                          authenticationBloc:
                              BlocProvider.of<AuthenticationBloc>(context),
                          userRepository: widget.userRepository,
                        );
                      },
                      child: Login_Page(),
                    );
                  }

                  if (state is AuthenticationLoading) {
                    return Scaffold(
                      body: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 25.0,
                              width: 25.0,
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.amber),
                                strokeWidth: 4.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Scaffold(
                    body: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 25.0,
                            width: 25.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  new AlwaysStoppedAnimation<Color>(Colors.red),
                              strokeWidth: 4.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              splashTransition: SplashTransition.fadeTransition,
              //pageTransitionType: PageTransitionType.scale,
            )));
  }
}
