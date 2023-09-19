import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fresh_garden/blocs/cart/bloc/cart_bloc.dart';

import 'package:fresh_garden/models/product_model.dart';

import 'package:fresh_garden/presentation/order_finish.dart';

import '../check_outrepo.dart';

part 'chekout_state.dart';

class ChekoutCubit extends Cubit<ChekoutState> {
  final CheckOutRepo _checkOutRepo;
  final CartBloc _cartBloc;

  ChekoutCubit({required CheckOutRepo checkOutRepo, required CartBloc cartBloc})
      : _checkOutRepo = checkOutRepo,
        _cartBloc = cartBloc,
        super(const LoadedStep(curentindex: 0));
  int currentindex = 0;

  onsteptapp(int index) {
    currentindex = index;
    emit(LoadedStep(curentindex: currentindex));
  }

  onstepcontinue(List<ProductModel> cart, Map<String, dynamic> userdata,
      BuildContext context) async {
    if (currentindex == 2) {
      try {
        emit(LoadingChekoutstate());
        await _checkOutRepo.adduserorder(cart, userdata).then(
            (value) async => await _checkOutRepo.addorderdetails(cart, value));
        cart.clear();
        userdata.clear();
        _cartBloc.add(Clearproducts());
        finishchekout();
      
       
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else if (currentindex < 2) {
      currentindex = currentindex + 1;
      emit(LoadedStep(curentindex: currentindex));
    }
  }

  oncancelstep() {
    if (currentindex > 0) {
      currentindex = currentindex - 1;

      emit(LoadedStep(curentindex: currentindex));
    }
  }

  finishchekout() {
 
      emit(ChekoutFinshed());
 
  }

 
}
