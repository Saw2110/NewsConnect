class BaseResponseModel<T> {
  final String? message;
  final T? data;

  BaseResponseModel({
    required this.message,
    required this.data,
  });

  factory BaseResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    return BaseResponseModel<T>(
      message: json['message'] as String?,
      data: json['data'] != null ? fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return {
      'message': message,
      'data': data != null ? toJsonT(data as T) : null,
    };
  }
}
