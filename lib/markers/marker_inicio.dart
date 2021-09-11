part of 'markers.dart';

class MarkerInicioPainter extends CustomPainter {

  final int minutos;

  MarkerInicioPainter(this.minutos);

  @override
  void paint(Canvas canvas, Size size) {

    const double radioCirculoNegro = 20;
    const double radioCirculoBlanco = 7;

    // pointer
    Paint paint = Paint()
    ..color = Colors.black87;

    canvas.drawCircle(  
      Offset(radioCirculoNegro, size.height - radioCirculoNegro), 
      radioCirculoNegro, 
      paint
    );

    paint.color = Colors.white;

    canvas.drawCircle(  
      Offset(radioCirculoNegro, size.height - radioCirculoNegro), 
      radioCirculoBlanco, 
      paint
    );

    // shadow
    final Path path = Path();
    path.moveTo(40, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(40, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // white box
    final cajaBlanca = Rect.fromLTWH(40, 20, size.width - 50, 80);
    canvas.drawRect(cajaBlanca, paint);
    
    // black box
    paint.color = Colors.black;
    const cajaNegra = Rect.fromLTWH(40, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);


    // min number
    TextSpan textSpan = TextSpan(  
      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400), 
      text: '$minutos'
    );

    TextPainter textPainter = TextPainter(  
      text: textSpan, 
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(maxWidth: 70, minWidth: 70);
    
    textPainter.paint(canvas, const Offset(39, 33));

    // min text
    textSpan = const TextSpan(  
      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400), 
      text: 'Min'
    );

    textPainter = TextPainter(  
      text: textSpan, 
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(maxWidth: 70, minWidth: 70);
   
    textPainter.paint(canvas, const Offset(40, 70));

    // my position
    textSpan = const TextSpan(  
      style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w400), 
      text: 'Mi Ubicación'
    );

    textPainter = TextPainter(  
      text: textSpan, 
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(maxWidth: size.width );
   
    textPainter.paint(canvas, const Offset(130, 50));

  }

  @override
  bool shouldRepaint(MarkerInicioPainter oldDelegate) => true;

  // @override
  // bool shouldRebuildSemantics(MarkerInicioPainter oldDelegate) => false;
}