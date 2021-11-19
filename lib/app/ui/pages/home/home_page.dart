import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:provider/provider.dart';

/* Al usar un provider, ya no es necesario usar StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}*/

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  /*
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(10.485205455775908, -66.82052212429707),
    zoom: 15,
  );
  */

  // Quitado por usar provider
  // final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (_) {
        final controller = HomeController();
        controller.onMarkerTap.listen((String id) {
          print('Go to $id');
        });
        return controller;
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Selector<HomeController, bool>(
              selector: (_, controller) => controller.loading,
              builder: (context, loading, loadingWidget) {
                if (loading) {
                  return loadingWidget!;
                }

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

                    return GoogleMap(
                      markers: controller.markers,
                      polylines: controller.polylines,
                      onMapCreated: controller.onMapCreated,
                      //initialCameraPosition: controller.initialCameraPosition,
                      initialCameraPosition: initialCameraPosition,

                      // Bloquear boton de direccion
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      // Bloquear movimiento del mapa(movimiento)
                      // scrollGesturesEnabled: false,

                      // Bloquear zoom
                      zoomGesturesEnabled: false,

                      // Mostrar boton de zoom(Disponible solo para android)
                      zoomControlsEnabled: true,

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
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ))),
    );
  }
}
