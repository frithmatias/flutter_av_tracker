import 'package:flutter/material.dart';
import 'package:rutas_app/markers/markers.dart';
// import 'package:rutas_app/markers/marker_destino.dart';
// import 'package:rutas_app/markers/marker_inicio.dart';

class TestMarkerPage extends StatelessWidget {
  const TestMarkerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(  
          width: 350,
          height: 150,
          color: Colors.red, 
          child: CustomPaint(  
            painter: MarkerDestinoPainter('Proident duis culpa adipisicing occaecat ipsum.', 5687), 
          )
        )
     ),
   );
  }
}