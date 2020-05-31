import 'package:http/http.dart'as http;
import 'package:newsapp/modules/category.dart';
import 'dart:convert';
import 'package:newsapp/utilities/api_utilities.dart';
class CategoriesApi {
   Future<List<Category>> fetchAllCategories () async{
     List<Category> categories = List<Category>();
     String categoriesApi = base_api+all_categories_api;
     var response = await http.get(categoriesApi);
     if(response.statusCode==200){
       var jsonData = jsonDecode(response.body);
       var data = jsonData["data"];
       for(var item in data){
         Category category = Category(item["id"].toString(),item["title"].toString());
         categories.add(category);
       }
     }
     return categories ;
   }

}