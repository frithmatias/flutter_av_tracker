import 'package:flutter/material.dart';
import 'package:rutas_app/models/search_results.dart';

class SearchDestination extends SearchDelegate<SearchResults> {
  @override
  // ignore: overridden_fields
  final String searchFieldLabel;
  SearchDestination() : searchFieldLabel = 'Buscar';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
     
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, SearchResults(true));
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(children: [
      ListTile(
        leading: const Icon(Icons.location_on),
        title: const Text('Colocar ubicacion manualmente'),
        onTap: (){
          close(context, SearchResults(false, true)); // manual = true;
        }
      )
    ]);
  }
}
