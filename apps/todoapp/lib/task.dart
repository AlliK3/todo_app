import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task{
  String title;
  bool isChecked = false;

  Task(String this.title, bool this.isChecked);

  void toggleIsChecked(){
    isChecked = !isChecked;
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}