import 'dart:convert';
import 'dart:developer';
import 'package:customerlist_app/app/data/models/response_data.dart';
import 'package:customerlist_app/app/modules/authentication/login/controller/auth_controller.dart';
import 'package:http/http.dart';

class NetworkCaller {
  Future<ResponseData> getRequestWithoutToken(String url) async {
    log(url);

    final Response response = await get(
      Uri.parse(url),
    );
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      log(decodedResponse["Email"]);
      return ResponseData(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: decodedResponse,
      );
    } else if (response.statusCode == 401) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
        errorMessage: "the user is invalid",
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }

  Future<ResponseData> getRequestWithToken(String url, {String? token}) async {
    log(url);

    final Response response = await get(
      Uri.parse(url),
      headers: {
        'Authorization': (token ?? AuthController.token).toString(),
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      log("print koro $decodedResponse");

      if (decodedResponse['Success'] == 1 && !decodedResponse["error"]) {
        return ResponseData(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        return ResponseData(
          isSuccess: false,
          statusCode: response.statusCode,
          responseData: decodedResponse,
          errorMessage:
              decodedResponse['CustomerList'] ?? 'Something went wrong',
        );
      }
    } else if (response.statusCode == 401) {
      await AuthController.clearAuthData();
      AuthController.goToLogin();
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: '',
      );
    }
  }
}
