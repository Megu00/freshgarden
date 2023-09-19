import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fresh_garden/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(cartitems: const [])) {
    on<AddProduct>((event, emit) {
      List<ProductModel> updatecart = List.from(state.cartitems);
      if (updatecart.contains(event.productModel)) {
        return;
      } else {
        updatecart.add(event.productModel);
        emit(CartState(cartitems: updatecart));
      }
    });

    on<RemouveProduct>((event, emit) {
      List<ProductModel> updatecart = List.from(state.cartitems);

      updatecart.remove(event.productModel);
      emit(CartState(cartitems: updatecart));
    });
    on<Clearproducts>(
      (event, emit) {
        final updatedcart = state.cartitems;
        updatedcart.clear();
        emit(CartState(cartitems: updatedcart));
      },
    );
    on<IncreaseProduct>((event, emit) {
      try {
        final updatecart = state.cartitems;
        updatecart.map((element) {
          if (event.productid == element.productid) {
           
              element.productQantite++;
            

            return element;
          }
        }).toList();

        emit(CartState(cartitems: updatecart));
      } catch (e) {
 
        // ignore: avoid_print
        print('errrrrrrrrrrrrrr+$e');
      }
    });
    on<DecreaseProduct>((event, emit) {
      try {
        final updatecart = state.cartitems;
        updatecart.map((element) {
          if (event.productid == element.productid) {
            if (element.productQantite > 1) {
              element.productQantite--;
            }

            return element;
          }
        }).toList();

        emit(CartState(cartitems: updatecart));
      } catch (e) {
        // ignore: avoid_print
        print('errrrrrrrrrrrrrr+$e');
      }
    });
  }
}
