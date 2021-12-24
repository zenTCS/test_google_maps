import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class ConnetivityPage extends StatelessWidget {
  const ConnetivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return OfflineBuilder(
          connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                child,
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  height: 32.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: connected ? null : const Color(0xFFEE4400),
                    child: connected
                      ? null
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Intentando conectar al internet",
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
                ),
              ],
            );
          },
        );
      },
    );
  }
}
