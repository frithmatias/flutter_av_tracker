part of 'mapa_bloc.dart';

@immutable
// abstract class MapaState {}

// class MapaInitial extends MapaState {}
class MapaState {
  final bool mapaListo; // voy a crear un evento que cambie este estado
  const MapaState({this.mapaListo = false});


  MapaState copyWith({
    bool mapaListo = false
  }) => MapaState(mapaListo: mapaListo);
}
