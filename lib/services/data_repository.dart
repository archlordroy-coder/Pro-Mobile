import 'dart:convert';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:http/http.dart' as http;
import '../models/service.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/cyber_session.dart';
import 'local_cache_service.dart';

class DataRepository {
  // Replace with your actual deployed API URL
  final String _baseUrl = 'https://api.proinformatique.dev';
  final LocalCacheService _localCacheService = createLocalCacheService();

  // --- Services ---

  Future<List<Service>> getServices() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/api/services'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final services = data.map((item) => Service.fromMap(item)).toList();
        await _localCacheService.syncServices(services);
        return services;
      }
      return [];
    } catch (e) {
      debugPrint('Error getting services: $e');
      return [];
    }
  }

  Future<void> addService(Service service) async {
    try {
      await http.post(
        Uri.parse('$_baseUrl/api/services'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(service.toMap()),
      );
    } catch (e) {
      debugPrint('Error adding service: $e');
    }
  }

  // --- Products ---

  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/api/products'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final products = data.map((item) => Product.fromMap(item)).toList();
        await _localCacheService.syncProducts(products);
        return products;
      }
      return [];
    } catch (e) {
      debugPrint('Error getting products: $e');
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await http.post(
        Uri.parse('$_baseUrl/api/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toMap()),
      );
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  // --- Orders ---
  Future<List<dynamic>> getOrders() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/api/orders'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return [];
    } catch (e) {
      debugPrint('Error getting orders: $e');
      return [];
    }
  }

  Future<void> addOrder(Map<String, dynamic> order) async {
    try {
      await http.post(
        Uri.parse('$_baseUrl/api/orders'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(order),
      );
    } catch (e) {
      debugPrint('Error adding order: $e');
    }
  }
}
