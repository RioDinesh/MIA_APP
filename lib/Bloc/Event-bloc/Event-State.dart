import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mia_app/modal/events-modal.dart';


abstract class EventState extends Equatable{
  const EventState();

  @override
  List<Object>get props=>[];
}


class EventLoading extends EventState{}

class EventLoaded extends EventState{
  final List<EventData> Event;
  EventLoaded({ this.Event});

  @override
  List<Object> get props=>[];
}

class EventFailue extends EventState{
  final String error;

  EventFailue({ this.error});
}