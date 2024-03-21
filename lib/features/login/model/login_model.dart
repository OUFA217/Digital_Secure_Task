// ignore_for_file: public_member_api_docs, sort_constructors_first

class LoginModel {
  final String password;
  final String emailAddress;
  String? userName;
  LoginModel({
    required this.password,
    required this.emailAddress,
    this.userName,
  });
}
