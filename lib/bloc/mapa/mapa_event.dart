part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}
// cuando llame al evento OnMapaListo yo se que el mapa ya esta cargado
