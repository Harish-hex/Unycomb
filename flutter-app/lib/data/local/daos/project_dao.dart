import 'package:nexus/shared/models/project_model.dart';

class ProjectDao {
  List<ProjectModel> _projects = <ProjectModel>[];

  Future<void> saveAll(List<ProjectModel> projects) async {
    _projects = List<ProjectModel>.from(projects);
  }

  Future<List<ProjectModel>> fetchAll() async {
    return List<ProjectModel>.from(_projects);
  }
}
