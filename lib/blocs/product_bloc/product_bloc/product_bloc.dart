import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:fresh_garden/blocs/product_bloc/product_repo.dart';
import 'package:fresh_garden/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo;

  ProductBloc({
    required ProductRepo productRepo,
  })  : _productRepo = productRepo,
        super(ProductInitial()) {
    on<Getproduct>((event, emit) async {
      try {
        List<ProductModel> products = [];
        emit(Productloading());
        products = await _productRepo.getproduct();
        emit(ProductLoaded(products: products));
      } catch (e) {
        print('Errrrrororr$e');
        emit(ErrorLoaded(errortext: e.toString()));
      }
    });
    on<AddQuantite>((event, emit) {
    try{
   ProductModel product = event.productModel;
      product.copyWith(productQantite: event.quantite++);
      // ignore: avoid_print
      print(product.productQantite);
      emit(Qantitestate(
        productModel: product,
      ));

    }catch(e){
           // ignore: avoid_print
           print(e);
    }
    });
    on<DecreaseQuantite>(
      (event, emit) {},
    );

    on<RatingProductEvent>((event, emit) async {
      ProductModel updateModel = event.productModel;
      List<String> ratings = updateModel.productrating;
      ratings.add(event.ratingproduct.toString());
      updateModel.copyWith(productrating: ratings);
      await productRepo
          .updateproductrating(updateModel.productid, updateModel.productrating)
          .whenComplete(() {
        productRepo.getspecifiqueproduct(event.productId);
      });
    });
  }
}
