import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'data.dart';


class Logic{
  static Future<List<Meal>> fetch(String request) async{
    List<Meal> fetched = [];

    try{
      String url = 'https://api.edamam.com/search?q=$request&app_id=66a6f291&app_key=6a6e34bdf1fdb66207d6acde954d6906&from=0&to=12&calories=500-1800';
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        Map<String, dynamic> json = jsonDecode(response.body);

        for(Map<String, dynamic> entry in json['hits']){
          fetched.add(Meal.fromJson(entry['recipe']));
        }
      }
    }catch(error){
      rethrow;
    }

    return fetched;
  }

  static Future<List<Search>> suggest(String query, [bool check = false]) async{
    await Hive.initFlutter('lib/history');
    Box suggestions = await Hive.openBox('temporary');

    List<Search> suggestion = [];

    if(check){
      if(suggestions.get(query) == null){
        suggestions.put(query, 1);
      }
      else{
        int k = suggestions.get(query);
        suggestions.delete(query);
        suggestions.put(query, k);
      }
    }
    else{
      query = query.trim();
      
      if(query == ''){
        for(String key in suggestions.keys){
          suggestion.add(Search(key));
        }
      }

      else{
        for(String key in suggestions.keys){
          if(RegExp(r'^' + query + r'.*$').hasMatch(key)){
            suggestion.add(Search(key));
          }
        }
      }
    }

    return suggestion;
  }
}

