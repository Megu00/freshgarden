import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_garden/blocs/orders_details/order_dr.dart';
import 'package:fresh_garden/models/order_dmodel.dart';

part 'order_details_event.dart';
part 'order_details_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailsEvent, OrderDetailsState> {
  final OrderDetailsRepo _orderDetailsRepo;
  OrderDetailsBloc(this._orderDetailsRepo) : super(OrderDetailsInitial()) {
    on<Getorderdetails>(_getorderdetails);
  

   

}
  void _getorderdetails (Getorderdetails event,Emitter<OrderDetailsState> emit)async{
  try{
   emit(OrderDetailsLoading());
   List<OrderDetailsModel> orders=[];
   orders=await _orderDetailsRepo.getorderdetails(event.orderId);
 emit(OrderDetailsLoaded(orderdetails: orders));

  }catch(e){
   
    emit(OrderDetailsError(errortext: e.toString()));
  }
   
  }
}