import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rutas_app/bloc/mapa/mapa_bloc.dart';
import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:rutas_app/pages/mapa.dart';
import 'package:rutas_app/pages/acceso_gps.dart';
import 'package:rutas_app/pages/loading.dart';
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(  
      providers: [  
        // blocprovider -> snippet para BlocProvider
        // o ya sobre BlocProvider() > Ctrl+. > Add required argument 'create'
        BlocProvider( create: (_) => MiUbicacionBloc()),
        BlocProvider( create: (_) => MapaBloc()), 
        // inyecto una instancia del MapaBloc en el context para tener acceso a todas sus propiedades 
        // y metodos en cualquier widget
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'loading',
        routes: {
          'loading': (_) => const LoadingPage(),
          'accesogps': (_) => const AccesoGpsPage(),
          'mapa': (_) => const MapaPage(),
        },
      ),
    );
  }
}