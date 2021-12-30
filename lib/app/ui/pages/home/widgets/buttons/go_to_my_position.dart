import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:provider/src/provider.dart';

class GoToMyPositionButton extends StatelessWidget {
  const GoToMyPositionButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 295),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,
            child: const Icon(Icons.gps_fixed, color: Colors.black,),
            onPressed: () => context.read<HomeController>().goToMyPosition(), 
            elevation: 0,
          ),
          const SizedBox(height: 120,)
        ],
      )
    );
  }
}