import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/api/data_response.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:ecommerce_app/features/homepage/model/cart.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';

class ProductRepository {
  final UserRepository userRepository;

  ProductRepository({required this.userRepository});

  final List<Product> _products = [];

  List<Product> get products => _products;

  int _totalProductCount = -1;
  int _currentProductpage = 1;
  String _oldQuery = "";

  Future<DataResponse<List<Product>>> getAllProducts(
      {bool isLoadMore = false, required String query}) async {
    try {
      if (isLoadMore &&
          _products.length == _totalProductCount &&
          _oldQuery == query) {
        return DataResponse.success(_products);
      }

      if (isLoadMore && _oldQuery == query) {
        _currentProductpage++;
      } else {
        _products.clear();
        _totalProductCount = -1;
        _currentProductpage = 1;
        _oldQuery = query;
      }

      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final Map<String, dynamic> _param = {
        "page": _currentProductpage,
      };

      if (query.isNotEmpty) {
        _param["q"] = query;
      }

      final _response = await _dio.get(
        "${Constants.baseUrl}/products",
        queryParameters: _param,
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        _currentProductpage--;
        return DataResponse.error("Unable to fetch products");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        final _tempList = List.from(_response.data["results"]);
        _totalProductCount = _response.data["total"];
        final _tempProducts =
            _tempList.map((e) => Product.fromJson(e)).toList();
        _products.addAll(_tempProducts);
        return DataResponse.success(_tempProducts);
      } else {
        _currentProductpage--;
        return DataResponse.error(_response.data["message"]);
      }
    } on DioError catch (e) {
      _currentProductpage--;
      return DataResponse.error(
          e.response?.data["message"] ?? "Unable to login user");
    } catch (e) {
      _currentProductpage--;
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<Product>> getProductDetails(String productId) async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _response = await _dio.get(
        "${Constants.baseUrl}/products/$productId",
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to fetch products");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        final _product = Product.fromJson(_response.data["results"]);
        return DataResponse.success(_product);
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

  Future<DataResponse<bool>> addToCart(String productId) async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _body = {
        "quantity": 1,
        "product": productId,
      };

      final _response = await _dio.post(
        "${Constants.baseUrl}/cart",
        data: _body,
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to fetch products");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        return DataResponse.success(true);
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

  Future<DataResponse<List<CartModel>>> getAllCartProducts() async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _response = await _dio.get(
        "${Constants.baseUrl}/cart",
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to fetch cart item");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        final _tempList = List.from(_response.data["results"]);
        final _cartItems = _tempList.map((e) => CartModel.fromJson(e)).toList();
        return DataResponse.success(_cartItems);
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

  Future<DataResponse<int>> getCartTotalAmount() async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _response = await _dio.get(
        "${Constants.baseUrl}/cart/total",
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to fetch cart item");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        return DataResponse.success(_response.data["totalPrice"]);
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

  Future<DataResponse<CartModel>> updateCartItemQuantity(
      String cartId, int quantity) async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _body = {"quantity": quantity};

      final _response = await _dio.put(
        "${Constants.baseUrl}/cart/$cartId",
        data: _body,
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to udpate quantity");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        final _item = CartModel.fromJson(_response.data["results"]);
        return DataResponse.success(_item);
      } else {
        return DataResponse.error(_response.data["message"]);
      }
    } on DioError catch (e) {
      return DataResponse.error(
          e.response?.data["message"] ?? "Unable to update quantity");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> checkout({
    required String name,
    required String address,
    required String phone,
    required String city,
  }) async {
    try {
      final _dio = Dio();

      final _headers = {
        "Authorization": "Bearer ${userRepository.token}",
      };

      final _body = {
        "address": address,
        "city": city,
        "phone": phone,
        "full_name": name,
      };

      final _response = await _dio.post(
        "${Constants.baseUrl}/orders",
        data: _body,
        options: Options(
          headers: _headers,
        ),
      );
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to udpate quantity");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        return DataResponse.success(true);
      } else {
        return DataResponse.error(_response.data["message"]);
      }
    } on DioError catch (e) {
      return DataResponse.error(
          e.response?.data["message"] ?? "Unable to update quantity");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }
}
