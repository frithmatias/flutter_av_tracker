part of 'widgets.dart';



class Search extends StatelessWidget {
  const Search({ Key? key }) : super(key: key);

// 2. Creo un metodo build con un BlocBuilder donde voy a llamar a mi buildSearchBar
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return Container();
        } else {
          return FadeIn(child: buildSearchBar(context));
        }
      },
    );
  }

  // 1. Renombro el metodo build a buildSearchBar
  Widget buildSearchBar(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: width,
          child: GestureDetector(
            onTap: () async {
              // el tipo SearchResults del resultado lo puedo definir en la clase 
              // class SearchDestination extends SearchDelegate<SearchResults>
              final result = await showSearch(context: context, delegate: SearchDestination());
              resultadoBusqueda(context, result!);
              // print('Buscando... $result');
              // I/flutter ( 7980): Buscando... Instance of 'SearchResults'
            },
            child: Container(  
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              width: double.infinity,
              child: const Text('¿A donde vamos?', style: TextStyle(color: Colors.black54, fontSize: 18)),
              decoration: BoxDecoration(  
                color: Colors.white, 
                borderRadius: BorderRadius.circular(100),
                boxShadow: const <BoxShadow> [  
                  BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0,5))
                ]
              ),
            ),
          )
        ),
      
    );
  }


  void resultadoBusqueda(BuildContext context, SearchResults result){
    // print('Cancelo?: ${result.cancelo}');
    // print('Manual?: ${result.manual}');
    if(result.cancelo) return;
    if(result.manual == true){
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
      // si selecciono con un clic un lugar en los resultados de la búsqueda

    }
  }

}


