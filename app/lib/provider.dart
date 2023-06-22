import 'dart:developer';

import 'package:flutter/material.dart';
import 'data.dart';
import 'logic.dart';

class Dataflow with ChangeNotifier{
  final List<Meal> data = [];
  int view = -1;
  bool isHome = true;
  bool loading = true;

  void fetch(String value) async{
    List<Meal> temp = [];
    loading = true;

    try{
      temp = await Logic.fetch(value);
    }catch(error){
      log(error.toString());
    }
    
    loading = false;
    data.addAll(temp);
    notifyListeners();
  }

  void gridtap(int index){
    view = index;
    notifyListeners();
  }

  void setHome(bool value){
    isHome = value;
    notifyListeners();
  }

}

class Searchflow with ChangeNotifier{
  List<Search> list = [];

  void get(String query, [bool check = false]) async{
    await Logic.suggest(query, check)
    .then((value) => list = value);

    notifyListeners();
  }

  void onSearch(String query, Dataflow obj){
    obj.setHome(false);
    obj.data.clear();
    obj.fetch(query);
    get(query, true);

    notifyListeners();
  }
}