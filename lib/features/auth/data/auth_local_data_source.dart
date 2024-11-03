import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this.sf);
  final SharedPreferences sf;
  Future<void> saveToken(
     String accessToken,
  ) async {
    await sf.setString(AuthDataConstants.accessToken, accessToken);
  }

  Future<String?> getToken() async {
    return sf.getString(AuthDataConstants.accessToken);
  }

  Future<void> deleteToken() async {
    await sf.remove(AuthDataConstants.accessToken);
  }
}
