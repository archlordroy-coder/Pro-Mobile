import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show debugPrint;
import '../models/service.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/cyber_session.dart';

class ApiService {
  final String baseUrl = 'https://api.proinformatique.dev';
  
  // Helper pour les requêtes HTTP
  Future<http.Response> _get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      debugPrint('GET Error ($endpoint): $e');
      rethrow;
    }
  }

  Future<http.Response> _post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      debugPrint('POST Error ($endpoint): $e');
      rethrow;
    }
  }

  Future<http.Response> _put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      debugPrint('PUT Error ($endpoint): $e');
      rethrow;
    }
  }

  Future<http.Response> _delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      return response;
    } catch (e) {
      debugPrint('DELETE Error ($endpoint): $e');
      rethrow;
    }
  }

  // --- Services ---

  Future<List<Service>> getServices() async {
    try {
      final response = await _get('/services');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Service.fromMap(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting services: $e');
      return [];
    }
  }

  Future<void> addService(Service service) async {
    try {
      await _post('/services', service.toMap());
    } catch (e) {
      debugPrint('Error adding service: $e');
    }
  }

  Future<void> updateService(Service service) async {
    try {
      await _put('/services/${service.id}', service.toMap());
    } catch (e) {
      debugPrint('Error updating service: $e');
    }
  }

  Future<void> deleteService(String id) async {
    try {
      await _delete('/services/$id');
    } catch (e) {
      debugPrint('Error deleting service: $e');
    }
  }

  // --- Products ---

  Future<List<Product>> getProducts() async {
    try {
      final response = await _get('/products');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromMap(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting products: $e');
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _post('/products', product.toMap());
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _put('/products/${product.id}', product.toMap());
    } catch (e) {
      debugPrint('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _delete('/products/$id');
    } catch (e) {
      debugPrint('Error deleting product: $e');
    }
  }

  // --- Reviews ---

  Future<List<Review>> getReviews() async {
    try {
      final response = await _get('/reviews');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Review.fromMap(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting reviews: $e');
      return [];
    }
  }

  Future<List<Review>> getReviewsForProduct(String productId) async {
    try {
      final response = await _get('/reviews?product_id=$productId');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Review.fromMap(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting reviews for product: $e');
      return [];
    }
  }

  Future<void> addReview(Review review) async {
    try {
      await _post('/reviews', review.toMap());
    } catch (e) {
      debugPrint('Error adding review: $e');
    }
  }

  Future<void> deleteReview(String id) async {
    try {
      await _delete('/reviews/$id');
    } catch (e) {
      debugPrint('Error deleting review: $e');
    }
  }

  // --- Cyber Tickets ---

  Future<List<CyberTicket>> getCyberTickets() async {
    try {
      final response = await _get('/cyber-tickets');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CyberTicket.fromMap(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting cyber tickets: $e');
      return [];
    }
  }

  Future<void> addCyberTicket(CyberTicket ticket) async {
    try {
      await _post('/cyber-tickets', ticket.toMap());
    } catch (e) {
      debugPrint('Error adding ticket: $e');
    }
  }

  Future<void> updateCyberTicket(CyberTicket ticket) async {
    try {
      await _put('/cyber-tickets/${ticket.id}', ticket.toMap());
    } catch (e) {
      debugPrint('Error updating ticket: $e');
    }
  }

  Future<void> deleteCyberTicket(String id) async {
    try {
      await _delete('/cyber-tickets/$id');
    } catch (e) {
      debugPrint('Error deleting ticket: $e');
    }
  }

  // --- Computers ---

  Future<List<Computer>> getComputers() async {
    try {
      final response = await _get('/computers');
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Computer.fromMap(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error getting computers: $e');
      return [];
    }
  }

  Future<void> updateComputer(Computer computer) async {
    try {
      await _put('/computers/${computer.id}', computer.toMap());
    } catch (e) {
      debugPrint('Error updating computer: $e');
    }
  }
}
