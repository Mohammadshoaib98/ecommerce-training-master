import 'package:flutter/material.dart';

abstract class BaseModel {
  abstract int? id;
  abstract String tableName;
  Map<String, Object?> toMap();
  BaseModel fromMap(Map<String, Object?> data);
}
