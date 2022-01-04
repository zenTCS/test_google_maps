import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmPlaceButton extends StatelessWidget {
  const ConfirmPlaceButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 60, left: 60),
        child: CupertinoButton(
          color: Colors.white,
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context), 
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
              'Confirm',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}