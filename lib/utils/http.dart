import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

Options cacheOptions = buildCacheOptions(const Duration(days: 1));

Dio _createHttp() {
  DioCacheManager _dioCacheManager = DioCacheManager(CacheConfig());
  Dio _dio = Dio();
  _dio.interceptors.add(_dioCacheManager.interceptor);

  return _dio;
}

Dio http = _createHttp();
