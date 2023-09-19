part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddProduct extends CartEvent {
  final ProductModel productModel;
  const AddProduct({
    required this.productModel,
  });
  @override
  List<Object> get props => [productModel];
}

class RemouveProduct extends CartEvent {
  final ProductModel productModel;
  const RemouveProduct({
    required this.productModel,
  });
  @override
  List<Object> get props => [productModel];
}

class Clearproducts extends CartEvent {}


class IncreaseProduct extends CartEvent {
  final String productid;
 final  int quantite;
 const IncreaseProduct({
    required this.productid,
   required   this.quantite
  });
 

}
class DecreaseProduct extends CartEvent {
  final String productid;
  final int quantite;
 const DecreaseProduct({
    required this.productid,
    required this.quantite,
  });
}
