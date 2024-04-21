class SignInRespository {
  Future<String> signIn(String email, String password) async {
    Future.delayed(const Duration(seconds: 3));
    print(
        'Dados---------------------token-132fsfd987dfs9879fgdf4685678687u987 ' +
            email +
            " " +
            password);
    return "token-132fsfd987dfs9879fgdf4685678687u987";
  }
}
