import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class GetHomePageDetails extends HomeEvent {

  GetHomePageDetails();

  @override
  List<Object> get props =>[];

}