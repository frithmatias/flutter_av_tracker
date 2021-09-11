part of 'widgets.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return Container();
        } else {
          return FadeIn(child: buildSearchBar(context));
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: width,
          child: GestureDetector(
            onTap: () async {
              final result = await showSearch(context: context, delegate: SearchDestination());
              resultadoBusqueda(context, result!);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              width: double.infinity,
              child: const Text('¿A donde vamos?',
                  style: TextStyle(color: Colors.black54, fontSize: 18)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 5))
                  ]),
            ),
          )),
    );
  }

  void resultadoBusqueda(BuildContext context, SearchResults result) {

    if (result.cancelo) return;

    if (result.manual == true) {
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }

    if(result.ubicacion == null) return;

    TrafficService().getRouteTo(context, result.ubicacion);

    final busquedaBloc = context.read<BusquedaBloc>(); 
    final yaexiste = busquedaBloc.state.historial.where((element) => element.nombre == result.nombre);
    if(yaexiste.isEmpty) busquedaBloc.add(OnSavePlace(result));

  }
}
