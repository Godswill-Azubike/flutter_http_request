import 'package:http/http.dart' as http;

class ApiNetwork {
  static const apiUrl = "jsonplaceholder.typicode.com";

  Future<http.Response> fetchData(String path) {
    return http.get(Uri.https(apiUrl, path));
  }
}
