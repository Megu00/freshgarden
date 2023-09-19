part of 'orders_bloc.dart';

class OrdersState extends Equatable {
  const OrdersState();
  
  @override
  List<Object> get props => [];
}

 class OrdersInitial extends OrdersState {}

class OrdersLoadedState extends OrdersState {
final  List<OrderModel> orders;
const  OrdersLoadedState({
    this.orders=const<OrderModel>[]
  });
 }
class OrdersLoadingState extends OrdersState{}

class ErrorOrdersState extends OrdersState {
final  String errortext;
 const ErrorOrdersState({
    required this.errortext,
  });
 }
