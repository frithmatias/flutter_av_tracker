import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rutas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:rutas_app/pages/acceso_gps.dart';
import 'package:rutas_app/pages/loading.dart';
import 'package:rutas_app/pages/mapa.dart';
 
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