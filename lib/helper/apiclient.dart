import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

import 'requestutil.dart';

const String baseUrl = "http://myfrocks.com";
class ApiClient extends ChangeNotifier {
  String token;
  final Client _client;
  ApiClient(this._client);

  Future<Response> request(
      {@required RequestType requestType,
      @required String path,
      dynamic parameter = Nothing}) async {
    switch (requestType) {
      case RequestType.GET:
        print('$baseUrl/App/Admin/api/v1/$path');
        //return _client.get(Uri.http('$baseUrl', 'App/Admin/api/v1/$path'));
        return _client.get('$baseUrl/App/Admin/api/v1/$path');
      default:
        return throw RequestTypeNotFoundException(
            "The HTTP request mentioned is not found");
    }
  }
}
