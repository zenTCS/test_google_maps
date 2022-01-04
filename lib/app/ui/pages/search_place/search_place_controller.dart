import 'dart:async';

import 'package:flutter/cupertino.dart';

class SearchPlaceController extends ChangeNotifier{
  String _query = '';
  
  final originFocusNode = FocusNode();
  final destinationFocusNode = FocusNode();
  final originController = TextEditingController();
  final destinationController = TextEditingController();
  
  Timer? _debouncer;

  String? onQueryChanged(String text) {
    _query = text;
    _debouncer?.cancel();
    _debouncer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (_query.length >= 3) {
          print("🚩Call to API");
          // final currentPosition = CurrentPosition.i.value;
          // if (currentPosition != null) {
          //   _searchRepository.search(query, currentPosition);
          // }
        } else {
          print("🚩 Cancell API call");
          clearQuery();
        }
      },
    );
  }

  void clearQuery() {
    if (originFocusNode.hasFocus) {
      originController.text = '';
    }
    if (destinationFocusNode.hasFocus) {
      destinationController.text = '';
    }
    // _searchRepository.cancel();
    // _places = [];
    // if (_originHasFocus) {
    //   _origin = null;
    // } else {
    //   _destination = null;
    // }
    notifyListeners();
  }
}