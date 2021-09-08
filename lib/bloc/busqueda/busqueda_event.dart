part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}

class OnActivarMarcadorManual extends BusquedaEvent{}
class OnDesactivarMarcadorManual extends BusquedaEvent{}
class OnSavePlace extends BusquedaEvent{
  final SearchResults resultToSave;
  OnSavePlace(this.resultToSave);
}
