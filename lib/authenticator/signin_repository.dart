import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

class SignInRepository {

  Future<String> signIn(String email, String password) async {
    var clientHttp = HttpClient();
    var request =  await clientHttp.post(
        "api-credit-card-792613245.development.catalystserverless.com",
        44088,
        "signin"
    );
    request.headers.set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    request.write('{"email": $email, "password": $password}');

    var response = await request.close();

    final stringData = await response.transform(utf8.decoder).join();
    print('SignInRepository-------------------------------${response.statusCode}');
    print('SignInRepository-------------------------------$response');
    print('SignInRepository-------------------------------$stringData');
    return stringData;
  }

  Future<String> signIns(String email, String password) async {
    var clientHttp = IOClient();
    Map<String,String> headers = {
      'Content-Type':'application/json',
      'authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    var request =  await clientHttp.post(
        Uri.parse("https://api-credit-card-792613245.development.catalystserverless.com/server/signin"),
        body: {"email": email, "password": password}
    );

    print('SignInRepository-------------------------------${request.statusCode}');
    print('SignInRepository-------------------------------$request');
    print('SignInRepository-------------------------------${request.body}');
    return request.body;
  }
}
