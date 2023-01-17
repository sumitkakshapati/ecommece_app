import 'package:dio/dio.dart';
import 'package:ecommerce_app/common/api/data_response.dart';
import 'package:ecommerce_app/common/constants.dart';
import 'package:ecommerce_app/common/utils/shared_pref.dart';
import 'package:ecommerce_app/features/auth/model/user.dart';

class UserRepository {
  User? _user;
  String _token = "";

  User? get user => _user;
  String get token => _token;

  Future<void> init() async {
    _user = await SharedPref.user;
    _token = await SharedPref.userToken ?? "";
  }

  Future<DataResponse<bool>> signUp({
    required String fullName,
    required String address,
    required String password,
    required String email,
    required String phone,
  }) async {
    try {
      final _body = {
        "name": fullName,
        "email": email,
        "password": password,
        "phone": phone,
        "address": address
      };

      final _response =
          await Dio().post("${Constants.baseUrl}/auth/register", data: _body);
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to register");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        return DataResponse.success(true);
      } else {
        return DataResponse.error(_response.data["message"]);
      }
    } on DioError catch (e) {
      return DataResponse.error(
          e.response?.data["message"] ?? "Unable to register user");
    } catch (e) {
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<User>> login(
      {required String email, required String password}) async {
    try {
      final _body = {"email": email, "password": password};

      final _response =
          await Dio().post("${Constants.baseUrl}/auth/login", data: _body);
      if (_response.statusCode == null) {
        return DataResponse.error("Unable to login");
      }
      if (_response.statusCode! >= 200 && _response.statusCode! < 300) {
        final _tempuser = User.fromJson(_response.data["results"]);
        final String _authenticationToken = _response.data["token"];
        _user = _tempuser;
        _token = _authenticationToken;
        await SharedPref.setUser(_tempuser);
        await SharedPref.setuserToken(_token);
        return DataResponse.success(_tempuser);
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

  Future<void> logout() async {
    _token = "";
    _user = null;
    await SharedPref.deleteUser();
    await SharedPref.deleteUserToken();
  }
}
