part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
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
        Positioned(
            top: 70,
            left: 20,
            child: FadeInLeft(
              child: CircleAvatar(
                maxRadius: 20,
                backgroundColor: Colors.white,
                child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context
                          .read<BusquedaBloc>()
                          .add(OnDesactivarMarcadorManual());
                    }),
              ),
            )),
        Center(
          child: Transform.translate(
              offset: const Offset(0, -15),
              child: BounceInDown(
                  child: const Icon(Icons.location_on,
                      color: Colors.blue, size: 40))),
        ),
        Positioned(
            bottom: 70,
            left: 40,
            child: FadeIn(
              duration: const Duration(milliseconds: 800),
              child: MaterialButton(
                  minWidth: width - 100,
                  child: const Text('Confirmar destino',
                      style: TextStyle(color: Colors.white)),
                  color: Colors.black,
                  shape: const StadiumBorder(),
                  elevation: 0,
                  splashColor: Colors.yellow,
                  onPressed: () {
                    calcularDestino(context);
                  }),
            ))
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    calculandoAlerta(context);

    final from = context.read<MiUbicacionBloc>().state.ubicacion;
    final to = context.read<MapaBloc>().state.ubicacionCentral;
    final mapboxResponse = await TrafficService().getCoordsFromTo(from, to);

    final geometry = mapboxResponse.routes[0].geometry;
    final duration = mapboxResponse.routes[0].duration;
    final distance = mapboxResponse.routes[0].distance;

    final coords = poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;
    final List<LatLng> points =
        coords.map((coord) => LatLng(coord[0], coord[1])).toList();

    context.read<MapaBloc>().add(OnCrearRuta(points, distance, duration));
    context.read<BusquedaBloc>().add(OnDesactivarMarcadorManual());
    context
        .read<MapaBloc>()
        .moverCamara(context.read<MiUbicacionBloc>().state.ubicacion);
    Navigator.of(context).pop();
  }
}
