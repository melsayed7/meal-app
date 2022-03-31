class MealModel
{

  String? image ;
  String? title ;
  String? description ;
  String? mealCategory ;
  String? numOfMeals;
  String? price;
  String? mealId;


  MealModel({
    this.image,
    this.title,
    this.description,
    this.mealCategory,
    this.numOfMeals,
    this.price,
    this.mealId,
  });

  MealModel.fromJson(Map<String , dynamic>? json)
  {
    image = json!['image'];
    title = json['title'];
    description = json['description'];
    mealCategory = json['mealCategory'];
    numOfMeals = json['numOfMeals'];
    price = json['price'];
    mealId = json['mealId'];
  }

  Map<String , dynamic> toMap()
  {
    return
      {
        'image' : image ,
        'title' : title ,
        'description' : description ,
        'mealCategory' : mealCategory ,
        'numOfMeals' : numOfMeals ,
        'price' : price ,
        'mealId':mealId,
      };
  }
}