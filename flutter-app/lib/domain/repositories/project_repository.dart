import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/task_model.dart';

abstract class ProjectRepository {
  Future<List<ProjectModel>> getProjects();
  Future<ProjectModel?> getProjectById(String id);
  Future<void> updateTaskStatus({
    required String projectId,
    required String taskId,
    required TaskStatus status,
  });
}
