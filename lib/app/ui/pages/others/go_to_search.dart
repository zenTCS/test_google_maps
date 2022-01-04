import 'package:flutter/material.dart'
    show BuildContext, MaterialPageRoute, Navigator, WidgetsBinding;
import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:google_maps_test/app/ui/pages/search_place/search_place_page.dart';
import 'package:provider/provider.dart';

void goToSearch(BuildContext context) async {
  final route = MaterialPageRoute<SearchResponse>(
    builder: (_) => const SearchPlacePage(),
  );
  
  await Navigator.push<SearchResponse>(
    context,
    route,
  );
}
