import 'package:http/http.dart' as http;

const base_url = "https://moviesdemoapi.azurewebsites.net/movies?title=";
String title = "";

class Api {
  static Future getMoviesByTitle({String title = ''}) async {
    var url = base_url + title;
    http.Response response = await http.get(url);
    return response;
  }
}
