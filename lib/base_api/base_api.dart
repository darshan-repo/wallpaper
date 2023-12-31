import 'package:http/http.dart' as http;
import 'package:walper/libs.dart';

class BaseApi {
  static String baseUrl = "http://192.168.1.11:2200/api/";
  static String imgUrl = "http://192.168.1.11:2200/profile/";

  static Future getRequest(String path) async {
    final response = await http.get(
      Uri.parse("$baseUrl$path"),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {"status": false, "message": "Failed to load data from $path"};
    }
  }

  static Future postRequest(String path, {Map? data}) async {
    var headers = {'Content-Type': 'application/json'};
    http.Response response = await http.post(
      Uri.parse("$baseUrl$path"),
      headers: headers,
      body: json.encode(data),
    );
    Map responseBody = json.decode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return responseBody;
    } else {
      return responseBody;
    }
  }
}
