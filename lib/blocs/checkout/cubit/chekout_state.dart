part of 'chekout_cubit.dart';

 class ChekoutState extends Equatable {
  const ChekoutState();

  @override
  List<Object> get props => [];
}



class LoadedStep extends ChekoutState {
  final int curentindex;
 const LoadedStep({
    required this.curentindex,
  });
    @override
  List<Object> get props => [curentindex];

 }

 class ChekoutFinshed extends ChekoutState{}

 class LoadingChekoutstate extends ChekoutState{}
class ErrorCheckoutState extends ChekoutState {
  final String errortext;
  const ErrorCheckoutState({
     this.errortext=''
  });
 }

