import 'package:movir_app/core/utils/api_const.dart';

class ErrorModel {
  final int statusCode;
  final String statusMessage;
  final bool success;

  ErrorModel({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      statusCode: jsonData[ApiKeys.statusCode] ?? 0,
      statusMessage: jsonData[ApiKeys.statusMessage] ?? '',
      success: jsonData[ApiKeys.success] ?? false,
    );
  }
}
