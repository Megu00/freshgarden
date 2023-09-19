// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

 class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}
 class SearchInitial extends SearchState {}


 class LoadingSearchState extends SearchState{}

class SearcheFinished extends SearchState {
final  List<ProductModel> products;

const SearcheFinished({
  this.products=const<ProductModel>[],
  });
  
 }

 class SearchEmptyState extends SearchState{}

class SearchErrorState extends SearchState {
 
final String errortext;
  const SearchErrorState({
    required this.errortext,
  });
 }
