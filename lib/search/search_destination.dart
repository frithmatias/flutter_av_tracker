import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:rutas_app/models/mapbox_place.dart';
import 'package:rutas_app/models/search_results.dart';
import 'package:rutas_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResults> {
  @override

  // ignore: overridden_fields
  final String searchFieldLabel;
  final TrafficService _trafficService; 
  SearchDestination() : 
    searchFieldLabel = 'Buscar', 
    _trafficService = TrafficService();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, SearchResults(true));
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);
    final location = miUbicacionBloc.state.ubicacion;
    _trafficService.getPlaces(query.trim(), location);
    return const Text('BuildResults');
  }


  Widget _emptyContainer(BuildContext context) {



    List<SearchResults> historial = context.read<BusquedaBloc>().state.historial;

    return ListView(children: [
      ListTile(
          leading: const Icon(Icons.location_on, color: Colors.red),
          title: const Text('Establecer en el Mapa',
              style: TextStyle(color: Colors.red, fontSize: 18)),
          onTap: () {
            close(context, SearchResults(false, true));
          }),

      ...historial.map((place) => ListTile(  
                leading: const Icon(Icons.history),
                title: Text(place.nombre!),
                subtitle: Text( place.descripcion! ),
                onTap: (){
                  close(context, SearchResults(false, false, place.ubicacion, place.nombre, place.descripcion));
                },
          ))
    
    ]);
  }

  Widget _waitContainer(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if (query.isEmpty) {
      return _emptyContainer(context);
    }

    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);
    final location = miUbicacionBloc.state.ubicacion;
    _trafficService.getPlacesFrom(query.trim(), location);
    
    return StreamBuilder(
        stream: _trafficService.suggestionStream,
        builder: (_, AsyncSnapshot<List<Place>> snapshot) {

        if (!snapshot.hasData) return _waitContainer(context);
       
        final places = snapshot.data!;
        return ListView.separated(
            itemCount: places.length,
            separatorBuilder: (_,i)=> const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(places[index].text),
                subtitle: Text( places[index].placeName ),
                onTap: (){
                  final LatLng pos = LatLng(places[index].geometry.coordinates[1], places[index].geometry.coordinates[0]);
                  close(context, SearchResults(false, false, pos, places[index].text, places[index].placeName));
                },
              );
            });
      },
    );
  }
}

