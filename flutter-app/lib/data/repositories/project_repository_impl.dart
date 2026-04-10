import 'package:nexus/data/local/daos/project_dao.dart';
import 'package:nexus/data/local/daos/task_dao.dart';
import 'package:nexus/domain/repositories/project_repository.dart';
import 'package:nexus/shared/mock/mock_app_store.dart';
import 'package:nexus/shared/models/project_model.dart';
import 'package:nexus/shared/models/task_model.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  ProjectRepositoryImpl({
    required MockAppStore appStore,
    required ProjectDao projectDao,
    required TaskDao taskDao,
  })  : _appStore = appStore,
        _projectDao = projectDao,
        _taskDao = taskDao;

  final MockAppStore _appStore;
  final ProjectDao _projectDao;
  final TaskDao _taskDao;

  @override
  Future<ProjectModel?> getProjectById(String id) async {
    final List<ProjectModel> matches =
        _appStore.projects.where((ProjectModel item) => item.id == id).toList();
    return matches.isEmpty ? null : matches.first;
  }

  @override
  Future<List<ProjectModel>> getProjects() async {
    final List<ProjectModel> projects = _appStore.projects;
    await _projectDao.saveAll(projects);
    await _taskDao.saveAll(
      projects.expand((ProjectModel project) => project.tasks).toList(),
    );
    return projects;
  }

  @override
  Future<void> updateTaskStatus({
    required String projectId,
    required String taskId,
    required TaskStatus status,
  }) async {
    await _appStore.updateTaskStatus(
      projectId: projectId,
      taskId: taskId,
      newStatus: status,
    );
    await _projectDao.saveAll(_appStore.projects);
  }
}
