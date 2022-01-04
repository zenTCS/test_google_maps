import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_test/app/ui/pages/home/home_controller.dart';
import 'package:google_maps_test/app/ui/pages/home/widgets/buttons/timeline_tile.dart';
import 'package:provider/provider.dart';

class OriginAndDestination extends StatelessWidget {
  const OriginAndDestination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final originAndDestinationReady =
    //     context.select<HomeController, bool>((controller) {
    //   final state = controller.state;
    //   return state.origin != null && state.destination != null;
    // });

    return Positioned(
      left: 15,
      right: 15,
      top: 10,
      child: AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          final position = Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation);
          return SlideTransition(
            position: position,
            child: child,
          );
        },
        duration: const Duration(milliseconds: 300),
        child: const _View()// originAndDestinationReady ? const _View() : Container(),
      ),
    );
  }
}

class _View extends StatelessWidget {
  const _View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context, listen: false);
    // final state = controller.state;
    // final origin = state.origin!;
    // final destination = state.destination!;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CupertinoButton(
          //   onPressed: context.read<HomeController>().clearData,
          //   color: Colors.white,
          //   padding: const EdgeInsets.all(10),
          //   borderRadius: BorderRadius.circular(30),
          //   child: const Icon(
          //     Icons.close_rounded,
          //     color: Colors.black,
          //   ),
          // ),
          // const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      TimelineTile(
                        label: "Origen",
                        isTop: true,
                        // description: origin.address!,
                        // onPressed: () => goToSearch(context),
                        onPressed: () => null,
                      ),
                      TimelineTile(
                        label: "Destino",
                        isTop: false,
                        // description: destination.address!,
                        // onPressed: () => goToSearch(context, false),
                        onPressed: () => null,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(width: 10),
                // CupertinoButton(
                // child: const Icon(
                // Icons.sync,
                // color: Colors.blue,
                // ),
                // padding: const EdgeInsets.all(10),
                // borderRadius: BorderRadius.circular(30),
                // color: Colors.grey.withOpacity(0.2),
                // onPressed: controller.exchange,
                // ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                10,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
