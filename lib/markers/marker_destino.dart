part of 'markers.dart';


class MarkerDestinoPainter extends CustomPainter {


  final String descripcion;
  final double metros;

  MarkerDestinoPainter(this.descripcion, this.metros);

  @override
 @override
  void paint(Canvas canvas, Size size) {
    const double radioCirculoNegro = 20;
    const double radioCirculoBlanco = 7;

    // pointer
    Paint paint = Paint()..color = Colors.black87;
    //paint.color = Colors.black87;

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
    path.moveTo(0, 20);
    path.lineTo(size.width - 10, 20);
    path.lineTo(size.width - 10, 100);
    path.lineTo(0, 100);
    canvas.drawShadow(path, Colors.black87, 10, false);

    // white box
    final cajaBlanca = Rect.fromLTWH(10, 20, size.width - 20, 80);
    canvas.drawRect(cajaBlanca, paint);
    
    // black box
    paint.color = Colors.black;
    const cajaNegra = Rect.fromLTWH(10, 20, 70, 80);
    canvas.drawRect(cajaNegra, paint);


    // kms number
    double kms = metros / 1000; 
    kms = (kms * 10).floor().toDouble();
    kms = kms / 10;

    TextSpan textSpan = TextSpan(  
      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w400), 
      text: '$kms'
    );

    TextPainter textPainter = TextPainter(
      text: textSpan, 
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(maxWidth: 70, minWidth: 70);
    
    textPainter.paint(canvas, const Offset(10, 33));

    // kms text
    textSpan = const TextSpan(  
      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400), 
      text: 'Kms'
    );

    textPainter = TextPainter(  
      text: textSpan, 
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center
    )..layout(maxWidth: 70, minWidth: 70);
   
    textPainter.paint(canvas, const Offset(10, 70));

    // destination place description
    textSpan = TextSpan(  
      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400, height: 1.5), 
      text: descripcion
    );

    textPainter = TextPainter(  
      text: textSpan, 
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left, 
      maxLines: 2,
      ellipsis: '...'
    )..layout(maxWidth: size.width - 120 );
   
    textPainter.paint(canvas, const Offset(95, 28));

  }


  @override
  bool shouldRepaint(MarkerDestinoPainter oldDelegate) => true;

  // @override
  // bool shouldRebuildSemantics(MarkerDestinoPainter oldDelegate) => false;
}