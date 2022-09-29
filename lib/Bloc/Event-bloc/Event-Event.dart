import 'package:equatable/equatable.dart';

abstract class Event_Event extends Equatable {
  const Event_Event();

  @override
  List<Object> get props=>[];
}

class FetchEvent extends Event_Event{}