import '../models/category_model.dart';
import '../models/product_model.dart';

class ProductRepositories {

 final List<ProductModel> _products=[

  
];
List<ProductModel> get product  =>_products;


List <String >barner=[
  'assets/banner.png','assets/banner.png','assets/banner.png','assets/banner.png'
];

  List<CategoryModel> categories=[
    CategoryModel(categoryname:'cooking' , categoryimage: 'assets/banana.png'),
    CategoryModel(categoryname:'meet' , categoryimage: 'assets/meet.png'),
    CategoryModel(categoryname:'lemonades' , categoryimage: 'assets/lemonades.png'),
    CategoryModel(categoryname:'snaks' , categoryimage: 'assets/snaks.png'),
    CategoryModel(categoryname:'vegetebales' , categoryimage: 'assets/vegetebales.png'),
     CategoryModel(categoryname:'eggs' , categoryimage: 'assets/eggs.png'),
     
    
  ];


}