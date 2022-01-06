import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/google_map.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
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
          // appBar: AppBar(
          //   title: const Text('Google Maps Test'),
          //   actions: [
          //     // Builder(
          //     //   builder: (context) => IconButton(
          //     //     onPressed: () {
          //     //       final controller = context.read<HomeController>();
          //     //       controller.newPolyline();
          //     //     },
          //     //     icon: const Icon(Icons.add),
          //     //   ),
          //     // ),
          //     // Builder(
          //     //   builder: (context) => IconButton(
          //     //     onPressed: () {
          //     //       final controller = context.read<HomeController>();
          //     //       controller.newPolygon();
          //     //     },
          //     //     icon: const Icon(Icons.map),
          //     //   ),
          //     // )
          //     IconButton(
          //       onPressed: (){
          //         _logout(context);
          //       },
          //       icon: const Icon(Icons.logout)
          //     )
          //   ],
          // ),
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
            )
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          // floatingActionButton: FloatingActionButton.extended(
          //   backgroundColor: const Color(0xFFFFFFFF),
          //   onPressed: () => _logout(context),
          //   label: const Text('Logout', style: TextStyle(color: Colors.black),),
          //   icon: const Icon(Icons.logout, color: Colors.black,),
          // ),
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
