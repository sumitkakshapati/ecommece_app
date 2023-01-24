import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/api/data_response.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:ecommerce_app/features/orders/model/orders.dart';

class OrderRepository {
  final UserRepository userRepository;

  List<Orders> _orders = [];

  OrderRepository({required this.userRepository});

  Future<DataResponse<List<Orders>>> fetchAllOrders() async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _response = await _dio.get(
        "${Constants.baseUrl}/orders",
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to orders");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        final List<Orders> _results = List.from(_response.data["results"])
            .map((e) => Orders.fromJson(e))
            .toList();
        return DataResponse.success(_results);
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
