import 'package:equatable/equatable.dart';

abstract class WeAreIntoEvent extends Equatable{
  const WeAreIntoEvent();

  @override
  List<Object> get props=>[];
}



class GetServices extends WeAreIntoEvent{}
class GetManufacturing extends WeAreIntoEvent{}