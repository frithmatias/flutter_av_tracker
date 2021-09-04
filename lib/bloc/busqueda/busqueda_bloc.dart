import 'dart:async'; // vamos a usar funciones generadoras

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart'; //@override, etc.

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(const BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    // tengo que transmitir un nuevo estado.
    if (event is OnActivarMarcadorManual) {
      yield state.copyWith(seleccionManual: true);
    } else if (event is OnDesactivarMarcadorManual) {
      yield state.copyWith(seleccionManual: false);
    }
  }
}
