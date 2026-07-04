import 'package:flutter/foundation.dart' show debugPrint;
import '../models/service.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/cyber_session.dart';
import 'api_service.dart';
import 'local_cache_service.dart';

class DataRepository {
  final ApiService _apiService = ApiService();
  final LocalCacheService _localCacheService = createLocalCacheService();

  // --- Services ---

  Future<List<Service>> getServices() async {
    try {
      final services = await _apiService.getServices();
      await _localCacheService.syncServices(services);
      return services;
    } catch (e) {
      debugPrint('Error getting services: $e');
      return [];
    }
  }

  Future<void> addService(Service service) async {
    try {
      await _apiService.addService(service);
    } catch (e) {
      debugPrint('Error adding service: $e');
    }
  }

  Future<void> updateService(Service service) async {
    try {
      await _apiService.updateService(service);
    } catch (e) {
      debugPrint('Error updating service: $e');
    }
  }

  Future<void> deleteService(String id) async {
    try {
      await _apiService.deleteService(id);
    } catch (e) {
      debugPrint('Error deleting service: $e');
    }
  }

  // --- Products ---

  Future<List<Product>> getProducts() async {
    try {
      final products = await _apiService.getProducts();
      await _localCacheService.syncProducts(products);
      return products;
    } catch (e) {
      debugPrint('Error getting products: $e');
      return [];
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      await _apiService.addProduct(product);
    } catch (e) {
      debugPrint('Error adding product: $e');
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await _apiService.updateProduct(product);
    } catch (e) {
      debugPrint('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _apiService.deleteProduct(id);
    } catch (e) {
      debugPrint('Error deleting product: $e');
    }
  }

  // --- Reviews ---

  Future<List<Review>> getReviews() async {
    try {
      return await _apiService.getReviews();
    } catch (e) {
      debugPrint('Error getting reviews: $e');
      return [];
    }
  }

  Future<List<Review>> getReviewsForProduct(String productId) async {
    try {
      return await _apiService.getReviewsForProduct(productId);
    } catch (e) {
      debugPrint('Error getting reviews for product: $e');
      return [];
    }
  }

  Future<void> addReview(Review review) async {
    try {
      await _apiService.addReview(review);
    } catch (e) {
      debugPrint('Error adding review: $e');
    }
  }

  Future<void> deleteReview(String id) async {
    try {
      await _apiService.deleteReview(id);
    } catch (e) {
      debugPrint('Error deleting review: $e');
    }
  }

  // --- Cyber Tickets ---

  Future<List<CyberTicket>> getCyberTickets() async {
    try {
      return await _apiService.getCyberTickets();
    } catch (e) {
      debugPrint('Error getting cyber tickets: $e');
      return [];
    }
  }

  Future<void> addCyberTicket(CyberTicket ticket) async {
    try {
      await _apiService.addCyberTicket(ticket);
    } catch (e) {
      debugPrint('Error adding ticket: $e');
    }
  }

  Future<void> updateCyberTicket(CyberTicket ticket) async {
    try {
      await _apiService.updateCyberTicket(ticket);
    } catch (e) {
      debugPrint('Error updating ticket: $e');
    }
  }

  Future<void> deleteCyberTicket(String id) async {
    try {
      await _apiService.deleteCyberTicket(id);
    } catch (e) {
      debugPrint('Error deleting ticket: $e');
    }
  }

  // --- Computers ---

  Future<List<Computer>> getComputers() async {
    try {
      return await _apiService.getComputers();
    } catch (e) {
      debugPrint('Error getting computers: $e');
      return [];
    }
  }

  Future<void> updateComputer(Computer computer) async {
    try {
      await _apiService.updateComputer(computer);
    } catch (e) {
      debugPrint('Error updating computer: $e');
    }
  }
}
