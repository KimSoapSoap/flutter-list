import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl_utils/intl_utils.dart';

String formatDate(String date) {
  DateTime dt = DateTime.parse(date);
  return DateFormat("yyyy.MM.dd").format(dt);
}

final navigatorKey = GlobalKey<NavigatorState>();
final dio = Dio(
  BaseOptions(
    baseUrl: "http://192.168.0.59:8080", // 서버 IP:PORT 입력
    contentType: "application/json; charset=utf-8",
  ),
);
