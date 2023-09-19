import 'dart:convert';



class CategoryModel {
  late String categoryname;
  late String categoryimage;
  CategoryModel({
    required this.categoryname,
    required this.categoryimage,
  });



  Map<String, dynamic> toMap() {
    return {
      'categoryname': categoryname,
      'categoryimage': categoryimage,
    };
  }

  factory CategoryModel.fromMap( Map <String, dynamic> map) {
    return CategoryModel(
      categoryname:  map['categoryname'],
      categoryimage: map['categotyimage']
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source));
}
