import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:mia_app/modal/news-modal.dart';


abstract class NewsState extends Equatable{
  const NewsState();

  @override
  List<Object>get props=>[];
}


class NewsLoading extends NewsState{}

class NewsLoaded extends NewsState{
  final List<NewsData> News;
  NewsLoaded({ this.News});

  @override
  List<Object> get props=>[];
}

class NewsFailue extends NewsState{
  final String error;

  NewsFailue({ this.error});
}