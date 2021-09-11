import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rutas_app/bloc/mapa/mapa_bloc.dart';

import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:rutas_app/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
              builder: (context, miUbicacionState) {
            return BlocBuilder<MapaBloc, MapaState>(
              builder: (context, mapaState) =>
                  crearMapa(miUbicacionState, mapaState),
            );
          }),
          const Positioned(top: 0, child: Search()),
          const MarcadorManual()
        ],
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [BtnUbicacion(), BtnMiRecorrido(), BtnSeguir()]),
    );
  }

  Widget crearMapa(MiUbicacionState miUbicacionState, MapaState mapaState) {
    if (!miUbicacionState.existeUbicacion) {
      return const Center(child: Text('Localizando...'));
    }

    final CameraPosition camPosition = CameraPosition(
      bearing: 0,
      target: miUbicacionState.ubicacion,
      zoom: 15,
    );

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnCambiaUbicacion(miUbicacionState.ubicacion));

    if (mapaBloc.state.seguir) {
      mapaBloc.moverCamara(miUbicacionState.ubicacion);
    }

    LatLng mapaCenter = miUbicacionState.ubicacion;

    Map<String, Polyline> miRecorridoRemoved = {};

    if (!mapaState.dibujarRecorrido &&
        miRecorridoRemoved.containsKey('mi_recorrido')) {
      miRecorridoRemoved = mapaState.polylines;
      miRecorridoRemoved.remove('mi_recorrido');
    }

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: camPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMapa,
      polylines: mapaState.dibujarRecorrido
          ? mapaState.polylines.values.toSet()
          : miRecorridoRemoved.values.toSet(),
      markers: mapaState.markers.values.toSet(),
      onCameraMove: (cameraPosition) {
        mapaCenter = cameraPosition.target;
      },
      onCameraIdle: () {
        mapaBloc.add(
            OnMapaMovio(LatLng(mapaCenter.latitude, mapaCenter.longitude)));
      },
    );
  }
}
