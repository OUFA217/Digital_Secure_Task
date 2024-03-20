// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginModel {
  String? userName;
  String password;
  String emailAddress;
  LoginModel({
    this.userName,
    required this.password,
    required this.emailAddress,
  });

  LoginModel copyWith({
    String? userName,
    String? password,
    String? emailAddress,
  }) {
    return LoginModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
      'emailAddress': emailAddress,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      userName: map['userName'] as String,
      password: map['password'] as String,
      emailAddress: map['emailAddress'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LoginModel(userName: $userName, password: $password, emailAddress: $emailAddress)';

  @override
  bool operator ==(covariant LoginModel other) {
    if (identical(this, other)) return true;

    return other.userName == userName &&
        other.password == password &&
        other.emailAddress == emailAddress;
  }

  @override
  int get hashCode =>
      userName.hashCode ^ password.hashCode ^ emailAddress.hashCode;
}
