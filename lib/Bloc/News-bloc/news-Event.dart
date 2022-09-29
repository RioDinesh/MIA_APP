import 'package:equatable/equatable.dart';

abstract class News_Event extends Equatable {
  const News_Event();

  @override
  List<Object> get props=>[];
}

class FetchNews extends News_Event{}