import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/* Para assets
Future<Uint8List> assetToBytes(String path, {int width = 100}) async {
  final byteData = await rootBundle.load(path);
  final bytes = byteData.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(
    bytes, 
    targetWidth: width,
  );

  final frame = await codec.getNextFrame();
  final newByteData = await frame.image.toByteData(
    format: ui.ImageByteFormat.png,
  );

  return newByteData!.buffer.asUint8List();
}*/

Future<Uint8List> imageToBytes(
  String path, {
    int width = 100, 
    fromNetwork = false
  }) async {
    late Uint8List bytes;
    if(fromNetwork){
      DefaultCacheManager().getSingleFile(path);
    }
    else{
      final byteData = await rootBundle.load(path);
      bytes = byteData.buffer.asUint8List();
    }
  
  final codec = await ui.instantiateImageCodec(
    bytes, 
    targetWidth: width,
  );

  final frame = await codec.getNextFrame();
  final newByteData = await frame.image.toByteData(
    format: ui.ImageByteFormat.png,
  );
  
  return newByteData!.buffer.asUint8List();
}