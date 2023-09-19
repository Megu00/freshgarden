import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';



import '../../../../models/category_model.dart';
import '../../../../models/product_model.dart';
import '../../product_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRepo _productRepo;
  CategoryBloc(
    this._productRepo,
  ) : super(CategoryInitial()) {
    on<GetcategoryEvent> (_getcategories);

    on<GetCategoryProducts>((event, emit) async {
      List<ProductModel> products =
          List.from(await _productRepo.getcategoyproducts(event.categoryname));
      emit(LoaddedCategoryProducts(products: products));
    });
  }

  void _getcategories(
      GetcategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      emit(LoadingCtaegory());
      List<CategoryModel> categories = [];
      categories = await _productRepo.getcategories();
      emit(CategoryLoaded(categories: categories));
    } catch (e) {
      emit(CategoryError(eroortext: e.toString()));
    }
  }
}
