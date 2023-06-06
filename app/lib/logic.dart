// ignore_for_file: control_flow_in_finally
import 'dart:convert';
import 'package:http/http.dart' as http;

class Api{
  static Future<List<Meal>> fetch({String? get}) async{
    String request = get == null ? 'random.php' : 'search.php?s=$get';
    List<Meal> fetched = [];

    try{
      String url = 'https://www.themealdb.com/api/json/v1/1/$request';
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        Map<String, dynamic> json = jsonDecode(response.body);

        for(Map<String, dynamic> entry in json['meals']){
          fetched.add(Meal.fromJson(entry));
        }
      }
    }catch(exception){
      rethrow;
    }finally{
      return fetched;
    }
  }
}

class Meal{
  String name, category, instructions, image;

  Meal(this.name, this.category, this.instructions, this.image);

  Meal.fromJson(Map<String, dynamic> data): 
    name = data['strMeal'],
    category = data['strCategory'],
    instructions = data['strInstructions'],
    image = data['strMealThumb'];

}