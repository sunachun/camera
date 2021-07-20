import 'dart:io';

import 'package:camera/models/place.dart';
import 'package:flutter/foundation.dart';
import 'package:camera/helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      //新しいプレイスを作成
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace); //リストに追加
    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path, //ローカルハードドライブに保存するために.pathは必要
    });
  }
}
