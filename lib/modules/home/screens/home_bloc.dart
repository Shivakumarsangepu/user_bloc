import 'package:bloc/bloc.dart';
import 'package:users_list_bloc/modules/home/screens/home_event.dart';
import 'package:users_list_bloc/modules/utils/base_state.dart';
import 'home_repository.dart';

class HomeBloc extends Bloc<HomeEvent,BaseState>{
  final HomeRepository _repository = const HomeRepository();
  HomeBloc({required BaseState initialState}) : super(initialState){
    on <GetHomePageDetails>(_onGetHomePageDetails);
  }
  Future<void> _onGetHomePageDetails(event ,Emitter<BaseState>emit) async {
    emit (Loading());
    try {
      final response = await _repository.getHomePageDetails() ;
      emit (DataLoaded(event: "GetHomePageDetails",data: response));
    } catch (error) {
      emit (BaseError(error.toString()));

    }
  }
}