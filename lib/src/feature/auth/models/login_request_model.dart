class LoginRequestModel {
  const LoginRequestModel({required this.phoneNumber, required this.password});

  final String phoneNumber;
  final String password;

  Map<String, Object?> toJson() => {'phone_number': phoneNumber, 'password': password};

  @override
  String toString() => 'LoginRequestModel(phoneNumber: $phoneNumber, password: $password)';
}
