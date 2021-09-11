part of 'helpers.dart';


Future<BitmapDescriptor> getIconoAssets() async {
  return await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(  
      devicePixelRatio: 2.0
    ), 'assets/custom-pin.png');
} 


Future<BitmapDescriptor> getIconoNetwork() async {

  final resp = await Dio().get('https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
  options: Options( responseType: ResponseType.bytes));

  // resize img
  final img = resp.data;
  final imgCodec = await ui.instantiateImageCodec(img, targetHeight: 100, targetWidth: 100);
  final frame = await imgCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());

} 