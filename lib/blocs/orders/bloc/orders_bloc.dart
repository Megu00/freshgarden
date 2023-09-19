// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/order_model.dart';
import '../order_repo.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepo _ordersRepo;

  OrdersBloc(this._ordersRepo) : super(const OrdersLoadedState(orders: <OrderModel>[])) {
    on<GetOrders>((event, emit) async {
      try {
        emit(OrdersLoadingState());
     List<OrderModel>orders=[];
     orders=await _ordersRepo.getorders();
        emit(OrdersLoadedState(orders:orders ));
      } catch (e) {
        emit(ErrorOrdersState(errortext: e.toString()));
      }
    });
  }
}
