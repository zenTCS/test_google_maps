import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/buttons/go_to_my_position.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/buttons/where_are_you_going.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/buttons/zoom.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/connectivity_page.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/custom_painters/origin_and_destination.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
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
            const WhereAreYouGoingButton(),
            // const OriginAndDestination(),
            // const ZoomPosition(),
            const GoToMyPositionButton(),
            const ConnetivityPage(),
            const LogoutButton(),
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

class LogoutButton extends StatelessWidget {
  const LogoutButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 35.0, left: 243.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoButton(
            color: Colors.white,
            padding: EdgeInsets.zero,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: const [
                  Icon(Icons.logout, color: Colors.black,),
                  SizedBox(width: 2.0,),
                  Text(
                    'Logout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () => _logout(context),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return CupertinoAlertDialog(
          title: const Text('Important', textAlign: TextAlign.center,),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            CupertinoDialogAction(
              child: const Text(
                'Cancel', 
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              child: const Text(
                'Accept',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () => Navigator.of(context).pop(Routes.LOGIN),
            )
          ],
        );
      }
    );
  }
}