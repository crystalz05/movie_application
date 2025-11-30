
import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {

  @override
  List<Object?> get props => [];
}

class LoadMovieEvent extends MovieEvent{
  final String search;

  LoadMovieEvent({required this.search});
}
