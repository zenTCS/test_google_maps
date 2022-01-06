import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/search_place/search_place_controller.dart';
import 'package:provider/provider.dart';

class SearchInputs extends StatelessWidget {
  const SearchInputs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Column(
        children: [
          _origenInputs(context),
          const SizedBox(height: 20),
          _destinyInputs(context),
        ],
      ),
    );
  }

  Widget _origenInputs(BuildContext context){
    final controller =
        Provider.of<SearchPlaceController>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, right: 10.0, left: 10.0),
        child: TextFormField(
          controller: controller.originController,
          focusNode: controller.originFocusNode,
          decoration: InputDecoration(
            labelText: 'Origen',
            labelStyle: const TextStyle(color: Colors.grey),
            icon: const Icon(Icons.home_rounded, color: Color(0xFF9E9E9E)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
          ),
          onChanged: (String value){
            controller.onQueryChanged(value);
          },
        ),
      ),
    );
  }

  Widget _destinyInputs(BuildContext context){
    final controller =
        Provider.of<SearchPlaceController>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0),
        child: TextFormField(
          controller: controller.destinationController,
          focusNode: controller.destinationFocusNode,
          decoration: InputDecoration(
            labelText: 'Destino',
            labelStyle: const TextStyle(color: Colors.grey),
            icon: const Icon(Icons.deck_sharp, color: Color(0xFF9E9E9E)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
          ),
          onChanged: (String value){
            controller.onQueryChanged(value);
          },
        ),
      ),
    );
  }
}
