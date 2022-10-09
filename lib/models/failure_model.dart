import 'package:equatable/equatable.dart';

// extend Equatable to easier way to compare obj1 and obj2
class Failure extends Equatable {
  final String code;
  final String? message;

  const Failure({this.code = '', this.message = ''});

  @override
  bool? get stringify => true; // printout readable format

  @override
  List<Object?> get props =>
      [code, message]; //tell Equatable which keys we want to compare
}
