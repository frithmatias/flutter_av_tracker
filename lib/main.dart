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
        BlocProvider( create: (_) => MiUbicacionBloc()),
        BlocProvider( create: (_) => MapaBloc()), 
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