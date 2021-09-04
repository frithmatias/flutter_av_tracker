part of 'busqueda_bloc.dart';

// @immutable
// abstract class BusquedaState {}
// class BusquedaInitial extends BusquedaState {}

@immutable
class BusquedaState {

  final bool seleccionManual;

  const BusquedaState({  
    this.seleccionManual = false
  });

  BusquedaState copyWith({  
    bool? seleccionManual
  }) => BusquedaState(  
    // devuelve una instancia de mi BusquedaState y si recibe una propiedad como argumento
    // mantiene el estado anterior
    seleccionManual: seleccionManual ?? this.seleccionManual 
  );
}

