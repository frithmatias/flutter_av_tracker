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
  // convierto a statefulwidget para tener el initState y poder menejar el estado

  @override
  void initState() {
    // en mi initState necesito acceso a mi bloc de la ubicacion, podemos usar el BlocProvider

    //  final miubicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);
    //  miubicacionBloc.iniciarSeguimiento();

    // Pero podemos importar flutter_bloc.dart para accedar al context
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
    super.dispose();
  }

  // En el Widget voy a dibujar la data y para eso utilizo BlocBuilder para levantar la data de mi bloc
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (context, state) => crearMapa(state),
        ), 
        floatingActionButton: Column(  
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [  
            BtnUbicacion()
          ]
        ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    if (!state.existeUbicacion) {
      return const Center(child: Text('Localizando...'));
    }
    // return Center(child: Text('> ${state.ubicacion!.latitude},${state.ubicacion!.longitude} <'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    final CameraPosition camPosition = CameraPosition(
      bearing: 0,
      target: state.ubicacion!,
      zoom: 15,
    );

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: camPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      // ver las propiedades y metodos aquí, los eventos empiezan con 'on'

      // para trear la referencia al bloc podríamos hacer context.read() ... pero lo vamos a hacer de otra manera
      // onMapCreated: ( GoogleMapController controller ){
      //   mapaBloc.initMapa(controller);
      // },

      // como tengo un sólo argumento puedo reducir esta expresión.
      onMapCreated: mapaBloc.initMapa,
    );
  }
}
