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
              builder: (context, state) => crearMapa(state),
            ),



            // NO voy a implementar un BlocBuilder acá, lo voy a hacer dentro de Search()
            const Positioned(
             top: 0,
             child: Search()
            ),
            
            // NO voy a implementar un BlocBuilder acá, lo voy a hacer dentro de MarcadorManual() 
            const MarcadorManual()

          ],
        ), 
        floatingActionButton: Column(  
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [  
            BtnUbicacion(),
            BtnMiRecorrido(),
            BtnSeguir()
          ]
        ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) {
      return const Center(child: Text('Localizando...'));
    }

    final CameraPosition camPosition = CameraPosition(
      bearing: 0,
      target: state.ubicacion,
      zoom: 15,
    );

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnCambiaUbicacion(state.ubicacion));

    if(mapaBloc.state.seguir){
      mapaBloc.moverCamara(state.ubicacion);
    }

    LatLng mapaCenter = state.ubicacion;

    
    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
            return GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: camPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: mapaBloc.initMapa,
              polylines: state.dibujarRecorrido ? state.polylines.values.toSet() : {},
              onCameraMove: ( cameraPosition ) { mapaCenter = cameraPosition.target; },
              onCameraIdle: () { 
                mapaBloc.add( OnMapaMovio( LatLng(mapaCenter.latitude, mapaCenter.longitude) ));
              },
            );
      },
    );

  }
}
