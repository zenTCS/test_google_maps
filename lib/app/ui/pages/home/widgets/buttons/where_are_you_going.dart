import 'package:flutter/cupertino.dart';
import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/buttons/zoom.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/custom_painters/origin_and_destination.dart';
import 'package:google_maps_test/app/ui/pages/others/go_to_search.dart';
import 'package:google_maps_test/app/ui/pages/routes/routes.dart';
import 'package:google_maps_test/app/ui/pages/search_place/search_place_page.dart';
import 'package:google_maps_test/app/ui/pages/search_place/widgets/search_place_inputs.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class WhereAreYouGoingButton extends StatelessWidget {
  const WhereAreYouGoingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ocultar el boton para buscar la ubicacion
    // final hide = context.select<HomeController, bool>((controller) {
    //   final state = controller.state;

    //   return controller.originAndDestinationReady ||
    //       state.fetching ||
    //       state.pickFromMap != null;
    // });

    // if (hide) {
    //   return const ZoomPosition();
    // }

    return Container(
      padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
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
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                // 'A donde quieres ir',
                'Where are you going?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            onPressed: () => goToSearch(context),
          ),
        ],
      ),
    );
  }
}
