class FetchDataException {
  String? error;
  int? statusCode;
  List<String>? messages;

  FetchDataException({
    this.error,
    this.messages,
    this.statusCode,
  });

  factory FetchDataException.fromJson(dynamic json) {
    return FetchDataException(
      error: json['error'],
      messages: json['errors'],
      statusCode: json['statusCode'],
    );
  }
}
