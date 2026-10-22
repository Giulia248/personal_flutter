class MealModel {
  int? id;
  String? strMeal;
  String? strMealThumb;
  String? idMeal;
  String? strCountry;

  MealModel({
    this.id,
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
    this.strCountry,
  });

  MealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    strMeal = json['strMeal'];
    strMealThumb = json['strMealThumb'];
    idMeal = json['idMeal'];
    strCountry = json['strCountry'];
  }
}

class CategoryModel {
  int? id;
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  CategoryModel({
    this.id,
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }
}

enum MealEnum { random, category, recipes }
