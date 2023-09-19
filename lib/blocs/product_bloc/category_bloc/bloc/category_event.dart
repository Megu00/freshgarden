part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}
class GetcategoryEvent extends CategoryEvent{}
class GetCategoryProducts extends CategoryEvent {
 final String categoryname;
 const GetCategoryProducts({
    required this.categoryname,
  });
}
