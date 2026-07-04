import 'package:flutter/material.dart';
import '../models/service.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/cyber_session.dart';
import '../services/data_repository.dart';

class AppProvider with ChangeNotifier {
  final DataRepository _repository = DataRepository();

  List<Service> _services = [];
  List<Product> _products = [];
  List<Review> _reviews = [];
  List<CyberTicket> _cyberTickets = [];
  List<Computer> _computers = [];
  bool _isLoading = true;
  String _adminPassword = 'admin'; // Mot de passe par défaut

  List<Service> get services => _services;
  List<Product> get products => _products;
  List<Review> get reviews => _reviews;
  List<CyberTicket> get cyberTickets => _cyberTickets;
  List<Computer> get computers => _computers;
  bool get isLoading => _isLoading;

  AppProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _services = await _repository.getServices();
      _products = await _repository.getProducts();
      _reviews = await _repository.getReviews();
      _cyberTickets = await _repository.getCyberTickets();
      _computers = await _repository.getComputers();
    } catch (e) {
      debugPrint('Error fetching data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // --- Auth Methods ---
  bool verifyAdminPassword(String password) {
    return _adminPassword == password;
  }

  Future<void> changeAdminPassword(String newPassword) async {
    // Dans une vraie app, on stockerait ça de manière sécurisée ou dans Firestore
    _adminPassword = newPassword;
    notifyListeners();
  }

  // --- Services CRUD ---
  Future<void> addService(Service service) async {
    await _repository.addService(service);
    await fetchData();
  }

  Future<void> updateService(Service service) async {
    await _repository.updateService(service);
    await fetchData();
  }

  Future<void> deleteService(String id) async {
    await _repository.deleteService(id);
    await fetchData();
  }

  // --- Products CRUD ---
  Future<void> addProduct(Product product) async {
    await _repository.addProduct(product);
    await fetchData();
  }

  Future<void> updateProduct(Product product) async {
    await _repository.updateProduct(product);
    await fetchData();
  }

  Future<void> deleteProduct(String id) async {
    await _repository.deleteProduct(id);
    await fetchData();
  }

  // --- Reviews CRUD ---
  Future<void> addReview(Review review) async {
    await _repository.addReview(review);
    await fetchData();
  }

  Future<void> deleteReview(String id) async {
    await _repository.deleteReview(id);
    await fetchData();
  }

  List<Review> getReviewsForProduct(String productId) {
    return _reviews.where((r) => r.productId == productId).toList();
  }

  double getAverageRatingForProduct(String productId) {
    final productReviews = getReviewsForProduct(productId);
    if (productReviews.isEmpty) return 0.0;
    final total = productReviews.fold<double>(0, (acc, r) => acc + r.rating);
    return total / productReviews.length;
  }

  // --- Cyber Tickets CRUD ---
  Future<void> addCyberTicket(CyberTicket ticket) async {
    await _repository.addCyberTicket(ticket);
    await fetchData();
  }

  Future<void> updateCyberTicket(CyberTicket ticket) async {
    await _repository.updateCyberTicket(ticket);
    await fetchData();
  }

  Future<void> deleteCyberTicket(String id) async {
    await _repository.deleteCyberTicket(id);
    await fetchData();
  }

  // --- Computers CRUD ---
  Future<void> updateComputer(Computer computer) async {
    await _repository.updateComputer(computer);
    await fetchData();
  }

  Future<void> toggleComputerAvailability(String id) async {
    final computer = _computers.firstWhere((c) => c.id == id);
    final updated = Computer(
      id: computer.id,
      name: computer.name,
      isAvailable: !computer.isAvailable,
    );
    await updateComputer(updated);
  }
}
