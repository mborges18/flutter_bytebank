
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

class Client {
  var clientHttp = HttpClient();
  var clientIo = IOClient();
  // Client httpClient() {
  //   if (Platform.isAndroid) {
  //     //return CronetClient.defaultCronetEngine();
  //     return CronetClient.fromCronetEngine(engine);
  //   }
  //   if (Platform.isIOS || Platform.isMacOS) {
  //     return CupertinoClient.defaultSessionConfiguration();
  //   }
  //   var client = HttpClient();
  //   return IOClient();
  // }

}