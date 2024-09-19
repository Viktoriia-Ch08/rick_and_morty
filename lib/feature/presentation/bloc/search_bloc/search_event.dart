import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchCharacterEvent extends SearchEvent {
  final String characterQuery;

  const SearchCharacterEvent({required this.characterQuery});
}
