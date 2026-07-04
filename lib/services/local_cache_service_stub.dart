import '../models/product.dart';
import '../models/service.dart';
import '../models/promotion.dart';
import 'local_cache_service.dart';

class NoopLocalCacheService implements LocalCacheService {
  @override
  Future<void> syncProducts(List<Product> products) async {}

  @override
  Future<void> syncServices(List<Service> services) async {}

  @override
  Future<void> cachePromotions(List<Promotion> promotions) async {}

  @override
  Future<List<Promotion>> getCachedPromotions() async => [];
}

LocalCacheService createLocalCacheServiceImpl() => NoopLocalCacheService();
