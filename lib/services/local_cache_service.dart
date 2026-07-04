import '../models/product.dart';
import '../models/service.dart';
import '../models/promotion.dart';
import 'local_cache_service_stub.dart'
    if (dart.library.io) 'local_cache_service_io.dart';

abstract class LocalCacheService {
  Future<void> syncServices(List<Service> services);
  Future<void> syncProducts(List<Product> products);
  Future<void> cachePromotions(List<Promotion> promotions);
  Future<List<Promotion>> getCachedPromotions();
}

LocalCacheService createLocalCacheService() => createLocalCacheServiceImpl();
