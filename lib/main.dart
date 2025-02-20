import 'package:flutter/material.dart';
import 'api_service.dart';
import 'product_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _products = [];
  bool _isLoading = false;

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Product> products = await ApiService.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar los productos")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Productos")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _isLoading ? null : _loadProducts,
            child: Text(_isLoading ? "Cargando..." : "Cargar Productos"),
          ),
          Expanded(
            child: _products.isEmpty
                ? Center(child: Text("Presiona el botón para ver productos"))
                : ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_products[index].name),
                        subtitle: Text(
                            "\$${_products[index].price.toStringAsFixed(2)}"),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
