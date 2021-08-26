import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rutas_app/helpers/helpers.dart';
import 'package:rutas_app/pages/loading.dart';

class AccesoGpsPage extends StatefulWidget {
  const AccesoGpsPage({Key? key}) : super(key: key);

  @override
  State<AccesoGpsPage> createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage>
    with WidgetsBindingObserver {
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
      if (await Permission.location.isGranted) {
        Navigator.pushReplacement( context, navegarMapaFadeIn(context, const LoadingPage())); 
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Acceso a GPS'),
      MaterialButton(
        child: const Text('Solicitar Acceso',
            style: TextStyle(color: Colors.white)),
        color: Colors.black,
        shape: const StadiumBorder(),
        elevation: 0,
        splashColor: Colors.white12, 
        onPressed: () async {
          final status = await Permission.location
              .request(); 
          accesoGPS(status);
        },
      )
    ])));
  }

  void accesoGPS(PermissionStatus status) {
    switch (status) {

      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, 'mapa');
        break;

      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}
