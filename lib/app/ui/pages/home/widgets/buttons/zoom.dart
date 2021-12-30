import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZoomPosition extends StatelessWidget {
  const ZoomPosition({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 25,
      right: 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CupertinoButton(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.add,
              color: Colors.black87,
            ),
            onPressed: context.read<HomeController>().zoomIn,
          ),
          const SizedBox(height: 5),
          CupertinoButton(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: const Icon(
              Icons.remove,
              color: Colors.black87,
            ),
            onPressed: context.read<HomeController>().zoomOut,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
