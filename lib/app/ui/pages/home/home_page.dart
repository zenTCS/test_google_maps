import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/google_map.dart';
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
          appBar: AppBar(
            title: const Text('Google Maps Test'),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    final controller = context.read<HomeController>();
                    controller.newPolyline();
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    final controller = context.read<HomeController>();
                    controller.newPolygon();
                  },
                  icon: const Icon(Icons.map),
                ),
              )
            ],
          ),
          body: Selector<HomeController, bool>(
              selector: (_, controller) => controller.loading,
              builder: (context, loading, loadingWidget) {
                if (loading) {
                  return loadingWidget!;
                }

                return const MapView();
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ))),
    );
  }
}
