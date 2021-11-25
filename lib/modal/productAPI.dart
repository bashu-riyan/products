import 'dart:convert';
import 'products.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static Future <List <ProductData>> getProductApi() async {
    String url = "https://fakestoreapi.com/products";
    final response = await http.get(Uri.parse(url));

    List data = jsonDecode(response.body);

    return ProductData.productsFromSnapshot(data);
  }
}




