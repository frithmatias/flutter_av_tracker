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
        body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (context, state) => crearMapa(state),
        ), 
        floatingActionButton: Column(  
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [  
            BtnUbicacion(),
            BtnMiRuta(),
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
      target: state.ubicacion!,
      zoom: 15,
    );

    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    mapaBloc.add(OnCambiaUbicacion(state.ubicacion!));

    print(mapaBloc.state);

    if(mapaBloc.state.seguir){
      mapaBloc.moverCamara(state.ubicacion!);
    }

    late LatLng mapaCenter;
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: camPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMapa,
      polylines: mapaBloc.state.dibujarRecorrido ? mapaBloc.state.polylines.values.toSet() : {},
      onCameraMove: ( cameraPosition ) { mapaCenter = cameraPosition.target; },
      onCameraIdle: () { 
        mapaBloc.add( OnMapaMovio( LatLng(mapaCenter.latitude, mapaCenter.longitude) ));
      },

    );
  }
}
