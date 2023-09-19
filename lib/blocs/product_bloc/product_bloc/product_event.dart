// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}
  class Getproduct extends ProductEvent{

      
  }
 @immutable
class AddQuantite extends ProductEvent {
 final  ProductModel productModel;
   int quantite;
  AddQuantite({
    required  this.productModel,
     this.quantite=1
    
  });
  

  }
  class DecreaseQuantite extends ProductEvent {
  final ProductModel productModel;
   int quantite;
 DecreaseQuantite ({
    required  this.productModel,
     this.quantite=1
    
  });
  
  

  }
class RatingProductEvent extends ProductEvent {
   final double ratingproduct;
   final ProductModel productModel;
   final String productId;
 const RatingProductEvent({
    required this.ratingproduct, required this.productModel,required this.productId
  });
  }
