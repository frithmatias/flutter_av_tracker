part of 'widgets.dart';


class BtnUbicacion extends StatelessWidget {
  const BtnUbicacion({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapaBloc = context.read<MapaBloc>();
    final ubicacionBloc = context.read<MiUbicacionBloc>();

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(  
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(  
          icon: const Icon( Icons.my_location, color: Colors.black54), 
          onPressed: () {
            mapaBloc.moverCamara(ubicacionBloc.state.ubicacion!);
          },
        )
      )
    );
  }
}