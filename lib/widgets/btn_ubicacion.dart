part of 'widgets.dart';


class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    // para acceder al metodo read() tengo que importar flutter_bloc.dart en widgets.dart
    // import 'package:flutter_bloc/flutter_bloc.dart';
    // import 'package:rutas_app/bloc/mapa/mapa_bloc.dart';
    // import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
    final mapaBloc = context.read<MapaBloc>();
    final ubicacionBloc = context.read<MiUbicacionBloc>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(  
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(  
          icon: const Icon( Icons.my_location, color: Colors.black87), 
          onPressed: () {
            mapaBloc.moverCamara(ubicacionBloc.state.ubicacion!);
          },
        )
      )
    );
  }
}