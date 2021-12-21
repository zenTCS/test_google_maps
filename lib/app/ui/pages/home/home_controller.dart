import 'dart:async';
import 'package:flutter/cupertino.dart'
    show ChangeNotifier, ImageConfiguration, Offset, Size;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test/app/helpers/asset_to_bytes.dart';
import 'package:google_maps_test/app/ui/utils/map_style.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends ChangeNotifier {
  final Map<MarkerId, Marker> _markers = {
    const MarkerId('0'): Marker(
        markerId: const MarkerId('0'),
        position: const LatLng(10.485136888466092, -66.8205002322793),
        infoWindow: InfoWindow(
            title: "You're Here",
            snippet: "Hola",
            onTap: () {
              print('hola');
            })),
    const MarkerId('1'): const Marker(
        markerId: MarkerId('1'),
        position: LatLng(10.486271637153, -66.81997485458851),
        infoWindow: InfoWindow(title: "You're Here", snippet: "Hola")),
    const MarkerId('2'): const Marker(
        markerId: MarkerId('2'),
        position: LatLng(10.48565613046453, -66.8219670653343),
        infoWindow: InfoWindow(title: "You're Here", snippet: "Hola")),
    const MarkerId('3'): const Marker(
        markerId: MarkerId('3'),
        position: LatLng(10.486795822387661, -66.82131595909595),
        infoWindow: InfoWindow(title: "You're Here", snippet: "Hola")),
  };

  final Map<PolylineId, Polyline> _polylines = {};
  final Map<PolygonId, Polygon> _polygons = {};

  List<String> patient = [
    'Ernesto Marchetti',
    'Richard Velazco',
    'Jonathan Zheng',
    'Luis Marquina'
  ];

  Set<Marker> get markers => _markers.values.toSet();
  Set<Polyline> get polylines => _polylines.values.toSet();
  Set<Polygon> get polygons => _polygons.values.toSet();

  late BitmapDescriptor _carPin;

  final _markersController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markersController.stream;

  /*
  final initialCameraPosition = const CameraPosition(
    target: LatLng(10.485205455775908, -66.82052212429707),
    zoom: 16.5,
  );*/

  Position? _initialPosition, _lastPosition;
  Position? get initialPosition => _initialPosition;

  // Imagen como marcador
  final _chavezIcon = Completer<BitmapDescriptor>();  // Polylines

  bool _loading = true;
  bool get loading => _loading;

  late bool _gpsEnabled;
  bool get gpsEnabled => _gpsEnabled;

  StreamSubscription? _gpsSubscription, _positionSubscription;
  GoogleMapController? _mapController;

  String _polylineId = '1';
  String _polygonId = '1';

  // Imagen como marcador assets
  /*
  HomeController(){
    assetToBytes('assets/chavez2.png', width: 130).then(
      (value) {
        final bitmap =  BitmapDescriptor.fromBytes(value);
        _chavezIcon.complete(bitmap);
      },
    );
  }*/

  HomeController() {
    print(':V');
    _init();
    /*
    imageToBytes('assets/chavez2.png', width: 130).then(
      (value) {
        final bitmap =  BitmapDescriptor.fromBytes(value);
        _chavezIcon.complete(bitmap);
      },
    );*/
  }

  Future<void> _init() async {
    /* Polylines
    final value = await imageToBytes(
      'assets/chavez2.png',
      width: 130,
      fromNetwork: false,
    );

    final bitmap = BitmapDescriptor.fromBytes(value);
    _chavezIcon.complete(bitmap);
    */

    _carPin = BitmapDescriptor.fromBytes(await imageToBytes('assets/car.png', width: 60));
    _gpsEnabled = await Geolocator.isLocationServiceEnabled();
    _loading = false;
    // Escucha si el GPS esta apagado o encendido
    _gpsSubscription =
        Geolocator.getServiceStatusStream().listen((status) async {
      _gpsEnabled = status == ServiceStatus.enabled;
      if (_gpsEnabled) {
        print('_gpsEnabled $_gpsEnabled');
        _initLocationUpdate();
      }
    });

    _initLocationUpdate();
  }

  Future<void> _initLocationUpdate() async {
    bool initialized = false;
    await _positionSubscription?.cancel();
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    ).listen(
      (position) async {
        print('💀 $position');

        _setMyPositionMarker(position);
        if(initialized){
          notifyListeners();
        }

        if (!initialized) {
          print('💀 init $position');
          _setInitialPosition(position);
          initialized = true;
          notifyListeners();
        }

        if (_mapController != null) {
          final zoom = await _mapController!.getZoomLevel();
          final cameraUpdate = CameraUpdate.newLatLngZoom(
            LatLng(position.latitude, position.longitude),
            zoom,
          );
          _mapController!.animateCamera(cameraUpdate);
        }
      },
      onError: (e) {
        print('💀 onError ${e.runtimeType}');
        if (e is LocationServiceDisabledException) {
          _gpsEnabled = false;
          notifyListeners();
        }
      },
    );
  }

  void _setInitialPosition(Position position) {
    if (_gpsEnabled && _initialPosition == null) {
      // _initialPosition = await Geolocator.getLastKnownPosition();
      // _initialPosition = await Geolocator.getCurrentPosition();
      _initialPosition = position;
      print('initialPosition $_initialPosition');
    }
  }

  void _setMyPositionMarker(Position position){
    double rotation = 0;
    if(_lastPosition != null){
      rotation = Geolocator.bearingBetween(
        _lastPosition!.latitude, 
        _lastPosition!.longitude, 
        position.latitude, 
        position.longitude
      );
    }
    const markerId = MarkerId('my-position');
    final marker = Marker(
      markerId: markerId,
      position: LatLng(position.latitude, position.longitude),
      icon: _carPin,
      anchor: const Offset(0.5, 0.5),
      rotation: rotation,
    );

    _markers[markerId] = marker;
    _lastPosition = position;
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
    _mapController = controller;
  }

  Future<void> turnOnGPS() => Geolocator.openLocationSettings();

  void newPolyline() {
    _polylineId = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void newPolygon() {
    _polygonId = DateTime.now().millisecondsSinceEpoch.toString();
  }

  void onTap(LatLng position) async {
    // Marcador
    final id = _markers.length.toString();
    final markerId = MarkerId(id);

    // Imagen como marcador
    //final icon = await _chavezIcon.future;

    final marker = Marker(
        markerId: markerId,
        position: position,
        draggable: true,
        anchor: const Offset(0.5, 1),
        // icon: icon,
        icon: BitmapDescriptor.defaultMarkerWithHue(200),
        // rotation: 45,
        onTap: () {
          _markersController.sink.add(id);
        },
        onDragEnd: (newPosition) {
          print('New position $newPosition');
        });

    _markers[markerId] = marker;
    notifyListeners();
    
    

    /* Polylines
    final polylineId = PolylineId(_polylineId);
    late Polyline polyline;
    if (_polylines.containsKey(polylineId)) {
      final tmp = _polylines[polylineId]!;
      polyline = tmp.copyWith(
        pointsParam: [...tmp.points, position],
      );
    } else {
      final color = Colors.primaries[_polylines.length];
      polyline = Polyline(
        polylineId: polylineId,
        points: [position],
        width: 5,
        color: color,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        /*patterns: const [
            PatternItem.dot,
            // PatternItem.gap(10),
          ]*/
      );
    }

    _polylines[polylineId] = polyline;
    notifyListeners();
    */
    
    /*
    final polygonId = PolygonId(_polygonId);
    late Polygon polygon;
    if (_polygons.containsKey(polygonId)) {
      final tmp = _polygons[polygonId]!;
      polygon = tmp.copyWith(
        pointsParam: [...tmp.points, position],
      );
    } else {
      final color = Colors.primaries[_polygons.length];
      polygon = Polygon(
        polygonId: polygonId,
        points: [position],
        strokeWidth: 4,
        strokeColor: color,
        fillColor: color.withOpacity(0.4),
      );
    }

    _polygons[polygonId] = polygon;
    notifyListeners();
    */
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Cuando la pagina home sea destruida, dejara de escuchar los cambios de GPS
    _positionSubscription?.cancel();
    _gpsSubscription?.cancel();
    _markersController.close();
    super.dispose();
  }
}
