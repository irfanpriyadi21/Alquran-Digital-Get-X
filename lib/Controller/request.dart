import 'package:http/http.dart' as http;


const baseUrl = "https://quran-api.santrikoding.com/api/surah/";

class Request{
  final String? url;
  final dynamic body;

  Request({this.url, this.body});

  Future<http.Response> get(){
    return http.get(Uri.parse(baseUrl + url!)).timeout(
        const Duration(minutes: 2)
    );
  }

  Future<http.Response> post(){
    return http.post(Uri.parse(baseUrl+url!),
        body: body).timeout(const Duration(minutes: 2));
  }


}