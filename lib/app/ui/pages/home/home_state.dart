import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeState {
  final bool loading, gpsEnabled, fetching;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final LatLng? initialPosition;
  // Place? origin, destination;
  final PickFromMap? pickFromMap;

  HomeState({
    required this.loading,
    required this.gpsEnabled,
    required this.markers,
    required this.polylines,
    required this.initialPosition,
    // this.origin,
    // this.destination,
    required this.fetching,
    required this.pickFromMap,
  });

  static HomeState get initialState => HomeState(
        loading: true,
        gpsEnabled: false,
        markers: {},
        polylines: {},
        initialPosition: null,
        // origin: null,
        // destination: null,
        fetching: false,
        pickFromMap: null,
      );

  HomeState copyWith({
    bool? loading,
    bool? gpsEnabled,
    bool? fetching,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    LatLng? initialPosition,
    // Place? origin,
    // Place? destination,
    PickFromMap? pickFromMap,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      gpsEnabled: gpsEnabled ?? this.gpsEnabled,
      fetching: fetching ?? this.fetching,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      initialPosition: initialPosition ?? this.initialPosition,
      // origin: origin ?? this.origin,
      // destination: destination ?? this.destination,
      pickFromMap: pickFromMap ?? this.pickFromMap,
    );
  }

  HomeState clearOriginAndDestination(bool fetching) {
    return HomeState(
      loading: loading,
      gpsEnabled: gpsEnabled,
      fetching: fetching,
      markers: {},
      polylines: {},
      initialPosition: initialPosition,
      // origin: null,
      // destination: null,
      pickFromMap: null,
    );
  }

  HomeState setPickFromMap(bool isOrigin) {
    return HomeState(
      pickFromMap: PickFromMap(
        // place: null,
        isOrigin: isOrigin,
        // origin: origin,
        // destination: destination,
        markers: markers,
        polylines: polylines,
        dragging: false,
      ),
      markers: {},
      polylines: {},
      // origin: null,
      // destination: null,
      loading: loading,
      fetching: fetching,
      gpsEnabled: gpsEnabled,
      initialPosition: initialPosition,
    );
  }

  HomeState cancelPickFromMap() {
    final prevData = pickFromMap!;

    return HomeState(
      loading: loading,
      gpsEnabled: gpsEnabled,
      fetching: fetching,
      markers: prevData.markers,
      polylines: prevData.polylines,
      initialPosition: initialPosition,
      // origin: prevData.origin,
      // destination: prevData.destination,
      pickFromMap: null,
    );
  }

  HomeState confirmOriginAndDestination() {
    final data = pickFromMap!;

    return HomeState(
      loading: loading,
      gpsEnabled: gpsEnabled,
      markers: markers,
      polylines: polylines,
      initialPosition: initialPosition,
      // origin: data.isOrigin ? data.place : data.origin,
      // destination: !data.isOrigin ? data.place : data.destination,
      fetching: fetching,
      pickFromMap: null,
    );
  }
}

class PickFromMap {
  // final Place? place, origin, destination;
  final bool isOrigin, dragging;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;

  PickFromMap({
    // required this.place,
    required this.isOrigin,
    // required this.origin,
    // required this.destination,
    required this.markers,
    required this.polylines,
    required this.dragging,
  });

  PickFromMap copyWith({
    // Place? place,
    // Place? origin,
    // Place? destination,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    bool? isOrigin,
    bool? dragging,
  }) {
    return PickFromMap(
      // place: place ?? this.place,
      isOrigin: isOrigin ?? this.isOrigin,
      // origin: origin ?? this.origin,
      // destination: destination ?? this.destination,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      dragging: dragging ?? this.dragging,
    );
  }
}
