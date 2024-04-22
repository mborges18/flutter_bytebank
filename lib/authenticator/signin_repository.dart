import 'dart:convert';
import 'dart:io';

import 'package:flutter_bitybank/authenticator/signin_state.dart';
import 'package:http/io_client.dart';

class SignInRepository {


  Future<String> signIn(String email, String password) async {
    var clientHttp = HttpClient();
    var request =  await clientHttp.post("https://api-credit-card-792613245.development.catalystserverless.com/server/", 80, "signin");
    var response = await request.close();
    final stringData = await response.transform(utf8.decoder).join();
    return stringData;
  }

  Future<String> signIns(String email, String password) async => Future.delayed(const Duration(seconds: 3), () {
      return "token-132fsfd987dfs9879fgdf4685678687u987";
    });
}
