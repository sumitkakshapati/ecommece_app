import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/api/data_response.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';

class ProductRepository {
  final UserRepository userRepository;

  ProductRepository({required this.userRepository});

  Future<DataResponse<List<Product>>> getAllProducts() async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _response = await _dio.get(
        "${Constants.baseUrl}/products",
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to fetch products");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        final _tempList = List.from(_response.data["results"]);
        final _products = _tempList.map((e) => Product.fromJson(e)).toList();
        return DataResponse.success(_products);
      } else {
        return DataResponse.error(_response.data["message"]);
      }
    } on DioError catch (e) {
      return DataResponse.error(
          e.response?.data["message"] ?? "Unable to login user");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
