import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimelineTile extends StatelessWidget {
  final String label;
  // final String description;
  final VoidCallback onPressed;
  final bool isTop;

  const TimelineTile({
    Key? key,
    required this.onPressed,
    required this.label,
    // required this.description,
    required this.isTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Linea entre los circulos
        Positioned(
          top: isTop ? 40 : 0,
          //  top: isTop ? 14 : 0,
          bottom: isTop ? 0 : null,
          height: isTop ? null : 40,
          //      height: isTop ? null : 14,
          left: 6.5,
          child: Container(
            width: 1,
            color: Colors.black,
          ),
        ),
        if (!isTop)
          Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.black12,
            margin: const EdgeInsets.only(left: 30),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circulos
            Container(
              width: 14,
              height: 14,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: CupertinoButton(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'hola',
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: onPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
