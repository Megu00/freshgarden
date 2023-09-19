part of 'order_details_bloc.dart';

class OrderDetailsEvent extends Equatable {
  const OrderDetailsEvent();

  @override
  List<Object> get props => [];
}
class Getorderdetails extends OrderDetailsEvent {
    final String orderId;
const  Getorderdetails({
    required this.orderId,
  });
   }
