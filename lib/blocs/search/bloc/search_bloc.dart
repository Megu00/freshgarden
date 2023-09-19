// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fresh_garden/blocs/search/search_repo.dart';
import 'package:fresh_garden/models/product_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo _searchRepo;
  SearchBloc({required SearchRepo searchRepo})
      : _searchRepo = searchRepo,
        super(SearchEmptyState()) {
    on<StarSearchEvent>(searchproduct);
  }

  searchproduct(StarSearchEvent event, Emitter state) async {
    try {
      final String searchtext = event.searchtext;
      if (searchtext.isEmpty) return emit(SearchEmptyState());

      List<ProductModel> products = [];
      if (event.searchtext.isNotEmpty) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(LoadingSearchState());
        products = await _searchRepo.search(event.searchtext);
        emit(SearcheFinished(products: products));
      } else if (event.searchtext.isEmpty) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(SearchEmptyState());
      }
    } catch (e) {
      emit(SearchErrorState(errortext: e.toString()));
    }
  }
}
