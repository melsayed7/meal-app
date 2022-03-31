import 'meal_model.dart';

class MealsUserModel
{
  String? name ;
  String? phone ;
  String? email ;
  String? uId ;
  List<String>? fav ;

  MealsUserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.fav
  });

  MealsUserModel.fromJson(Map<String , dynamic>? json)
  {
    name = json!['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    fav = json['fav'].cast<String>();

  }

  Map<String , dynamic> toMap()
  {
    return
      {
        'name' : name ,
        'phone' : phone ,
        'email' : email ,
        'uId' : uId ,
        'fav':fav,
      };
  }
}