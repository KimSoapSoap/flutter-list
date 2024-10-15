import 'package:intl/intl.dart';

void main() {
  String createdAt = "2024-10-11 09:17:31";
  DateTime dt = DateTime.parse(createdAt);
  //DateTime newDateTime = dt.add(Duration(hours: 1));
  String formatDt = DateFormat("yyyy.MM.dd").format(dt);
  print(formatDt);
}
