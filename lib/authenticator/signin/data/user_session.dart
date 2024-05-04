

class UserSession {
  String idUser = "";
  static final UserSession _instance = UserSession._();

  UserSession._();

  static UserSession get instance => _instance;

  void setIdUser(String idUser) => idUser = idUser;
  String getIdUser() => idUser;
}