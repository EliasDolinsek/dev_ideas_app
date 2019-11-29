import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class DevProjectsBlocBloc extends Bloc<DevProjectsBlocEvent, DevProjectsBlocState> {
  @override
  DevProjectsBlocState get initialState => InitialDevProjectsBlocState();

  @override
  Stream<DevProjectsBlocState> mapEventToState(
    DevProjectsBlocEvent event,
  ) async* {

  }
}
