part of 'busqueda_bloc.dart';

@immutable
class BusquedaState {

  final bool seleccionManual;
  final List<SearchResults> historial;

  const BusquedaState({  
    this.seleccionManual = false,
    this.historial = const []
  });
   

  BusquedaState copyWith({  
    bool? seleccionManual,
    List<SearchResults>? historial
  }) => BusquedaState(  
    seleccionManual: seleccionManual ?? this.seleccionManual,
    historial: historial ?? this.historial 
  );
}

