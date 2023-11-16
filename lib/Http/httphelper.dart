import 'package:http/http.dart' as http;
import 'dart:io';

class HttpHelper {
  //final String _urlKey = "?api_key=fca85ddcf1dfc3b9102036e2d7561c42";
  final String _urlBase = "https://fakestoreapi.com/products";

  Future<String> getMovie() async {
    var url = Uri.parse(_urlBase);
    http.Response result = await http.get(url);
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }
    return result.statusCode.toString();
  }
}
