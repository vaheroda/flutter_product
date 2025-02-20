import 'dart:convert';
import 'package:http/http.dart' as http;
import 'product_model.dart';

class ApiService {
  static const String baseUrl =
      "https://ictiendaback.somee.com/api/v1/store/product"; // Reemplaza si es necesario

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception("Error al cargar los productos: ${response.statusCode}");
    }
  }
}
