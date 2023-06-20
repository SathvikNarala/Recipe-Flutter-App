class Meal{
  String name, category, instructions, image;

  Meal(this.name, this.category, this.instructions, this.image);

  Meal.fromJson(Map<String, dynamic> data): 
    name = data['strMeal'],
    category = data['strCategory'],
    instructions = data['strInstructions'],
    image = data['strMealThumb'];

}

class Search{
  String query;

  Search(this.query);
}
