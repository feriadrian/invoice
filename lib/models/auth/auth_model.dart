class SignInResponse {
   int? statusCode;
  Map<String, dynamic>? error;
  Map<String, dynamic>? data;

  SignInResponse({this.statusCode, this.error, this.data});
}

class SignUpResponse {
  int? statusCode;
  Map<String, dynamic>? error;
  String? data;

  String? message;
  SignUpResponse({this.statusCode, this.error, this.data});
}

class Verification {
   int? statusCode;
  Map<String, dynamic>? error;
  String? data;

  Verification({this.statusCode, this.error, this.data});
}