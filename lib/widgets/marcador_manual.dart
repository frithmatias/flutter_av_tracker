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
                calcularDestino(context);
              }
            ),
          )
        )

      ],
    );

  }



  void calcularDestino(BuildContext context) async {
    final trafficService = TrafficService();
    final from = context.read<MiUbicacionBloc>().state.ubicacion;
    final to = context.read<MapaBloc>().state.ubicacionCentral;
    final mapboxResponse = await TrafficService().getCoordsFromTo(from, to);

    final geometry = mapboxResponse.routes[0].geometry;
    final duration = mapboxResponse.routes[0].duration;
    final distance = mapboxResponse.routes[0].distance;

    final coords = poly.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords; // 6 posiciones decimales

    // convierto las coordenadas que llegan como List<double> a List<LatLng>
    final List<LatLng> points = coords.map((coord) => LatLng(coord[0], coord[1])).toList();
    print('CONFIRMAR DESTINO');
    print('Points: $points');
    print('Duration: $duration');
    print('Distance: $distance');

    context.read<MapaBloc>().add(OnCrearRuta(points, distance, duration));


    // POINTS:
    // decodedCoords:List (7 items)
    //   [0]:List (2 items)
    //      [0]:-34.583316
    //      [1]:-58.508982
    //   [1]:List (2 items)
    //   [2]:List (2 items)
    //   [3]:List (2 items)
    //   [4]:List (2 items)
    //   [5]:List (2 items)
    //   [6]:List (2 items)
    // distance:null
    // encodedString:"fpx}`AjjbrnB}LvKbs@ppAv}Ic}Hvq@~pAus@~n@_MgU"

  }
}