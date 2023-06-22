class Meal{
  String name, category, instructions, image;

  Meal(this.name, this.category, this.instructions, this.image);

  Meal.fromJson(Map<String, dynamic> data): 
    name = data['label'],
    category = data['dishType'][0],
    instructions = data['url'],
    image = data['image'];

}

class Search{
  String query;

  Search(this.query);
}
