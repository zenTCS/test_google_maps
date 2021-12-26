import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_maps_test/app/ui/pages/connectivity/connection_status_model.dart';
import 'package:provider/provider.dart';

class ConnetivityPage extends StatelessWidget {
  const ConnetivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Consumer<ConnectionStatusModel>(
          builder: (_, model, __){
            return Positioned(
              left: 0.0,
              right: 0.0,
              height: 32.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: model.isOnline ? null : const Color(0xFFEE4400),
                child: model.isOnline
                  ? null
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Reconectando al servidor",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        SizedBox(
                          width: 12.0,
                          height: 12.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        ),
                      ],
                    ),
              ),
            );
          }
        )
      ],
    );   
  }
}
