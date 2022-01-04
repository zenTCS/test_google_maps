import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/search_place/search_place_controller.dart';
import 'package:google_maps_test/app/ui/pages/search_place/widgets/confirm_place_button.dart';
import 'package:google_maps_test/app/ui/pages/search_place/widgets/search_place_inputs.dart';
import 'package:provider/provider.dart';

abstract class SearchResponse {}

class SearchPlacePage extends StatelessWidget {
  // final Place? initialOrigin, initialDestination;
  //final bool hasOriginFocus;

  const SearchPlacePage({
    Key? key,
    // this.initialOrigin,
    // this.initialDestination,
    // required this.hasOriginFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchPlaceController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: const [
                SearchInputs(),
                ConfirmPlaceButton(),
                // PickFromMapButton(),
                // Expanded(
                //   child: SearchResults(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
