// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  int? id;
  String? title;
  String? description;
  int? status;

  TaskModel({this.id, this.title, this.description, this.status});

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    int? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, title, description, status];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status ?? 1,
    };
  }

  static TaskModel formJson(Map<String, dynamic> json) {
    return TaskModel()
      ..id = json["id"]
      ..title = json["title"]
      ..description = json["description"]
      ..status = json["status"];
  }
}
