// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'barnner_bloc.dart';

 class BarnnerState extends Equatable {
  const BarnnerState();
  
  @override
  List<Object> get props => [];
}

 class BarnnerInitial extends BarnnerState {}
class BarnnerLoaded extends BarnnerState {
final  List<Document> barrner;
 const BarnnerLoaded({
    required this.barrner,
  });
 }

 class BarnnerLoading extends BarnnerState{}


class BarnnerError extends BarnnerState {
  final String errortext;
 const BarnnerError({
    required this.errortext,
  });
 }
