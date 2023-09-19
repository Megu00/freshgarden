import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_garden/blocs/favorites/fav_database.dart';
import 'package:fresh_garden/models/favorites_model.dart';


part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesDtatBase _favoritesDtatBase;
  FavoritesBloc({required FavoritesDtatBase favoritesDtatBase})
      : _favoritesDtatBase = favoritesDtatBase,
        super(const FavoritesLoadedState(favorites: <FavoritesModel>[])) {
    on<GetFavoritesEvent>((FavoritesEvent event, emit) async {
      try {
        emit(FavoritesLoadingState());
        List<FavoritesModel> favorites = [];
        favorites = await _favoritesDtatBase.getdata();
        emit(FavoritesLoadedState(favorites: favorites));
      } catch (e) {
        emit(FavoritesErrorState(errortext: e.toString()));
      }
    });
    on<AddToFavoritesEvent>((event, emit) async {
      try {
        await _favoritesDtatBase.addtoDtatabase(event.favoritesModel);
       add(GetFavoritesEvent());
      } catch (e) {
        emit(FavoritesErrorState(errortext: e.toString()));
      }
    });
    on<DeletFromFavorites>((event, emit) async {
      try {
        await _favoritesDtatBase.deletefavorite(event.favId);
        await _favoritesDtatBase.getdata();
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
  }
}
