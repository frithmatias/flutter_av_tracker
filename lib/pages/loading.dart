import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolib;
import 'package:permission_handler/permission_handler.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/pages/acceso_gps.dart';
import 'package:rutas_app/pages/mapa.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {

    if (state == AppLifecycleState.resumed) {
      if (await geolib.Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement( context, navegarMapaFadeIn(context, const LoadingPage())); 
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(

        future: checkGps(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(child: Text(snapshot.data));
          } else {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
        },
      ),
    );
  }

  Future checkGps(context) async {

    final permisosGPS = await Permission.location.isGranted;
    final gpsReady = await geolib.Geolocator.isLocationServiceEnabled();

    if (permisosGPS && gpsReady) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, const MapaPage()));
    } else if (!permisosGPS) {
      Navigator.pushReplacement(
          context, navegarMapaFadeIn(context, const AccesoGpsPage()));
      return 'Necesita permisos de GPS';
    } else if (!gpsReady) {
      return 'Active el GPS';
    }

  }
}
