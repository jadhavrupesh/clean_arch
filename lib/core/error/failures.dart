import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have properties, they'll be defined final in the constructor
  // and passed to the super constructor.
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => []; // Adjust if properties are added
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {} 