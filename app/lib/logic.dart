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
  String id, name, category, area, instructions, image;

  Meal(this.id, this.name, this.category, this.area, this.instructions, this.image);

  Meal.fromJson(Map<String, dynamic> data):
    id = data['idMeal'], 
    name = data['strMeal'],
    category = data['strCategory'],
    area = data['strArea'],
    instructions = data['strInstructions'],
    image = data['strMealThumb'];

}