// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorites_bloc.dart';

class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class GetFavoritesEvent extends FavoritesEvent {}

class AddToFavoritesEvent  extends FavoritesEvent{
 final FavoritesModel favoritesModel;
 const AddToFavoritesEvent({
    required this.favoritesModel,
  });
}

class DeletFromFavorites extends FavoritesEvent{
 final String favId;
 const DeletFromFavorites({
    required this.favId,
  });
}
