
import 'package:shared_preferences/shared_preferences.dart';

import '../../../util/string/strings.dart';

class SplashRepositoryImpl extends SplashRepository {

  @override
  Future<bool> checkIsKeepConnect() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isKeepConnected) ?? false;
  }

}

abstract class SplashRepository {
  Future<bool> checkIsKeepConnect();
}