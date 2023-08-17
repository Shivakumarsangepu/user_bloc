import 'package:equatable/equatable.dart';

class BaseState extends Equatable {
  //abstract
  @override
  List<Object> get props => [];
}

class Loading extends BaseState {
  @override
  String toString() => 'Loading';
}

class DataLoaded<T> extends BaseState {
  final  T? data;
  final String? event;

  DataLoaded({this.data, this.event});

  @override
  String toString() => 'DataLoaded';
  @override
  List<Object> get props => [data!,event!];
}

class BaseError extends BaseState {
  final String? errorMessage;

  BaseError(this.errorMessage);

  @override
  String toString() => 'Error';

  @override
  List<Object> get props => [errorMessage!];
}