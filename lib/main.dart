import 'package:flutter/material.dart';
import 'package:rutas_app/pages/acceso_gps.dart';
import 'package:rutas_app/pages/loading.dart';
import 'package:rutas_app/pages/mapa.dart';
 
void main() => runApp(const MyApp());
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'loading',
      routes: {
        'loading': (_) => const LoadingPage(),
        'accesogps': (_) => const AccesoGpsPage(),
        'mapa': (_) => const MapaPage(),
      },
    );
  }
}