part of 'order_details_bloc.dart';

 class OrderDetailsState extends Equatable {
  const OrderDetailsState();
  
  @override
  List<Object> get props => [];
}
 class OrderDetailsInitial extends OrderDetailsState {}

class OrderDetailsLoaded extends OrderDetailsState{
  final List <OrderDetailsModel>orderdetails;
 const OrderDetailsLoaded({
     this.orderdetails=const<OrderDetailsModel>[]
  });
 }
 class OrderDetailsLoading extends OrderDetailsState{}

class OrderDetailsError extends OrderDetailsState {
final  String errortext;
const  OrderDetailsError({
    required this.errortext,
  });
 }
