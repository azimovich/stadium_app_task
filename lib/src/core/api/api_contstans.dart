import 'package:flutter/cupertino.dart';

@immutable
sealed class ApiConstants {
  /// Properties
  static bool isTester = true;
  static const duration = Duration(seconds: 30);
  static const apiGetStadiumList = "/pitches";
  static const contentType = "application/json";
  static bool validate(int? statusCode) => statusCode! <= 205;
  static const baseUrl = 'https://e359ad3eac197df4.mokky.dev';
}
