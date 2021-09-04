part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return _MarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}


class _MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [  

        // Botón para volver atrás
        Positioned(
          top: 70, 
          left: 20,
          child: FadeInLeft(
            child: CircleAvatar(  
              maxRadius: 20,
              backgroundColor: Colors.white,
              child: IconButton( 
                icon: const Icon(Icons.arrow_back), 
                onPressed: (){
                  context.read<BusquedaBloc>().add(OnDesactivarMarcadorManual());
                }),
              
            ),
          ) 
        ),

        Center(
          child: Transform.translate(
            offset: const Offset(0, -15), 
            child: BounceInDown(child: const Icon(Icons.location_on, color: Colors.blue, size: 40))
          ),
        ),


        // Botón de confirmar destino 
        Positioned(  
          bottom: 70, 
          left: 40, 
          
          child: FadeIn(
            duration: const Duration(milliseconds: 800),
            child: MaterialButton(
              
              minWidth: width - 100,
              child: const Text('Confirmar destino', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: const StadiumBorder(),
              elevation: 0,
              splashColor: Colors.yellow,
              onPressed: (){
          
              }
            ),
          )
        )

      ],
    );

  }
}