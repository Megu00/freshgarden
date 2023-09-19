// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

 class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

 class StarSearchEvent extends SearchEvent{
 final String searchtext;

 const StarSearchEvent({required this.searchtext});
 @override
  List<Object> get props => [searchtext];
 }

