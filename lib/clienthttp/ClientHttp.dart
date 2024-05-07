
import 'dart:convert';
import 'package:flutter_bitybank/util/string/strings.dart';
import 'package:http/http.dart';
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientHttps {
   HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [HttpLogger(logLevel: LogLevel.BODY),]);
   static Uri setUrl(String? url) => Uri.parse('https://api-credit-card-792613245.development.catalystserverless.com/server/$url');
   static SharedPreferences? prefs;

   ClientHttps() {
      _init();
   }

   void _init() async {
      prefs = await SharedPreferences.getInstance();
   }

   static Map<String, String> _setHeaders() {
     return <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
       'X-Auth-Token': prefs?.getString(userToken) ?? "",
       'X-User-Id': prefs?.getString(userId) ?? "",
     };
   }

   Future<Response> post(String url, dynamic body) {
        return http.post(
         setUrl(url),
         headers: _setHeaders(),
         body: jsonEncode(body.toJson()),
      );
   }

   Future<Response> put(String url, dynamic body) {
     return http.put(
       setUrl(url),
       headers: _setHeaders(),
       body: jsonEncode(body.toJson()),
     );
   }

   Future<Response> get(String url) {
     return http.get(
       setUrl(url),
       headers: _setHeaders(),
     );
   }

   Future<Response> delete(String url) {
     return http.delete(
       setUrl(url),
       headers: _setHeaders(),
     );
   }

}