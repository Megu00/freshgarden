// ignore_for_file: must_be_immutable

part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  List<ProductModel> products = [];
  ProductLoaded({required this.products});
   @override
  List<Object> get props => [products];
}

class ErrorLoaded extends ProductState {
 final String errortext;
 const ErrorLoaded({
    required this.errortext,
  });
}

class Productloading extends ProductState {}

class Qantitestate extends ProductState {
  final ProductModel productModel;
  
const Qantitestate({
    required this.productModel , 
  });
  @override
  List<Object> get props => [productModel];

}


