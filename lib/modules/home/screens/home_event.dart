import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class HomeEvent extends Equatable {}

class GetHomePageDetails extends HomeEvent {
  final int num;

  GetHomePageDetails({required this.num});

  @override
  List<Object> get props =>[this.num];

}