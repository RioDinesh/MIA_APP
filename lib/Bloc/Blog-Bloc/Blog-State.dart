import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mia_app/modal/BlogList-modal.dart';

abstract class BlogState extends Equatable{
  const BlogState();

  @override
  List<Object>get props=>[];
}


class BlogLoading extends BlogState{}

class BlogLoaded extends BlogState{
  final List<BlogData> blog;
  BlogLoaded({ this.blog});

  @override
  List<Object> get props=>[];
}

class BlogFailue extends BlogState{
  final String error;

  BlogFailue({ this.error});
}