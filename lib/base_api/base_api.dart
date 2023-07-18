import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseApi {
  static String baseUrl = "http://192.168.1.7:2200/api/";

  static Future getRequest(String path) async {
    // var headers = {'Content-Type': 'application/json',};

    final response = await http.get(
      // headers: headers,
      Uri.parse("$baseUrl$path"),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {"status": false, "message": "Failed to load data from $path"};
    }
  }

// Future postRequest(String path, {Map? data}) async {
//   log(json.encode(data));
//   var headers = {'Content-Type': 'application/json'};
//   http.Response response = await http.post(
//     Uri.parse("$baseUrl$path"),
//     headers: headers,
//     body: json.encode(data),
//   );
//   Map responseBody = json.decode(response.body);
//   if (response.statusCode == 200) {
//     return responseBody;
//   } else {
//     log(response.reasonPhrase!);
//     return responseBody;
//   }
// }
}
