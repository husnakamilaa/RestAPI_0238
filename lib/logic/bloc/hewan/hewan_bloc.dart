import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_event.dart';
import 'package:rest_api/logic/bloc/hewan/hewan_state.dart';
import '../../../data/repositories/hewan_repository.dart';

class HewanBloc extends Bloc<HewanEvent, HewanState> {
  final HewanRepository repository;

  HewanBloc({required this.repository}) : super(HewanInitial()) {
    on<FetchHewan>((event, emit) async {
      emit(HewanLoading());
      try {
        final list = await repository.getAllHewan();
        emit(HewanLoaded(list));
      } catch (e) {
        emit(HewanError(e.toString()));
      }
    });

    on<CreateHewan>((event, emit) async {
      emit(HewanLoading());
      try {
        await repository.createHewan(event.data);
        emit(HewanCreatedSuccess());
        add(FetchHewan());
      } catch (e) {
        emit(HewanError(e.toString()));
      }
    });

    on<UpdateHewan>((event, emit) async {
      emit(HewanLoading());
      try {
        await repository.updateHewan(event.id, event.data);
        emit(HewanCreatedSuccess());
        add(FetchHewan());
      } catch (e) {
        emit(HewanError(e.toString()));
      }
    });

    on<DeleteHewan>((event, emit) async {
      try {
        await repository.deleteHewan(event.id);
        emit(HewanCreatedSuccess());
        add(FetchHewan());
      } catch (e) {
        emit(HewanError(e.toString()));
      }
    });
  }
}