import 'package:dio/dio.dart';
import '../models/location.dart';

class LocationRepository {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://openapi.naver.com/v1/search/local.json?display=5';

  final String _clientId = 'C_CHIBhM3n1Il0ewTpbn';
  final String _clientSecret = 'HrihlHivcK';

  Future<List<Location>> search(String keyword) async {
    final response = await _dio.get(
      '$_baseUrl&query=$keyword',
      options: Options(
        headers: {
          'X-Naver-Client-Id': _clientId,
          'X-Naver-Client-Secret': _clientSecret,
        },
      ),
    );

    final items = response.data['items'] as List;
    return items.map((e) => Location.fromJson(e)).toList();
  }
}
