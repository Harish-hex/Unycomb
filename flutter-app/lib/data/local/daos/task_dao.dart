import 'package:nexus/shared/models/task_model.dart';

class TaskDao {
  List<TaskModel> _tasks = <TaskModel>[];

  Future<void> saveAll(List<TaskModel> tasks) async {
    _tasks = List<TaskModel>.from(tasks);
  }

  Future<List<TaskModel>> fetchAll() async {
    return List<TaskModel>.from(_tasks);
  }
}
