import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/buttons/go_to_my_position.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/buttons/zoom.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/connectivity_page.dart';
import 'package:provider/provider.dart';

import '../home_controller.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (_, controller, gpsMessageWidget) {
        // Si el GPS esta apagado
        if (!controller.gpsEnabled) {
          return gpsMessageWidget!;
        }

        final initialCameraPosition = CameraPosition(
          target: LatLng(
            controller.initialPosition!.latitude,
            controller.initialPosition!.longitude
          ),
          zoom: 16.5
        );

        return Stack(
          children: [
            GoogleMap(
              markers: controller.markers,
              polylines: controller.polylines,
              polygons: controller.polygons,
              onMapCreated: controller.onMapCreated,
              //initialCameraPosition: controller.initialCameraPosition,
              initialCameraPosition: initialCameraPosition,
          
              // Bloquear boton de direccion
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              // Bloquear movimiento del mapa(movimiento)
              // scrollGesturesEnabled: false,
          
              // Bloquear zoom
              zoomGesturesEnabled: true,
          
              // Mostrar boton de zoom(Disponible solo para android)
              zoomControlsEnabled: false,
          
              // Tipo de mapa
              mapType: MapType.normal,
          
              /*
                      onTap: (position){
                        print( position);
                      },
                      */
          
              onLongPress: (position) {
                print(position);
              },
          
              // Esconder compas
              compassEnabled: false,
          
              onTap: controller.onTap,
            ),
            const ZoomPosition(),
            const GoToMyPositionButton(),
            const ConnetivityPage(),
          ] 
        );
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'To use out app we need the access to your location,\n so you must enable the GPS',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                final controller = context.read<HomeController>();
                controller.turnOnGPS();
              },
              child: const Text('Turn on GPS'),
            )
          ],
        ),
      ),
    );
  }
}
