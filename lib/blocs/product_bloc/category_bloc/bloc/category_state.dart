part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
  
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

// ignore: must_be_immutable
class CategoryLoaded extends CategoryState{
  List<CategoryModel> categories=[];
    CategoryLoaded({  required this.categories});
}


class LoadingCtaegory extends CategoryState{}

class CategoryError extends CategoryState {
 final String eroortext;
 const CategoryError({
    required this.eroortext,
  });
   @override
  List<Object> get props => [eroortext];
}
 class LoaddedCategoryProducts extends CategoryState{
 final List<ProductModel> products;
const LoaddedCategoryProducts({this.products=const<ProductModel>[]});
 }