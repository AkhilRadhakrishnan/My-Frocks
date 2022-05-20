import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:myfrocks/models/mads.dart';
import 'package:myfrocks/models/mmodel.dart';
import 'package:myfrocks/models/mmodelsize.dart';
import 'package:myfrocks/models/mmodelsizedetail.dart';
import 'package:myfrocks/models/mqas.dart';
import 'package:myfrocks/models/mtips.dart';
import 'package:myfrocks/models/mvideos.dart';

import 'apiclient.dart';
import 'requestutil.dart';

class FrocksApis {
  FrocksApis._privateConstructor();
  static final FrocksApis _apiResponse = FrocksApis._privateConstructor();
  factory FrocksApis() => _apiResponse;

  ApiClient client = ApiClient(Client());

  StreamController<Result> _addStream;
  Stream<Result> hasAdded() => _addStream.stream;

  void init() => _addStream = StreamController();

  Future<Result> getAds(String type) async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_carousel_images.php?status=1");
        print('getModels: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        print(jsn);
        if (jsn["status"] == "success") {
          return Result<MADs>.success(
              MADs.fromRawJson(jsn['data']));
        } else {
          return Result.error("Ads not available");
        }
      } else {
        return Result.error("Ads not available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  Future<Result> getModels(String type) async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_dress_models.php?type=$type");
        print('getModels: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        print(jsn);
        if (jsn["status"] == "success") {
          return Result<MModels>.success(
              MModels.fromRawJson(jsn['data']));
        } else {
          return Result.error("Models not available");
        }
      } else {
        return Result.error("Models not available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  Future<Result> getModelSizes(String type) async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_size_charts.php?type=$type");
        print('getModelSizes: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        //print(jsn);
        if (jsn["status"] == "success") {
          return Result<MModelSizes>.success(
              MModelSizes.fromRawJson(jsn['data']));
        } else {
          return Result.error("Model Size not available");
        }
      } else {
        return Result.error("Model Size not available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  Future<Result> getModelSizeDetails(String type, String modelid, String sizeid) async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_dress_size_info.php?type=$type&model_id=$modelid&size_id=$sizeid");
        print('getModelSizeDetails: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        //print(jsn);
        if (jsn["status"] == "success") {
          return Result<MModelSizeDetails>.success(
              MModelSizeDetails.fromRawJson(jsn['data']));
        } else {
          return Result.error("Model Size Details not available");
        }
      } else {
        return Result.error("Models Size Details available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  Future<Result> getVideos(String type) async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_videos.php?type=$type");
        print('getVideos: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        //print(jsn);
        if (jsn["status"] == "success") {
          return Result<MVideos>.success(
              MVideos.fromRawJson(jsn['data']));
        } else {
          return Result.error("Videos not available");
        }
      } else {
        return Result.error("Videos not available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  Future<Result> getMaintanences(String type) async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_tips.php?type=$type");
        print('getMaintanences: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        //print(jsn);
        if (jsn["status"] == "success") {
          return Result<MTips>.success(
              MTips.fromRawJson(jsn['data']));
        } else {
          return Result.error("Tips not available");
        }
      } else {
        return Result.error("Tips not available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  Future<Result> getTips(String type) async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_tips.php?type=$type");
        print('getTips: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        //print(jsn);
        if (jsn["status"] == "success") {
          return Result<MTips>.success(
              MTips.fromRawJson(jsn['data']));
        } else {
          return Result.error("Tips not available");
        }
      } else {
        return Result.error("Tips not available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  Future<Result> getQAs() async {
    try {
      final response = await client.request(
          requestType: RequestType.GET, path: "list_qa.php?status=1");
        print('getQAs: ' + response.body);
      if (response.statusCode == 200) {
        var jsn = json.decode(response.body);
        //print(jsn);
        if (jsn["status"] == "success") {
          return Result<MQAs>.success(
              MQAs.fromRawJson(jsn['data']));
        } else {
          return Result.error("QAs not available");
        }
      } else {
        return Result.error("QAs not available");
      }
    } on SocketException catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nCheck your network or try again later.");
    } catch (error) {
      print(error);
      return Result.error("We can't connect to the service.\nPlease try again later.");
    }
  }

  void dispose() => _addStream.close();
}
