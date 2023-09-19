import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fresh_garden/blocs/barnner/barnner_repo.dart';

part 'barnner_event.dart';
part 'barnner_state.dart';

class BarnnerBloc extends Bloc<BarnnerEvent, BarnnerState> {
final  BarnnerRepo _barnnerRepo;
  BarnnerBloc({required BarnnerRepo barnnerRepo})
      : _barnnerRepo = barnnerRepo,
        super(BarnnerInitial()) {
    on<GetBarnnerEvent>((event, emit) async {
      try {
        emit(BarnnerLoading());
        List<Document> barnner = [];
        barnner = await _barnnerRepo.getbarrnerList();

        emit(BarnnerLoaded(barrner: barnner));
      } catch (e) {
        emit(BarnnerError(errortext: e.toString()));
      }
    });
  }
}
