import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? value) => value?.toDate().toLocal();

  @override
  Timestamp? toJson(DateTime? value) =>
      value == null ? null : Timestamp.fromDate(value);
}
