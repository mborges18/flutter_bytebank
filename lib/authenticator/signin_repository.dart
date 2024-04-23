import 'dart:convert';
import 'package:http/http.dart' as http;

class SignInRepository {

  Future<String> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://api-credit-card-792613245.development.catalystserverless.com/server/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String> {
        "email": email, "password": password
      }),
    );

    return response.body;
  }
}
