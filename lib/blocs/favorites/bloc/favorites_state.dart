// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

 class FavoritesState extends Equatable {
  const FavoritesState();
  
  @override
  List<Object> get props => [];
}
 class FavoritesInitial extends FavoritesState {}


class FavoritesLoadedState extends FavoritesState{
 final List<FavoritesModel>favorites;
 const FavoritesLoadedState({this.favorites=const<FavoritesModel>[]});
   @override
  List<Object> get props => [favorites];
}

class FavoritesErrorState  extends FavoritesState{
 final String errortext;
 const FavoritesErrorState({
    required this.errortext,
  });
}
class FavoritesLoadingState extends FavoritesState{}
