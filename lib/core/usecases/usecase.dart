
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class MovieParams extends Equatable{
  final String search;

  const MovieParams({required this.search});

  @override
  List<Object?> get props => [];
}