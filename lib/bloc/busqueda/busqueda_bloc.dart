import 'dart:async'; 
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:rutas_app/models/search_results.dart'; 

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(const BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    if (event is OnActivarMarcadorManual) {
      yield state.copyWith(seleccionManual: true);
    } else if (event is OnDesactivarMarcadorManual) {
      yield state.copyWith(seleccionManual: false);
    } else if (event is OnSavePlace) {

      List<SearchResults> nuevoHistorial = [...state.historial, event.resultToSave];
      yield state.copyWith(historial: nuevoHistorial);
    }
  }
}
