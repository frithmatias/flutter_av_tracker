part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}

// El event es una clase abstracta donde nosotros vamos a EXTENDER nuestros propios eventos.

class OnActivarMarcadorManual extends BusquedaEvent{}
class OnDesactivarMarcadorManual extends BusquedaEvent{}
